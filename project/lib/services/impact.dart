import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pim_group/services/sleepData.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:pim_group/utils/server_strings.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/root.dart';
import 'package:pim_group/models/entities/sleeps.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/models/entities/drink.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/pages/HomePage.dart';

List<int> deep = [];
List<int> light = [];
List<int> rem = [];
List<int> wake = [];

final first_day = DateFormat('y-M-d')
    .format(DateTime.now().subtract(const Duration(days: 5)));

final second_day = DateFormat('y-M-d')
    .format(DateTime.now().subtract(const Duration(days: 4)));

final third_day = DateFormat('y-M-d')
    .format(DateTime.now().subtract(const Duration(days: 3)));

final fourth_day = DateFormat('y-M-d')
    .format(DateTime.now().subtract(const Duration(days: 2)));

final fifth_day = DateFormat('y-M-d')
    .format(DateTime.now().subtract(const Duration(days: 1)));

List<String> days = [first_day, second_day, third_day, fourth_day, fifth_day];

class ImpactService extends StatelessWidget {
  ImpactService(this.prefs);
  Preferences prefs; 

  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> _refreshTokens() async {
  
    final url = ServerStrings.baseUrl + ServerStrings.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    }

    return response.statusCode;
  } //_refreshTokens

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<Map<String, SleepData>> _requestData() async {
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    if (JwtDecoder.isExpired(access!)) {
      await _refreshTokens();
      access = sp.getString('access');
    } //if

    final start_date = DateFormat('y-M-d')
        .format(DateTime.now().subtract(const Duration(days: 5)));
    final end_date = DateFormat('y-M-d')
        .format(DateTime.now().subtract(const Duration(days: 1)));
    final url = ServerStrings.baseUrl +
        ServerStrings.sleepEndpoint +
        ServerStrings.patientUsername +
        '/daterange/start_date/$start_date/end_date/$end_date/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);

    Map<String, SleepData> Result = {};

    if (response.statusCode == 200) {
      String temp = '';

      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      for (int i = 0; i < decodedResponse['data'].length; i++) {
        SleepData dataDay = SleepData.fromJson(decodedResponse['data'][i]);
        print("DATA DAY");
        print(dataDay.levels);
        
        String summary = dataDay.levels.toString();
        int deepindex = summary.indexOf("minutes");
        print(deepindex);
        if (deepindex != -1) {
          deepindex = deepindex + 9;
          while (summary[deepindex] != ',') {
           
            temp = temp + summary[deepindex];
            deepindex = deepindex + 1;
          }
          deep.add(int.parse(
              temp)); 
          temp = ''; 
          int wakeindex = summary.indexOf("minutes", deepindex);
          wakeindex = wakeindex + 9;

          while (summary[wakeindex] != ',') {
            
            temp = temp + summary[wakeindex];
            wakeindex = wakeindex + 1;
          }
          wake.add(int.parse(temp));
          temp = '';

          int lightindex = summary.indexOf("minutes", wakeindex);
          lightindex = lightindex + 9;

          while (summary[lightindex] != ',') {
            temp = temp + summary[lightindex];
            lightindex = lightindex + 1;
          }
          light.add(int.parse(temp));
          temp = '';
          int remindex = summary.indexOf("minutes", lightindex);
          remindex = remindex + 9;

          while (summary[remindex] != ',') {
            temp = temp + summary[remindex];
            remindex = remindex + 1;
          }
          rem.add(int.parse(temp));
          temp = '';
        }
        print(dataDay.efficiency);
        Result[dataDay.date] = dataDay;
      }
      print(deep);
      print(wake);
      print(light);
      print(rem);
    }
    return Result;
  } //_requestData

//This method allows to save the data in the Database
  Future<void> saveDataInDatabase(
      Map<String, SleepData> ResultMap, BuildContext context) async {
    Map<String, SleepData> Result = ResultMap;
    print(Result[0]);
    List<Sleep> allSleep =
        await Provider.of<AppDatabaseRepository>(context, listen: false)
            .findAllSleeps();
    Map allSleepMap = {};
    Iterable keys = Result.keys;
    for (int i = 0; i < allSleep.length; i++) {
      allSleep.forEach((sleep) => allSleepMap[sleep.date] = sleep);
    }
    for (final key in keys) {
      print("RESULT DATE");
      print(Result[key]);
      if (!(allSleepMap[key] == null)) {
        await Provider.of<AppDatabaseRepository>(context, listen: false)
            .updateSleep(Sleep(
          id: allSleepMap[key].id,
          date: Result[key]!.date.toString(),
          dateOfSleep: Result[key]!.dateOfSleep,
          startTime: Result[key]!.startTime,
          endTime: Result[key]!.endTime,
          duration: Result[key]!.duration,
          minutesToFallAsleep: Result[key]!.minutesToFallAsleep,
          minutesAsleep: Result[key]!.minutesAsleep,
          minutesAwake: Result[key]!.minutesAwake,
          minutesAfterWakeup: Result[key]!.minutesAfterWakeup,
          efficiency: Result[key]!.efficiency,
          logType: Result[key]!.logType,
          mainSleep: Result[key]!.mainSleep,
          levels: Result[key]!.levels.toString(),
        ));
      } else {
        Sleep sleep = Sleep(
         
          date: Result[key]!.date.toString(),
          dateOfSleep: Result[key]!.dateOfSleep,
          startTime: Result[key]!.startTime,
          endTime: Result[key]!.endTime,
          duration: Result[key]!.duration,
          minutesToFallAsleep: Result[key]!.minutesToFallAsleep,
          minutesAsleep: Result[key]!.minutesAsleep,
          minutesAwake: Result[key]!.minutesAwake,
          minutesAfterWakeup: Result[key]!.minutesAfterWakeup,
          efficiency: Result[key]!.efficiency,
          logType: Result[key]!.logType,
          mainSleep: Result[key]!.mainSleep,
          levels: Result[key]!.levels.toString(),
        );
        await Provider.of<AppDatabaseRepository>(context, listen: false)
            .insertSleep(sleep);
        print("SAVED DATABASE");
      }
    }
  }

  //This method allows to obtain the JWT token pair from IMPACT
  Future<bool> authorize(String username, String password) async {
    //Create the request
    final url = ServerStrings.baseUrl + ServerStrings.tokenEndpoint;
    final body = {'username': username, 'password': password};

    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
      prefs.impactAccessToken = sp.getString('access');
      prefs.impactRefreshToken = sp.getString('refresh');
      print('Ho i token');

      return true;
    } //if
    else {
      return false;
    }
  } //authorize

  bool checkSavedToken({bool refresh = false}) {
    
    String? token = retrieveSavedToken(refresh);
    
    if (token == null) {
      return false; 
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  static bool checkToken(String token) {
    
    if (JwtDecoder.isExpired(token)) {
      return false; // si ritorna false
    }
    return true; 
  } //checkToken

  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
        return prefs.impactAccessToken;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(children: [
                Padding(
                    padding:
                        EdgeInsets.all(15), //apply padding to all four sides
                    child: Text('W I N E     N O T  ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Color.fromARGB(255, 176, 175, 175)))),
                Padding(
                    padding:
                        EdgeInsets.all(15), //apply padding to all four sides
                    child: Text('Download data ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 40,
                            color: Color.fromARGB(255, 0, 0, 0)))),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 15), //apply padding to all four sides
                    child: Text(
                        'Before you start using our app we need to download your sleep tracking data. \n Please press the button below.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))))
              ]),
              width: MediaQuery.of(context).size.width / 1,
              height: 280,
              margin: const EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 25.0, bottom: 30),
            ),

            // Button
            SizedBox(
              width: 160.0,
              height: 43.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 142, 76, 255), // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  shadowColor: Color.fromARGB(255, 145, 145, 145),
                ),
                onPressed: () async {
                  final result = await _requestData();
                  print(result);
                  final message =
                      result == null ? 'Request failed' : 'Request successful';
                  if (result.isNotEmpty) {
                    print("NOT NULL");
                    saveDataInDatabase(result, context);
                  }
                 
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                  if (result != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => BottomNavBarV2())));
                  }
                },
                child: Text('Get Started',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
              ),
            ),

            Image.asset('assets/images/sleepphone.gif',
                width: 300, height: 500),
          ],
        ),
      ),
    );
  }
} //ImpactService
