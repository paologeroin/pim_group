import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:pim_group/models/entities/entities.dart';
import 'package:pim_group/services/sleepData.dart';
import 'package:pim_group/utils/shared_preferences.dart';
import 'package:pim_group/utils/server_strings.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sleep/sleep_provider.dart';
import '../pages/root.dart';


// Questo impact è fatto come quello del professore
// Devo capire se al posto di SleepProvider devo mettere Sleep
// dell'entity o boh.
//
// Non serve un file tipo steps.dart, il prof l'ha fatto perché
// non c'è un db in quella app, noi usiamo SQLite -ire

// Occhio alla riga 83

// creo la classe ImpactService
class ImpactService extends StatelessWidget {
  ImpactService(this.prefs);
  Preferences prefs; // inizializzo Preferences


  
  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> _refreshTokens() async {

    //Create the request
    final url = ServerStrings.baseUrl + ServerStrings.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the respone
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200 set the tokens
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Return just the status code
    return response.statusCode;

  } //_refreshTokens

  // metodo che si usa in jump per il fetch dei dati
  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<List<SleepData>?> _requestData() async {
    //Initialize the result
    List<SleepData>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final day = '2023-05-04';
    final url = ServerStrings.baseUrl + ServerStrings.sleepEndpoint + ServerStrings.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      print(decodedResponse.toString());
      print(decodedResponse['data']['data'].length);

      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['dateOfSleep']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['startTime']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['endTime']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['duration']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['minutesToFallAsleep']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['minutesAsleep']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['minutesAwake']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['minutesAfterWakeup']));
      result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['efficiency']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['logType']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['mainSleep']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['levels']));
      // result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']['data']));
      //qui c'è problema
      // for (var i = 0 ; i < decodedResponse['data']['data'].length; i++) {
      //   print(decodedResponse['data']['data']['dateOfSleep']);
      print(result);
      //   result.add(SleepData.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
      // }//for
    } //if
    else{
      result = null;
    }//else

    //Return the result
    return result;

  } //_requestData


  // metodi da usare in impact_ob
  //This method allows to obtain the JWT token pair from IMPACT 
  Future<bool> authorize(String username, String password) async {

    //Create the request
    final url = ServerStrings.baseUrl + ServerStrings.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200, set the token
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
    else{
      return false;
    }
  } //authorize

  bool checkSavedToken({bool refresh = false}) {
    // inizializzo refresh come false
    // perchè all'inizio si controlla se abbiamo i token. Se vediamo che token == null,
    // allora devo refresharli perche non li ho, e quindi ritorna false
    String? token = retrieveSavedToken(refresh);
    // Controllo se ho i token
    if (token == null) {
      return false; // ritorna false perchè non ho i token
    }
    try {
      // controllo se i token sono validi
      return ImpactService.checkToken(token);
    } catch (_) {
      // se non sono validi, ritorno false
      return false;
    }
    //n the try-catch statement, you place the code that may cause an exception in the try block.
    // If an exception occurs, the program jumps to the catch block immediately and skips the remaining code in the try block.
  }

  // Metodo che effettivamente controlla i token, se sono scaduti o no.
  // Si usa un metodo statico perchè potremmo voler controllare i token fuori dalla classe stessa
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      // controllo se il token è scaduto, se è scaduto allora qua è true e si entra nell'if
      return false; // si ritorna false
    }
    return true; // quindi se il token è valido e se l'user è effettivamente un patient ritorno true
  } //checkToken

  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      // se refresh = true allora vuol dire che bisogna refreshare
      // i token, perchè access Token è scaduto e quindi ritorna il token di refresh (che è salvato nelle shared Preferences)
      return prefs.impactRefreshToken;
    } else {
      // altrimenti l'access token è valido e ritorna l'access token stesso (che è salvato nelle shared Preferences)
      return prefs.impactAccessToken;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {

                  final result = await _requestData();
                  print(result);
                  final message =
                      result == null ? 'Request failed' : 'Request successful';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                  if (result != null) {
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => BottomNavBarV2())));
                }
                },
                child: Text('Dowload Data')),
                
          ],
        ),
      ),
    );
  } //build
}//ImpactService
