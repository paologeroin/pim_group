import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/entities/entities.dart';
import 'AboutPage.dart';
import 'SettingsPage.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:math';
import 'ProfilePage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:core';

Random random = new Random();
int randomNumber = random.nextInt(4); // from 0 upto 99 included
const Sec = Duration(seconds: 30);

List listaFrasi = [
  'Alcohol is an enemy',
  'You got this!',
  'Less Alcohol more Maria!',
  'It\'s one life, don\'t waste it!'
];

var frasedisplay = listaFrasi[randomNumber];

/// Definition of HomePage class
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int oldValue = randomNumber;
  Timer? countdownTimer;
  Timer? updateTimer;
  Duration myDuration = Duration(seconds: 10);
  Duration updateDuration = Duration(seconds: 1);
  DateTime today = DateTime.now();
  DateTime last = DateTime.now();
  Duration diff = Duration(hours: 0);
  String fullname = '';
  late SharedPreferences sharedPreferences;
  int wallet = 0;
  int multiplier = 0;

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // avremo potuto gestirla come una unica lista di stringhe ma ormai è cosi, pace e amen, l'idea mi è venuta troppo tardi
    setState(() {
      fullname = prefs.getString('fullname') ?? '';
    });
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void startTimer() {
    countdownTimer = Timer.periodic(myDuration, (_) => changePhrase());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void earnMoney() {
    // funzione per aggiornare il portafoglio
    // Aggiungi 5 al portafoglio ogni 24 ore
    int time = diff.inHours;
    if (countdownTimer != 0) {
  
      multiplier = time ~/ 24;
  // print('il moltiplicatore nella funzione è: $multiplier');
 //  print('time nella funzione: $time');
    }

    if (time / 24 >= 1) {
      setState(() {
        wallet = 10 * multiplier;
    //  print('Money added to wallet. Total money earned nella funzione: $wallet');
      });
      saveSharedPrefs(); // Salva il nuovo valore nel wallet
    }
  }

  Future<void> _loadWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wallet = prefs.getInt('wallet') ?? 0;
    });
  }

  Future<void> saveSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('wallet', wallet);
  }

  void changePhrase() {
    //print(oldValue);
    randomNumber = random.nextInt(4);
    //print(randomNumber);
    //setState(() {
    if (randomNumber == oldValue && randomNumber > 0) {
      randomNumber--;
      // print("change: $randomNumber");
    } else if (randomNumber == oldValue && randomNumber < 3) {
      randomNumber++;
      // print("change: $randomNumber");
    }

    //});
    setState(() {
      oldValue = randomNumber;
      frasedisplay = listaFrasi[randomNumber];
    });
  }

  void _update() async {
    last = await lastDrink(context);
    setState(() {
      today = DateTime.now();
    });
    // print(diff);
  }

  @override
  void initState() {
    super.initState();
    _update();
    updateTimer = Timer.periodic(updateDuration, (timer) => _update());
    startTimer();
    _loadProfileData();
   _loadWallet();
  }

  @override
  Widget build(BuildContext context) {
    _loadProfileData();
    _loadWallet();
    earnMoney();
    diff=-(last.difference(today));
  //  print('dopo la funzione $wallet');
  
    DateTime now = DateTime.now();
    String convertedDateTime = "";
    convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

    return Scaffold(
        //backgroundColor: Colors.grey[200],
        //backgroundColor: Color.fromARGB(99, 243, 210, 112),
       backgroundColor: Color.fromARGB(255, 255, 255, 255), // CAMBIO COLORE PAOLO Colors.teal[50],
        drawer: Drawer(
       backgroundColor: Color.fromARGB(255, 255, 255, 255), // CAMBIO COLORE PAOLO Colors.teal[50],
           child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,

            children: [
              SizedBox(
                height: 50,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                ),
                title: const Text('Logout'),
                onTap: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: 'Sure you want to logout?',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                     confirmBtnColor: Color.fromARGB(255, 194, 138, 243),
                    onConfirmBtnTap: () => _toLoginPage(context),
                  );
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                ),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: const Text('Settings'),
                onTap: () {
                  // TO DO: create settings page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(47.0),
          child: AppBar(
            title: Column(children: [
              Text("Ciao $fullname", style: GoogleFonts.lato()),
              GestureDetector(
                child: Text(frasedisplay, style: GoogleFonts.lato()),
              )
            ]),
            backgroundColor: Color.fromARGB(255, 194, 138, 243), 
                
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.key,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => TokenPage()));
                },
              )
            ],
          ),
        ),
        body: ListView(children: [
          Column(children: [
            ClipPath(
              clipper: RoundShape(),
              child: Container(
                height: 55,
                color: Color.fromARGB(255, 194, 138, 243), 
              ),
            ),
            Column(
              children: [
                Container(
                    child: Column(
                      children: [
                         Text('You have not drink for',
                            textAlign: TextAlign.center,
                            
                            style: GoogleFonts.lato(
                                fontSize: 33,
                                color: Color.fromARGB(255, 255, 255, 255))),
                        Text(format(diff),
                        textAlign: TextAlign.center,
                       
                         style: GoogleFonts.lato(fontSize: 40,
                         color: Color.fromARGB(255, 255, 255, 255))),
                         
                      ],
                    ),
                    // Border to visualize the container
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 180,
                    margin: const EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                         
                           Color.fromARGB(255, 255, 133, 12),
                           Color.fromARGB(255, 255, 208, 65) //add more colors for gradient
                        ],
                      ),
                    //  border: Border.all(color: Color.fromARGB(55, 255, 123, 0)),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(
                        color: Color.fromARGB(181, 214, 214, 214),
                        spreadRadius: 2,
                        blurRadius: 3 ,
                        offset: Offset(4,8),

                      )]
                    )),

                // CREO IL CONTAINER PER CIRCULAR PROGRESS
                Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 180,
                        margin: EdgeInsets.only(top: 50.0),
                        padding: EdgeInsets.all(20.0),
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          // color: Colors.green[100],
                        ),

                        // CREO I CIRCULAR PROGRESS NEL CONTAINER
                        child: Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          CircularPercentIndicator(
                            radius: 140.0,
                            lineWidth: 25.0,
                            percent: 0.7,
                            //   header: new Text("Icon header"),
                            center: Container(
                                child: Text(
                                  'Sobriety level',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(),
                                ),
                                width: 70,
                                height: 45,
                                padding: EdgeInsets.all(7.0),
                               // color: Colors.amber,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                )),

                            backgroundColor: Color.fromARGB(255, 238, 237, 237),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Color.fromARGB(255, 255, 147, 15),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          
                                  Consumer<AppDatabaseRepository>(
                                    builder: (context, dbr, child) {
                                  //The logic is to query the DB for the entire list of Todo using dbr.findAllTodos()
                                  //and then populate the ListView accordingly.
                                  //We need to use a FutureBuilder since the result of dbr.findAllTodos() is a Future.
                                  return FutureBuilder(
                                    initialData: null,
                                    //future: dbr.findSleepbyDate("${DateTime.now().subtract(const Duration(days: 1)).year}-0${DateTime.now().subtract(const Duration(days: 1)).month}-0${DateTime.now(). subtract(const Duration(days: 1)).day}"),
                                    future: dbr.findAllSleeps(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData ) {
                                        final data = snapshot.data as List<Sleep>;
                                      //  print(data[data.length-1].date);
                                        return CircularPercentIndicator(
                                          radius: 140.0,
                                          lineWidth: 25.0,
                                          percent: data[data.length-1].efficiency! / 100.0,

                                          //  header: new Text("Icon header"),
                                          center: Container(
                                              child: Text( data[data.length-1].efficiency.toString(),
                                                textDirection: TextDirection.ltr,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(),),
                                              width: 70,
                                              height: 53,
                                              padding: EdgeInsets.all(7.0),
                                              //color: Colors.amber,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              )),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          backgroundColor: Color.fromARGB(255, 238, 237, 237),
                                          progressColor: Color.fromARGB(255, 194, 138, 243),
                                        );
                                        
                                        } else {
                                              //A CircularProgressIndicator is shown while the list of Todo is loading.
                                              return CircularPercentIndicator(
                                                        radius: 140.0,
                                                        lineWidth: 25.0,
                                                        percent: 0.0,

                                                        //  header: new Text("Icon header"),
                                                        center: Container(
                                                            child: Text("0",
                                                              textDirection: TextDirection.ltr,
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.lato(),),
                                                            width: 70,
                                                            height: 53,
                                                            padding: EdgeInsets.all(7.0),
                                                            //color: Colors.amber,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                            )),
                                                        circularStrokeCap: CircularStrokeCap.round,
                                                        backgroundColor: Color.fromARGB(255, 196, 193, 193),
                                                        progressColor: Colors.teal[200],
                                                      );
                                            } 
                                        }
                                      );
                                    }
                                  ),
                                  //'Sleep quality',
                                  /*
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(),
                                ),*/
                                
                        ])
                        //width: 0.9,
                        )),

                // Widget che mostra quanti soldi abbiamo risparmiato
                Center(
                    child: Container(
                      
                  width: MediaQuery.of(context).size.width / 1.2,
                  margin: const EdgeInsets.only(top: 40, left:15, right:15),
                   padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left:15, right: 15),
                   
                    decoration: BoxDecoration(
                       gradient: LinearGradient(
                        colors: [
                         
                           Color.fromARGB(255, 119, 2, 170),
                           Color.fromARGB(255, 194, 138, 243) //add more colors for gradient
                        ],
                      ),
                      
                      border: Border.all(color: Color.fromARGB(255, 194, 138, 243)),
                 borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(
                        color: Color.fromARGB(181, 214, 214, 214),
                        spreadRadius: 2,
                        blurRadius: 3 ,
                        offset: Offset(4,8),

                      )]
                    
                  ),
                 // color: Colors.blue,
                     child:  Column( 
                      children:[
                  Center(
                      child: Text(
                    'Based on the consecutive days where you did not drink, you saved: \n' , textAlign: TextAlign.center,

                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal, fontSize: 26, color: Color.fromARGB(255, 255, 255, 255),
                   ))),
                    Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 7.0, left: 7.0),
                 // color: Color.fromARGB(255, 109, 230, 69),
               // decoration: BoxDecoration(
                //    borderRadius: BorderRadius.circular(30),
                //  ),
                  child: Center(
                      child:  Text(
                    '$wallet €',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromARGB(255, 248, 203, 0)),
                  )),
                )),
                  
                  ])
                )),



              

                Center(
                  //We are using a Consumer because we want that the UI showing
                  //the list of goals to rebuild every time the Goal DB updates.
                  child: Consumer<AppDatabaseRepository>(
                    builder: (context, goal, child) {
                      return FutureBuilder(
                        initialData: null,
                        future: goal.findAllGoals(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as List<Goal>;
                            //If the Goal table is empty, show a simple Text, otherwise show the list of goals using a ListView.
                            return data.length == 0
                                ? const Text(
                                    'The goals list is currently empty')
                                :
                                //Here, we are using a Card to show a Meal
                                Card(
                                    elevation: 5,
                                    child: ListTile(
                                      leading: const Icon(MdiIcons.star),
                                      
                                      title: Text(data[0].name),
                                      subtitle: Text(
                                          'Objective to reach: ${data[0].money} €'),
                                    ),
                                    // andrebbe qua
                                  );
                          } //if
                          else {
                            return const CircularProgressIndicator();
                          } //else
                        }, //FutureBuilder builder
                      );
                    },
                  ),
                ), 
              ],
            )
          ]),
        ]));
  }

  // METHOD FOR GO TO LOG OUT AND RETURN TO LOGINPAGE
  void _toLoginPage(BuildContext context) async {
    //Unset the 'username' filed in SharedPreference
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');

    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  } //_toCalendarPage
} // Homepage

class RoundShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height / 2;
    var p = Path();
    p.lineTo(0, height - curveHeight);
    p.quadraticBezierTo(width / 15, height, width, height - curveHeight);
    p.lineTo(width, 0);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

Future<DateTime> lastDrink(BuildContext context) async {
  List<Drink> lastDrinks =
      await Provider.of<AppDatabaseRepository>(context, listen: false)
          .findMostRecentDrink();
          DateTime lastDrinkDate; 
          if (lastDrinks.length == 0){
            lastDrinkDate = DateTime.now();
          } else {
           lastDrinkDate = lastDrinks.last.dateTime;
          }
  
  //(lastDrinkDate);
  return lastDrinkDate;
}
