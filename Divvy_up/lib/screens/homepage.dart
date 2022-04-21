import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divvyup/expense_data.dart';
import 'package:divvyup/screens/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:divvyup/user.dart';

import '../expense.dart';
import '../sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color homeColor = Colors.white;
  Color splitColor = Colors.white;
  Color profileColor = Colors.white;
  double width = 20.w;
  String uID = "";
  String budget = "0";
  String name = "";

  TextEditingController budgetholder = TextEditingController();
  void fetchuseruId() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    uID = (currentuser!.uid).toString();
    var doc = await FirebaseFirestore.instance.collection(uID);
    var querysnap = await doc.get();

    for (var qu in querysnap.docs) {
      if (qu == uID) {
        var x = newUser.fromMap(qu.data());
        budget = x.budget;
        name = x.userName;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchuseruId();
  }

  void seedetailedSummary() {
    Navigator.pushNamed(context, seedetailedSummaryID);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, expenseData, x) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text("Hello," + name),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {}, icon: Icon(Icons.account_circle)),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, newexpenseScreenID);
              },
              icon: Icon(Icons.add),
              backgroundColor: Colors.purple,
              focusColor: Colors.purple,
              elevation: 0,
              label: Text('Add Expense'),
            ),
            backgroundColor: Color(0xff202020),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25.w, 15.h, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Your Spends",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(23.w, 15.h, 21.w, 0),
                  width: double.infinity,
                  height: 377.h,
                  padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff262626)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Row(children: [
                          Text(expenseData.totalExpense.toString(),
                              style: TextStyle(
                                  color: double.parse(budget) <
                                          expenseData.totalExpense
                                      ? Colors.red
                                      : Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                            child: Text("/ " + budget,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp)),
                          ),
                          IconButton(
                              onPressed: () {
                                _showModalBottomSheet();
                              },
                              icon: Icon(
                                Icons.create,
                                color: Colors.red,
                              )),
                        ]),
                        SizedBox(
                          height: 22.h,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xff3A3A3A)),
                            height: 228.h,
                            width: double.infinity,
                            child: PieChart(
                              dataMap: expenseData.dataMap,

                              animationDuration: Duration(milliseconds: 800),

                              chartLegendSpacing: 32,

                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,

                              colorList: [
                                Colors.yellow,
                                Colors.red,
                                Colors.orange,
                                Colors.blue,
                              ],

                              initialAngleInDegree: 0,

                              chartType: ChartType.ring,

                              ringStrokeWidth: 32,

                              centerText: "Expense",

                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                              ),

                              // gradientList: ---To add gradient colors---

                              // emptyColorGradient: ---Empty Color gradient---
                            )),
                        SizedBox(
                          height: 22.h,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.purple),
                          ),
                          onPressed: () {
                            seedetailedSummary();
                          },
                          child: Text("See Detailed Summary",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xff262626),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            homeColor = Colors.purple;
                            splitColor = Colors.white;
                            profileColor = Colors.white;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.home,
                            color: homeColor,
                            size: 35,
                          )),
                      Text(
                        "Home",
                        style: TextStyle(color: homeColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            homeColor = Colors.white;
                            splitColor = Colors.purple;
                            profileColor = Colors.white;
                            setState(() {});
                            Navigator.pushNamed(context, splitexpenseScreenID);
                          },
                          icon: Icon(
                            Icons.group,
                            color: splitColor,
                            size: 35,
                          )),
                      Text("Split", style: TextStyle(color: splitColor))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            homeColor = Colors.white;
                            splitColor = Colors.white;
                            profileColor = Colors.purple;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.person,
                            color: profileColor,
                            size: 35,
                          )),
                      Text("Profile", style: TextStyle(color: profileColor))
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Color(0xff202020),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
            child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          color: Colors.black26,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Set Monthly Budget",
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white)),
                      Expanded(flex: 3, child: SizedBox()),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff202020))),
                          onPressed: () {
                            budgetholder.clear();
                          },
                          child:
                              Text("Clear", style: TextStyle(fontSize: 18.sp)))
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                      child: TextField(
                          onChanged: (value) {
                            budget = value;
                          },
                          keyboardType: TextInputType.number,
                          controller: budgetholder,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.sp),
                          decoration: InputDecoration(
                            prefixText: "₹",
                            fillColor: Colors.white,
                            hintText: "0",
                            hintStyle:
                                TextStyle(fontSize: 25.sp, color: Colors.white),
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 36.h,
                        width: 126.w,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.purple)),
                            onPressed: () async {
                              var f = await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(uID)
                                  .update({"budget": budget});
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text("Set",
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white))),
                      ),
                      Expanded(flex: 3, child: SizedBox()),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black26)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.purple))),
                    ],
                  )
                ],
              )),
        ));
      },
    );
  }
}
