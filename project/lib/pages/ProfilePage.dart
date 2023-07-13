import 'package:flutter/material.dart';
import 'package:pim_group/pages/EditProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static const routeDisplayName = 'Profile Page';
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String fullname = '';
  String username = '';
  String birthplace = '';
  String age = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // method used to load the ProfileData saved in the SHared Preferences
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname = prefs.getString('fullname') ?? '';
      username = prefs.getString('username') ?? '';
      birthplace = prefs.getString('birthplace') ?? '';
      age = prefs.getString('age') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 97, 198, 171),
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () async {
                final result =
                    await Navigator.of(context).push<Map<String, String>>(
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditProfilePage(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    fullname = result['fullname'] ?? fullname;
                    username = result['username'] ?? username;
                    birthplace = result['birthplace'] ?? birthplace;
                    age = result['age'] ?? age;
                    email = result['email'] ?? email;
                  });
                }
              },
            ),
          ],
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(children: [
              Text(
                username,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
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
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/avatar.png'),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextLabel("Full Name"),
              buildText(fullname),
              buildTextLabel("Birth place"),
              buildText(birthplace),
              buildTextLabel("Age"),
              buildText(age),
              buildTextLabel("E-mail"),
              buildText(email),
              SizedBox(
                height: 270,
              ),
              buildTextLabel(
                  "Your information will not be disclosed and will only be used by our app for security purposes"),
            ])));
  }
}

// Widget to build the Container of the Profile's information labels
Widget buildTextLabel(String textLabel) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 0),
    child:
        Text(textLabel, style: TextStyle(fontSize: 12, color: Colors.black45)),
  );
}

// Widget to build the Container of the Profile's informations
Widget buildText(String textField) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Text(textField,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
  );
}
