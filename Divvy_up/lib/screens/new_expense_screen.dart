import 'package:divvyup/expense_data.dart';
import 'package:divvyup/sqlite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../expense.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({Key? key}) : super(key: key);

  @override
  _NewExpenseScreenState createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  bool foodvisibility = true;
  bool foodvisibility2 = false;
  bool shoppingvisibility = true;
  bool shoppingvisibility2 = false;
  bool billsvisibility = true;
  bool billsvisibility2 = false;
  bool othersvisibility = true;
  bool othersvisibility2 = false;
  Expense expense = Expense(
    expenseName: " ",
    category: 0,
    expense: 0,
    friends: 0,
    paid: "1",
  );
  void saveExpense() async {
    Provider.of<ExpenseData>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(42.w, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(69.w, 32.h, 70.h, 0),
              child: TextField(
                  onChanged: (value) {
                    expense.expense = int.parse(value);
                    print(expense.expense.runtimeType);
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  style: TextStyle(color: Colors.white, fontSize: 25.sp),
                  decoration: InputDecoration(
                    prefixText: "₹",
                    fillColor: Colors.white,
                    hintText: "0",
                    hintStyle: TextStyle(fontSize: 25.sp, color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 42.w, 0),
                child: TextField(
                    onChanged: (value) {
                      expense.expenseName = value;
                    },
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 14.h),
                        filled: true,
                        prefixIcon: Icon(Icons.ac_unit),
                        fillColor: Color(0xff3A3A3A),
                        hintText: "What was the expense for?",
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)))),
            SizedBox(
              height: 20.h,
            ),
            Text("Category",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Visibility(
                    visible: foodvisibility,
                    child: IconButton(
                        onPressed: () {
                          foodvisibility = false;
                          foodvisibility2 = true;
                          shoppingvisibility = true;
                          shoppingvisibility2 = false;
                          billsvisibility = true;
                          billsvisibility2 = false;
                          othersvisibility = true;
                          othersvisibility2 = false;
                          expense.category = 1;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.emoji_food_beverage,
                          color: Colors.yellow,
                        ))),
                Visibility(
                    visible: foodvisibility2,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purple,
                        side: BorderSide(color: Colors.white, width: 1),
                        elevation: 0,
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      icon:
                          Icon(Icons.emoji_food_beverage, color: Colors.yellow),
                      label: Text("Food and Beverages"),
                      onPressed: () {
                        foodvisibility2 = false;
                        foodvisibility = true;
                        expense.category = 0;
                        setState(() {});
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Stack(children: [
              Visibility(
                  visible: shoppingvisibility,
                  child: IconButton(
                      onPressed: () {
                        foodvisibility = true;
                        foodvisibility2 = false;
                        shoppingvisibility2 = true;
                        shoppingvisibility = false;
                        billsvisibility = true;
                        billsvisibility2 = false;
                        othersvisibility = true;
                        othersvisibility2 = false;
                        expense.category = 2;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.red,
                      ))),
              Visibility(
                  visible: shoppingvisibility2,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purple,
                      side: BorderSide(color: Colors.white, width: 1),
                      elevation: 0,
                      minimumSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                    label: Text("Shopping"),
                    onPressed: () {
                      shoppingvisibility2 = false;
                      shoppingvisibility = true;
                      expense.category = 0;
                      setState(() {});
                    },
                  ))
            ]),
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Visibility(
                    visible: billsvisibility,
                    child: IconButton(
                        onPressed: () {
                          foodvisibility = true;
                          foodvisibility2 = false;
                          shoppingvisibility2 = false;
                          shoppingvisibility = true;
                          billsvisibility = false;
                          billsvisibility2 = true;
                          othersvisibility = true;
                          othersvisibility2 = false;
                          expense.category = 3;
                          setState(() {});
                        },
                        icon: Icon(Icons.payments, color: Colors.orange))),
                Visibility(
                    visible: billsvisibility2,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purple,
                        side: BorderSide(color: Colors.white, width: 1),
                        elevation: 0,
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      icon: Icon(Icons.payments, color: Colors.orange),
                      label: Text("Bills"),
                      onPressed: () {
                        billsvisibility2 = false;
                        billsvisibility = true;
                        expense.category = 0;
                        setState(() {});
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Visibility(
                    visible: othersvisibility,
                    child: IconButton(
                        onPressed: () {
                          foodvisibility = true;
                          foodvisibility2 = false;
                          shoppingvisibility2 = false;
                          shoppingvisibility = true;
                          billsvisibility = true;
                          billsvisibility2 = false;
                          othersvisibility = false;
                          othersvisibility2 = true;
                          expense.category = 4;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.developer_board_rounded,
                          color: Colors.blue,
                        ))),
                Visibility(
                    visible: othersvisibility2,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purple,
                        side: BorderSide(color: Colors.white, width: 1),
                        elevation: 0,
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      icon: Icon(Icons.developer_board_rounded,
                          color: Colors.blue),
                      label: Text("Others"),
                      onPressed: () {
                        othersvisibility2 = false;
                        othersvisibility = true;
                        setState(() {});
                        expense.category = 0;
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 106.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 42.w, 0),
              child: Container(
                  color: Colors.purple,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        saveExpense();
                      },
                      child: Text(
                        "Save Expense",
                        style: TextStyle(color: Colors.white),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
