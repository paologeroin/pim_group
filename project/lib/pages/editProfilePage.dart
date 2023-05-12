import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';

import '../models/profile/profileDB.dart';
import '../utils/formats.dart';
import '../widgetsgoals/formSeparator.dart';
import '../widgetsgoals/formTiles.dart';

class EditProfilePage extends StatefulWidget {
  //EditProfilePage needs to know the bool value: if is true it means that the field has been modified
  final bool profileBool = false; // late?
  late final ProfileProvider profileDB;


  static const routeDisplayName = 'Edit Profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

// Class that manages the steta of EditProfilePage
class _EditProfilePageState extends State<EditProfilePage> {
  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _infoController = TextEditingController(); // controllore per fullname, username, email
  DateTime _selectedDate = DateTime.now(); // controllore per withdrawal date

  @override
  void initState() {
    _infoController.text = widget.profileBool == false
        ? widget.profileDB.profileData.toString()
        : widget.profileDB.newProfileData.toString();
    // se l'indice è uguale a false (vuol dire che non ho modificato il field)
    // inizializzo _infoController come l'ultimo salvataggio, altrimenti lo imposto al nuovo valore inserito

    _selectedDate = widget.profileBool == false
        ? widget.profileDB.profileData.withdrawalDate
        : widget.profileDB.newProfileData.withdrawalDate;
    // se l'indice è uguale a false (vuol dire che non ho modificato il field)
    // inizializzo _selectDate come l'ultimo salvataggio, altrimenti lo imposto al nuovo valore inserito

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
        backgroundColor: Color.fromARGB(255, 109, 230, 69),
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
                Center(
                  child: _buildForm(context),
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

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            // BISOGNA CAMBIARE COLORE ALLE ICONE DEI SEPARATORI E ALLE SCRITTE
            FormSeparator(label: 'Full Name'),
            FormTextTile(
              labelText: "Write here your full name",
              // icon: Icons.photo_camera_front, // E' L'ICONA
              controller: _infoController,
            ),
            FormSeparator(label: 'Username'),
            FormNumberTile(
              labelText: 'Write here your username',
              controller: _infoController,
              // icon: Icons.money,
            ),
            FormSeparator(label: 'Withdrawal Date'),
            FormDateTile(
              labelText: 'When you decided to quit?',
              date: _selectedDate,
              icon: MdiIcons.clockTimeFourOutline,
              onPressed: () {
                _selectDate(context);
              },
              dateFormat: Formats.fullDateFormatNoSeconds,
            ),
          ],
        ),
      ),
    );
  } // _buildForm

  //Utility method that validate the form and, if it is valid, save the new user information.
  void _validateAndSave(BuildContext context) {
    if(formKey.currentState!.validate()){
      
      ProfileData newProfileData = ProfileData(
        fullName: _infoController.text, 
        userName: _infoController.text, 
        email: _infoController.text,
        withdrawalDate: _selectedDate);
      widget.profileBool == true ? widget.profileDB.editProfileData(widget.profileBool, newProfileData)
      : widget.profileDB.profileData;
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
}//EditProfilePage
