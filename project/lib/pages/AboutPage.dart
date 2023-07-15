import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(47.0),
          child: AppBar(
              // motivational phrases for the User that change during time
              title: Column(children: [
                Text("About WineNot?", style: GoogleFonts.lato()),
              ]),
              backgroundColor: Color.fromARGB(255, 194, 138, 243),
              elevation: 0)
      ), 
      body: SingleChildScrollView(
        child: Column(
          children: [
             Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/unipd-universita-di-padova.png',
                      height: 160.0,
                      width: 160.0,
                      fit: BoxFit.contain,
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/images/dei-logo.png',
                      height: 160.0,
                      width: 160.0,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

            Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'WineNot? aims to reduce the consumption of alcoholic beverages by raising awareness among users about the negative effects on their health, particularly on sleep quality. We help users record and monitor their alcohol consumption, allowing them to observe how it impacts their rest. Additionally, through the achievement of savings goals, the app provides users with financial incentives to limit their intake of alcoholic drinks.\n\nIn summary, WineNot? promotes greater awareness of personal health, while encouraging saving and moderation in alcohol consumption.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
