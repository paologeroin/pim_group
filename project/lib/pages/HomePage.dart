import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/goals/goalProvider.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/pages/TokenPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AboutPage.dart';
import 'SettingsPage.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:math';
import 'ProfilePage.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:google_fonts/google_fonts.dart';

import 'EditProfilePage.dart';

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
  Duration myDuration = Duration(seconds: 10);

  void startTimer() {
    countdownTimer = Timer.periodic(myDuration, (_) => changePhrase());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void changePhrase() {
    print(oldValue);
    randomNumber = random.nextInt(4);
    print(randomNumber);
    //setState(() {
    if (randomNumber == oldValue && randomNumber > 0) {
      randomNumber--;
      print("change: $randomNumber");
    } else if (randomNumber == oldValue && randomNumber < 3) {
      randomNumber++;
      print("change: $randomNumber");
    }
    //});
    setState(() {
      oldValue = randomNumber;
      frasedisplay = listaFrasi[randomNumber];
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String convertedDateTime = "";
    convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

    return Scaffold(
        //backgroundColor: Colors.grey[200],
        //backgroundColor: Color.fromARGB(99, 243, 210, 112),
        backgroundColor: Colors.white, // CAMBIO COLORE PAOLO Colors.teal[50],
        drawer: Drawer(
          backgroundColor: Colors.white, // CAMBIO COLORE PAOLO Colors.teal[50],
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
                    confirmBtnColor: Colors.green,
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
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Column(children: [
              Text("Ciao NOME,", style: GoogleFonts.lato()),
              GestureDetector(
                child: Text(frasedisplay, style: GoogleFonts.lato()),
              )
            ]),
            backgroundColor: Color.fromARGB(255, 109, 230,
                69), // CAMBIO COLORE PAOLO Color.fromARGB(255, 97, 198, 171),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TokenPage()));
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
                height: 50,
                color: Color.fromARGB(255, 109, 230,
                    69), // CAMBIO COLORE PAOLO Color.fromARGB(255, 97, 198, 171),
              ),
            ),
            Column(
              children: [
                Container(
                    child: Text('You are sober from:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 30,
                            color: Color.fromARGB(255, 30, 121, 0))),
                    // Border to visualize the container
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 155,
                    margin: const EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 109, 230,
                              69), // CAMBIO COLORE PAOLO Color.fromARGB(96, 138, 242, 211),

                          Colors
                              .white // CAMBIO COLORE PAOLO Color.fromARGB(134, 47, 192, 156)

//add more colors for gradient
                        ],
                      ),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(25),
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
                          new Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          new CircularPercentIndicator(
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
                                //color: Colors.amber,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                )),

                            backgroundColor: Color.fromARGB(255, 196, 193, 193),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.pink[200],
                          ),
                          new Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          new CircularPercentIndicator(
                            radius: 140.0,
                            lineWidth: 25.0,
                            percent: 0.40,

                            //  header: new Text("Icon header"),
                            center: Container(
                                child: Text(
                                  'Sleep quality',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(),
                                ),
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
                          ),
                        ])
                        //width: 0.9,
                        )),

                // Widget che mostra quanti soldi abbiamo risparmiato
                Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  margin: const EdgeInsets.only(top: 40),
                  //color: Colors.blue,
                  child: Center(
                      child: const Text(
                    'For now you saved:',
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 30),
                  )),
                )),
                Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.all(40.0),
                  color: Color.fromARGB(255, 109, 230, 69),
                  child: Center(
                      child: const Text(
                    '100£',
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 30),
                  )),
                )),
                // INSERITO DA PAOLO PER GOALS, NON CAPISCO COME RISOLVERE ERRORE E NON CAPISCO DOVE POSSO METTERLO SE NO
                Center(
                  //We are using a Consumer because we want that the UI showing
                  //the list of goals to rebuild every time the Goal DB updates.
                  child: Consumer<GoalProvider>(
                    builder: (context, goalProvider, child) {
                      //If the list of goals is empty, show a simple Text, otherwise show the list of goals using a ListView.
                      return goalProvider.goals.isEmpty
                          ? const Text(
                              'You have no Goals now, insert one of yours Goals here')
                          : Card(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(MdiIcons.flag),
                                    trailing: Icon(MdiIcons.noteEdit),
                                    title:
                                        Text('${goalProvider.goals[0].name}'),
                                    subtitle: Text(
                                        'objective to reach: ${goalProvider.goals[0].money} €'),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: LinearPercentIndicator(
                                          width:
                                              330, //MediaQuery.of(context).size.width = 50,
                                          animation: true,
                                          lineHeight: 30.0,
                                          animationDuration: 2500,
                                          percent:
                                              0.8, // percent: $soldi_risparmiati / ${goalDB.goals[mealIndex].money}
                                          center: Text(
                                              "80 %"), // center: Text($soldi_risparmiati / ${goalDB.goals[mealIndex].money}) QUANDO AVREMO I DATI
                                          // barRadius: Radius.circular(15),
                                          // backgroundColor: Colors.grey,
                                          progressColor:
                                              Color.fromARGB(255, 109, 230, 69),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ), // FINE CODICE INSERITO DA PAOLO
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
