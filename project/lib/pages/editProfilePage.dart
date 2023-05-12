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
  static const routeDisplayName = 'Edit Profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

// Class that manages the steta of EditProfilePage
class _EditProfilePageState extends State<EditProfilePage> {
  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _infoController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // collegamento alla registrazione utente?
    _selectedDate =  DateTime.now();
    super.initState();
  }//initState

  //Form controllers need to be manually disposed. 
  //So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _infoController.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 198, 171),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          EditProfilePage.routeDisplayName,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
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
                ),// parte superiore, dove si trova l'immagine
                SizedBox(
                  height: 35,
                ),
                // qui elenco info
                // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                // Creazione di un widget a parte che crea il TextField
                // buildTextField("Full Name", ProfileData.fullName),
                // buildTextField("Username", ProfileData.userName),
                // buildTextField("E-mail", ProfileData.email),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    // controller: myController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Withdrawal Date",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "inserire data",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                    ),
                  ),
                ),//Withdrawal Date
                SizedBox(
                  height: 35,
                ),
                // Da qui poi è a posto, manca solo salvataggio modifiche
                Center(
                  child: ElevatedButton(
                    onPressed: () => _validateAndSave(context),
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

  //Utility method that validate the form and, if it is valid, save the new user information.
  void _validateAndSave(BuildContext context) {
    if(formKey.currentState!.validate()){
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // ProfileData newProfileData = ProfileData(fullName: , userName: , email: , withdrawalDate: _selectedDate);
      // widget.profileData.editProfileData(newProfileData);
      Navigator.pop(
        context, 'Profile changes saved successfully!');
    }
  } // _validateAndSave
  
  //Utility method that implements a Date+Time picker. 
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(2010),
            lastDate: DateTime(2101))
        .then((value) async {
      if (value != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: _selectedDate.hour, minute: _selectedDate.minute),
        );
        return pickedTime != null ? value.add(
              Duration(hours: pickedTime.hour, minutes: pickedTime.minute)) : null;
      }
      return null;
    });
    if (picked != null && picked != _selectedDate)
      //Here, I'm using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
  }//_selectDate
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    Widget buildTextField(String labelText, List<ProfileData> profileData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // vuole una stringa
            // hintText: profileData,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        ),
      );
    }
}//_EditProfilePageState


// QUESTO CODICE L'HO PRESO DA flutter.dev 
// // Define a custom Form widget.
// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({super.key});

//   @override
//   State<MyCustomForm> createState() => _MyCustomFormState();
// }

// // Define a corresponding State class.
// // This class holds data related to the Form.
// class _MyCustomFormState extends State<MyCustomForm> {
//   // Create a text controller. Later, use it to retrieve the
//   // current value of the TextField.
//   final myController = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the widget tree.
//     // This also removes the _printLatestValue listener.
//     myController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Fill this out in the next step.
//   }
  
//   // You need a function to run every time the text changes.
//   // Create a method in the _MyCustomFormState class that prints out the current value of the text field.
//   void _printLatestValue() {
//   print('Second text field: ${myController.text}');
//   }
//   // Finally, listen to the TextEditingController and call the _printLatestValue() method when the text changes.
//   // Use the addListener() method for this purpose.
//   @override
//     void initState() {
//       super.initState();

//       // Start listening to changes.
//       myController.addListener(_printLatestValue);
//     }
// }

