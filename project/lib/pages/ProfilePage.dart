import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: const IconThemeData(color: Color.fromARGB(145, 0, 255, 94)),
        title: const Text('Profilo', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      ),
      body: SingleChildScrollView(
        child: const Text('Attendo spiegazione tutor'),
      ),
    );
  }
  // vacchio codice
  // @override
  // Widget build(BuildContext context) {
  //   return  Scaffold(
  //     appBar: AppBar(title: const Text('Profile')),
  //     body: Center(
  //       child: Text('Profile page')
        
  //     )
  //   );
  // }
}
