import 'dart:async';

import 'package:divvyup/expense_data.dart';
import 'package:divvyup/screens/homepage.dart';
import 'package:divvyup/screens/new_expense_screen.dart';
import 'package:divvyup/screens/seedetailedSummary.dart';
import 'package:divvyup/screens/signup.dart';
import 'package:divvyup/screens/splitscreen.dart';
import 'package:divvyup/sqlite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:divvyup/screens/routing.dart';
import 'package:divvyup/screens/login_signup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExpenseData(),
        child: ScreenUtilInit(
            designSize: Size(360, 640),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: () => MaterialApp(
                  title: 'Divvy Up',
                  theme: ThemeData(
                    primarySwatch: Colors.purple,
                  ),
                  initialRoute: splashscreenID,
                  onGenerateRoute: (settings) {
                    var pageName = settings.name;
                    var args = settings.arguments;
                    if (pageName == loginsignupID) {
                      return MaterialPageRoute(
                          builder: (context) => LoginSignupScreen());
                    }
                    if (pageName == splashscreenID) {
                      return MaterialPageRoute(
                          builder: (context) => SplashScreen());
                    }
                    if (pageName == signupID)
                      return MaterialPageRoute(builder: (context) => Signup());
                    if (pageName == homeScreenID)
                      return MaterialPageRoute(
                          builder: (context) => HomePage());
                    if (pageName == newexpenseScreenID)
                      return MaterialPageRoute(
                          builder: (context) => NewExpenseScreen());
                    if (pageName == splitexpenseScreenID)
                      return MaterialPageRoute(
                          builder: (context) => SplitScreen());
                    if (pageName == splitexpenseScreenID)
                      return MaterialPageRoute(
                          builder: (context) => SplitScreen());
                    if (pageName == seedetailedSummaryID)
                      return MaterialPageRoute(builder: (context) => Summary());
                  },
                )));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, loginsignupID));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffA407A4),
        child: Image.asset(
          'assets/images/SplashScreenLogo.png',
        ));
  }
}
