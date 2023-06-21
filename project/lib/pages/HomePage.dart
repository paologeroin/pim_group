import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/pages/LoginPage.dart';
import 'package:pim_group/pages/TokenPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/entities/goals.dart';
import 'AboutPage.dart';
import 'SettingsPage.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:math';
import 'ProfilePage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'EditProfilePage.dart';
import 'package:provider/provider.dart';
import 'package:pim_group/models/repo/app_repository.dart';
import 'package:pim_group/models/entities/drink.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

  void _update() async {
    last = await lastDrink(context);
    setState(() {
      today = DateTime.now();
    });
    print(diff);
  }

  @override
  void initState() {
    _update();
    updateTimer = Timer.periodic(updateDuration, (timer) => _update());
    startTimer();
    super.initState();
    _loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    _loadProfileData();
    diff = -(last.difference(today));
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
              Text("Ciao $fullname", style: GoogleFonts.lato()),
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
                    child: Column(
                      children: [
                        Text('You are sober from:',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontSize: 30,
                                color: Color.fromARGB(255, 30, 121, 0))),
                        Text(format(diff))
                      ],
                    ),
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
                                      leading: const Icon(MdiIcons.flag),
                                      trailing: const Icon(MdiIcons.noteEdit),
                                      title: Text(data[0].name),
                                      subtitle: Text(
                                          'objective to reach: ${data[0].money} €'),
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

Future<DateTime> lastDrink(BuildContext context) async {
  List<Drink> lastDrinks =
      await Provider.of<AppDatabaseRepository>(context, listen: false)
          .findMostRecentDrink();
  DateTime lastDrinkDate = lastDrinks.last.dateTime;
  print(lastDrinkDate);
  return lastDrinkDate;
}
