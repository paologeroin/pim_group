import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileDB.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the profile info and will be shared thorugh the application.
//We only need to modify the user information defined in ProfilePage

class ProfileInfo extends ChangeNotifier {
  late FullName fullName;
  late UserName userName;
  late Email email;
  late WithdrawalDate withdrawalDate;

  //Call the notifyListeners() method to alert that someone has modified a goal.
  ProfileInfo() {
    // Method to use to edit a profileInfo. Ma voglio farne uno generale per tutti i tipi di info!
    // Creo una classe generale in profileDB?
    void editFullName(FullName newFullName) {
      fullName = newFullName;
    }//editFullName

    void editEmail(Email newEmail) {
      email = newEmail;
    }//editEmail

    void editWithdrawalDate(WithdrawalDate newWithdrawalDate) {
      withdrawalDate = newWithdrawalDate;
    }//editWithdrawalDate
    
    void editUserName(UserName newUserName) {
      userName = newUserName;
    }//editFullName

  }
  notifyListeners();
} //ProfileInfo
