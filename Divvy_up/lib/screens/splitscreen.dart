import 'package:divvyup/expense.dart';
import 'package:divvyup/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplitScreen extends StatefulWidget {
  const SplitScreen({Key? key}) : super(key: key);

  @override
  _SplitScreenState createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  String selectedValue = "1";
  String selectedpaidValue = "1";
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
    if (selectedValue != "2") {
      var x = expense.expense ~/ expense.friends;
      print(x);
      expense.expense = (expense.expense ~/ expense.friends);
      print(expense.expense);
    }
    if (selectedpaidValue == "2") {
      expense.paid = "2";
    }
    Provider.of<ExpenseData>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
  }

  List<Widget> splitbottomsheet() {
    List<Widget> list = [];
    for (var i = 1; i <= expense.friends; i++) {
      var name = (i == 1) ? "Sahaj" : "Friend-" + i.toString();
      list.add(
        Row(
          children: [
            Text(name, style: TextStyle(fontSize: 18.sp, color: Colors.white)),
            Expanded(flex: 2, child: SizedBox()),
            SizedBox(
                height: 42.h,
                width: 120.w,
                child: TextField(
                    onChanged: (value) {
                      if (name == 'Sahaj') {
                        expense.expense = int.parse(value);
                      }
                    },
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "₹",
                      fillColor: Colors.white,
                      hintText: "0",
                      hintStyle:
                          TextStyle(fontSize: 25.sp, color: Colors.white),
                    )))
          ],
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        title: Text("Split"),
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
                    print(expense.expense);
                    expense.expense = int.parse(value);
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
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 42.w, 0),
              child: Row(
                children: [
                  SizedBox(
                      height: 42.h,
                      width: 132.w,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            expense.friends = int.parse(value);
                            setState(() {});
                          },
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
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
                              filled: true,
                              prefixIcon: Icon(Icons.ac_unit),
                              fillColor: Color(0xff3A3A3A),
                              hintText: "Splits",
                              hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)))),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                      height: 42.h,
                      width: 132.w,
                      child: DropdownButton(
                        elevation: 0,
                        dropdownColor: Color(0xff3A3A3A),
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        value: selectedValue,
                        items: [
                          DropdownMenuItem(
                            child: Text("Equally"),
                            value: "1",
                          ),
                          DropdownMenuItem(
                            child: Text("Unequally"),
                            value: "2",
                          ),
                        ],
                        onChanged: (String? value) {
                          selectedValue = value!;
                          setState(() {});
                          print("enter");
                          if (selectedValue == "2" && expense.friends != 0) {
                            var l = splitbottomsheet();
                            _showModalBottomSheet(l);
                          }
                        },
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: SizedBox(
                    height: 42.h,
                    width: 132.w,
                    child: DropdownButton(
                      elevation: 0,
                      dropdownColor: Color(0xff3A3A3A),
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      value: selectedpaidValue,
                      items: [
                        DropdownMenuItem(
                          child: Text("Paid by you"),
                          value: "1",
                        ),
                        DropdownMenuItem(
                          child: Text("Paid by other"),
                          value: "2",
                        ),
                      ],
                      onChanged: (String? value) {
                        selectedpaidValue = value!;
                        setState(() {});
                      },
                    ))),
            SizedBox(
              height: 20.h,
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

  _showModalBottomSheet(List<Widget> l) {
    showModalBottomSheet(
        backgroundColor: Color(0xff202020),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  color: Colors.black26,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
                      child: Column(children: [
                        Column(children: l),
                        Container(
                          color: Colors.purple,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Submit",
                                  style: TextStyle(color: Colors.white))),
                        )
                      ]))));
        });
  }
}
