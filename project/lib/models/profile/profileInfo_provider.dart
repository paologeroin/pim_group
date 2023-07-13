import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileDB.dart';

class ProfileProvider extends ChangeNotifier {
  late ProfileData profileData;
  late ProfileData newProfileData;

  void editProfileData(bool boolean, ProfileData newProfileData) {
    if (boolean == true) {
      profileData = newProfileData;
    } else {
      profileData = profileData;
    }
    notifyListeners();
  } //editProfileData
} //ProfileProvider
