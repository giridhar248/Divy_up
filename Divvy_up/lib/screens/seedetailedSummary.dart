import 'package:divvyup/expense_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  List<Widget> summry = [];
  List<dynamic> exp = [];
  double moneyyouget = 0;
  double moneyyoupay = 0;
  List<Widget> summaryview() {
    List<Widget> seesummary = [];

    for (var i in exp) {
      bool friendsVisibility = false;
      if (i.paid == "1" && i.friends != 0) {
        friendsVisibility = true;
        print(i.expense);
        moneyyouget += i.expense * (i.friends - 1);
      } else if (i.paid == "2") {
        friendsVisibility = true;
        moneyyoupay = moneyyoupay + (i.expense);
      }
      String cat = "";
      if (i.category == 1) {
        cat = "Food";
      } else if (i.category == 2) {
        cat = "Shopping";
      } else if (i.category == 3) {
        cat = "Bills";
      } else {
        cat = "Others";
      }
      seesummary.add(Container(
        margin: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff262626),
        ),
        child: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Text(i.expenseName,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp)),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Text("Rs " + i.expense.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20.sp)),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Text("Category:",
                  style: TextStyle(color: Colors.purple, fontSize: 20.sp)),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Text(cat, style: TextStyle(color: Colors.white, fontSize: 20.sp)),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Text("Paid By:",
                  style: TextStyle(color: Colors.purple, fontSize: 20.sp)),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Text(i.paid == "1" ? "Me" : "Friends",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp)),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Visibility(
            visible: friendsVisibility,
            child: Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text("Number of Splits:",
                    style: TextStyle(color: Colors.purple, fontSize: 20.sp)),
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Text(i.friends.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          )
        ]),
      ));
    }
    return seesummary;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, expenseData, x) {
      return Scaffold(
          backgroundColor: Color(0xff202020),
          appBar: AppBar(
            title: Text("Detailed Summary"),
          ),
          body: () {
            {
              exp = expenseData.allExpense;
              summry = summaryview();
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xff262626),
                              ),
                              width: 136.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(" You'll Get",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp)),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Rs " + moneyyouget.toString(),
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xff262626),
                              ),
                              width: 136.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(" You'll pay",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp)),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Rs " + moneyyoupay.toString(),
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: Text("All Expenses",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.purple)),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: summry,
                          ),
                        ),
                      ]));
            }
          }());
    });
  }
}
