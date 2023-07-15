import 'package:flutter/material.dart';
import 'package:pim_group/widgetDrinks/formTiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  static const routeDisplayName = 'Edit Profile';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _birthplaceController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // this method is used to load the Data of the profile, those are saved in the shared preferences
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullname = prefs.getString('fullname') ?? '';
    String username = prefs.getString('username') ?? '';
    String birthplace = prefs.getString('birthplace') ?? '';
    String age = prefs.getString('age') ?? '';
    String email = prefs.getString('email') ?? '';

    setState(() {
      _fullnameController.text = fullname;
      _usernameController.text = username;
      _birthplaceController.text = birthplace;
      _ageController.text = age.toString();
      _emailController.text = email;
    });
  }

  // this method is used to save the information written in the text field in the shared preferences
  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', _fullnameController.text);
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('birthplace', _birthplaceController.text);
    await prefs.setString('age', _ageController.text);
    await prefs.setString('email', _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 194, 138, 243),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Profile information',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormTextTile(
                labelText: "Full Name",
                icon: Icons.people, // E' L'ICONA
                controller: _fullnameController,
              ),
              FormTextTile(
                labelText: "Username",
                icon: Icons.pedal_bike, // E' L'ICONA
                controller: _usernameController,
              ),
              FormTextTile(
                labelText: "Birth place",
                icon: Icons.baby_changing_station, // E' L'ICONA
                controller: _birthplaceController,
              ),
              FormNumberTile(
                labelText: 'Age',
                controller: _ageController,
                icon: Icons.numbers,
              ),
              FormTextTile(
                labelText: "E-mail",
                icon: Icons.computer, // E' L'ICONA
                controller: _emailController,
              ),
              SizedBox(height: 18.0),
              ElevatedButton(
                onPressed: _saveAndPop,
                child: const Text('Salva'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // method to save the information written/modified by the user in the text field before to display them in the Profile Page
  void _saveAndPop() async {
    _saveProfileData();
    final updatedData = {
      'fullname': _fullnameController.text,
      'username': _usernameController.text,
      'birthplace': _birthplaceController.text,
      'age': _ageController.text,
      'email': _emailController.text,
    };
    Navigator.of(context).pop(updatedData);
  }
}
