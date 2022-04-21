import 'package:divvyup/screens/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divvyup/user.dart';
import 'package:provider/provider.dart';

import '../expense_data.dart';
import 'homepage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool buttonvisibility = true;
  bool progressbarvisibility = false;
  String confirmpass = "";
  newUser newuser =
      newUser(userName: "", email: '', uID: "", password: "", budget: "0");
  FirebaseAuth auth = FirebaseAuth.instance;

  void addingUserdetails(UserCredential user) async {
    final currentuser = await FirebaseAuth.instance.currentUser;
    newuser.uID = (currentuser!.uid).toString();
    print(newuser.uID);
    Provider.of<ExpenseData>(context, listen: false).addExpense(newuser);
  }

  void createaccount() async {
    if (newuser.userName != null) {
      if (newuser.password == confirmpass) {
        try {
          print("enter");
          final user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: newuser.email, password: newuser.password);
          if (user != null) {
            print("enter1st");
            print(user);
            final currentuser = await FirebaseAuth.instance.currentUser;
            newuser.uID = (currentuser!.uid).toString();
            var newuserAsMap = await newuser.toMap();
            var f = await FirebaseFirestore.instance
                .collection('Users')
                .doc(newuser.uID)
                .set(newuserAsMap);
            Navigator.pushNamedAndRemoveUntil(
                context, homeScreenID, (route) => false);
            Fluttertoast.showToast(
              msg: "Signed Up Successfully",
            );
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            buttonvisibility = true;
            progressbarvisibility = false;
            Fluttertoast.showToast(
              msg: "The password provided is too weak.",
            );
          } else if (e.code == 'email-already-in-use') {
            buttonvisibility = true;
            progressbarvisibility = false;
            Fluttertoast.showToast(
              msg: "The account already exists for that email.",
            );
          }
        } catch (e) {
          buttonvisibility = true;
          progressbarvisibility = false;
          print(e);
        }
      } else {
        buttonvisibility = true;
        progressbarvisibility = false;
        Fluttertoast.showToast(
          msg: "Password Not Match",
        );
      }
    } else {
      buttonvisibility = true;
      progressbarvisibility = false;
      Fluttertoast.showToast(
        msg: "Name Cannot be empty",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff674FC4),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 52.h,
                      ),
                      Text("Sign Up to Divvy Up",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffff24))),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Text("Already have an account?",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey)),
                          Text(
                            " Login",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffff24)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      TextField(
                          onChanged: (value) {
                            newuser.userName = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 14.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Full Name",
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextField(
                          onChanged: (value) {
                            newuser.email = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 14.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email address",
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextField(
                          obscureText: true,
                          onChanged: (value) {
                            newuser.password = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 14.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextField(
                          obscureText: true,
                          onChanged: (value) {
                            confirmpass = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 14.h),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black))),
                      SizedBox(
                        height: 16.h,
                      ),
                      Stack(children: [
                        Visibility(
                          visible: buttonvisibility,
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                buttonvisibility = false;
                                progressbarvisibility = true;
                                createaccount();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.purple),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 14.h))),
                              child: Text("Create Account",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: progressbarvisibility,
                            child: Center(child: CircularProgressIndicator()))
                      ]),
                    ]))));
  }
}
