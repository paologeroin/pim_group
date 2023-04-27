import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'AboutPage.dart';
import 'SettingsPage.dart';
import 'package:quickalert/quickalert.dart';
import 'SleepPage.dart';

/// Definition of HomePage class
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String convertedDateTime = "";
    convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
    return Scaffold(
      drawer: Drawer(
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
                  onConfirmBtnTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage())),
                );
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
            ListTile(
              leading: Icon(
                Icons.bed_outlined,
              ),
              title: const Text('Sleep'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SleepPage()));
              },
            ),
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
      appBar: AppBar(
          title: const Text('App name', textAlign: TextAlign.center),
          centerTitle: true),
      body: Column(
        children: [
          Center(
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 200,
                  margin: EdgeInsets.only(top: 15.0),
                  padding: EdgeInsets.all(20.0),
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green[100],
                  ),
                  child: Column(children: [
                    const Center(
                      child: Text(
                        'You are sober for:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                    ),
                    Center(
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.green[50],
                            ),
                            child: Text(
                              convertedDateTime,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 40),
                            )))
                  ])
                  //width: 0.9,
                  )),
          Center(
              child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            margin: const EdgeInsets.only(top: 70),
            //color: Colors.blue,
            child: Center(
                child: const Text(
              'For now you saved:',
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
            )),
          )),
          Center(
              child: Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: const EdgeInsets.all(40.0),
            color: Colors.green,
            child: Center(
                child: const Text(
              '100£',
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
            )),
          )),
        ],
      ),
    );
  }
}
