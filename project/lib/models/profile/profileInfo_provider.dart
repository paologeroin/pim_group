import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileDB.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the profile info and will be shared thorugh the application.
//We only need to modify the user information defined in ProfilePage

class ProfileProvider extends ChangeNotifier {
  // come posso raggruppare questa variabili in una più generale chiamata ad es info?
  late ProfileData profileData;

  //Call the notifyListeners() method to alert that someone has modified a goal.
  ProfileProvider() {
    // Method to use to edit a profileInfo. Ma voglio farne uno generale per tutti i tipi di info!
    // Creo una classe generale in profileDB?
    void editProfileData(ProfileData newProfileData) {
      profileData = newProfileData;
    }//editProfileData

  notifyListeners();
} //ProfileInfo
}