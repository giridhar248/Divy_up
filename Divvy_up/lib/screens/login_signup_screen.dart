import 'package:divvyup/screens/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homepage.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  String useremail = "";
  String userpass = "";
  void checkcredentials() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: useremail,
        password: userpass,
      );
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email.',
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
        );
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(color: Colors.purple),
          Container(width: 180.w, child: Image.asset('assets/images/logo.png')),

          /*Image.asset('assets/images/img1.png'),
            Container(child: Text("Are you ok"), color: Colors.white)*/

          Container(
            color: Colors.black,
            margin: EdgeInsets.fromLTRB(0, 138.h, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              children: [
                SizedBox(
                  height: 94.h,
                ),
                textdesign(Colors.yellow, "Track Personal Expenses",
                    Icons.addchart_rounded),
                SizedBox(
                  height: 25.h,
                ),
                textdesign(Colors.red, "Split Bills", Icons.account_tree_sharp),
                SizedBox(
                  height: 25.h,
                ),
                textdesign(Colors.brown, "Make Payments",
                    Icons.account_balance_wallet),
                SizedBox(
                  height: 102.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      _showModalBottomSheet();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h))),
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Text("Or",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(
                  height: 13.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, signupID);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h))),
                    child: Text("Signup",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Color(0xff202020),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Center(
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.sp))),
                      SizedBox(height: 30.h),
                      Container(
                        child: TextField(
                            onChanged: (value) {
                              useremail = value;
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
                                hintText: "email",
                                hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black))),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        child: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              userpass = value;
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
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          color: Colors.purple,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                checkcredentials();
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                )));
      },
    );
  }
}

class textdesign extends StatelessWidget {
  final Color customColor;
  final String text;
  final IconData icon;

  const textdesign(
    this.customColor,
    this.text,
    this.icon, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        color: customColor,
        size: 28.sp,
      ),
      SizedBox(
        width: 16.h,
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.white),
      )
    ]);
  }
}
