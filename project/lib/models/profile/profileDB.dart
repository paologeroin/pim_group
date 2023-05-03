import 'package:flutter/material.dart';
import 'package:pim_group/models/profile/profileInfo_provider.dart';
//This is the data model of a user info.
// class ProfileData

class FullName {
  final String fullname;
  FullName({required this.fullname}); //costruttore
}

class Email {
  final String email;
  Email({required this.email}); //costruttore
}

class WithdrawalDate {
  final DateTime withdrawalDate;
  WithdrawalDate({required this.withdrawalDate}); //costruttore
}

class Status {
  final String status;
  Status({required this.status}); //costruttore
}
