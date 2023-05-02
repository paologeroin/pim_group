import 'package:flutter/material.dart';
import 'package:pim_group/models/profileDB.dart';

//This class extends ChangeNotifier. 
//It will act as data repository for the profile info and will be shared thorugh the application.
//We only need to modify the user information defined in ProfilePage


class ProfileInfo extends ChangeNotifier{
  // The profile info is a String
  late FullName fullName;
  late Email email;
  late WithdrawalDate withdrawalDate;
  late Status status;

  // //Constructor
  // ProfileInfo({required this.profileInfo});
  
  // //Method to use to edit a profileInfo.
  // void editProfileInfo(ProfileInfo newProfileInfo) {
  //   profileInfo = newProfileInfo;
  //   //Call the notifyListeners() method to alert that someone has modified a goal.
   notifyListeners();
} //ProfileInfo