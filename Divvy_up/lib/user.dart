import 'package:flutter/material.dart';

class newUser {
  newUser({
    required this.userName,
    required this.uID,
    required this.email,
    required this.password,
    required this.budget,
  });
  String budget;
  String uID;
  String userName;
  String email;
  String password;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> expenseAsMap = {
      "UID": uID,
      "Name": userName,
      "email": email,
      "password": password,
      "budget": budget,
    };
    return (expenseAsMap);
  }

  static newUser fromMap(Map<String, dynamic> userAsMap) {
    print(userAsMap);
    newUser user = newUser(
        userName: userAsMap["Name"],
        uID: userAsMap["UID"],
        email: userAsMap["email"],
        password: userAsMap["password"],
        budget: userAsMap["budget"]);
    return (user);
  }
}
