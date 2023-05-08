import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';
//This is the data model of a user info.
// class ProfileData

class FullName {
  final String fullName;
  FullName({required this.fullName}); //costruttore
}

class UserName {
  final String userName;
  UserName({required this.userName}); //costruttore
}

class Email {
  final String email;
  Email({required this.email}); //costruttore
}

class WithdrawalDate {
  final DateTime withdrawalDate;
  WithdrawalDate({required this.withdrawalDate}); //costruttore
}
