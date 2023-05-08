import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';
import 'package:pim_group/pages/ProfilePage.dart';

import '../models/profile/profileDB.dart';

//Teoricamente inutile questa parte
// class SettingsUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Setting UI",
//       home: EditProfilePage(),
//     );
//   }
// }

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 198, 171),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, 'Discarded changes');
          },
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(children: [
                // Text(
                //   "Edit Profile",
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                // ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://i.pinimg.com/originals/22/91/ba/2291babd9eb9f7a2744b8cc24de1216a.jpg",
                                ))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.teal[200],
                            ),
                            child: Icon(
                              Icons.photo_library_outlined,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Full Name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "creo dipendenza",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),//Full Name
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Email",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "creo dipendenza",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),//Email
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Withdrawal Date",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "creo dipendenza",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),//Withdrawal Date
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Username",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "creo dipendenza",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),//Username
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context, 'Profile changes saved successfully!');
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.teal[200],
                        padding: EdgeInsets.symmetric(horizontal: 50)),
                  ),
                )
              ]))),
    );
    // );
  }
}