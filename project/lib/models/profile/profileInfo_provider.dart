import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileDB.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the profile info and will be shared thorugh the application.
//We only need to modify the user information defined in ProfilePage

class ProfileProvider extends ChangeNotifier {
  
  late ProfileData profileData;
  late ProfileData newProfileData;

  //Call the notifyListeners() method to alert that someone has modified a field.
  // Method to use to edit a profileData.
  void editProfileData(bool boolean, ProfileData newProfileData) {
    if (boolean == true) {
      profileData  = newProfileData;
    }else{
      profileData = profileData;
    }
    notifyListeners(); 
  }//editProfileData 
}//ProfileProvider