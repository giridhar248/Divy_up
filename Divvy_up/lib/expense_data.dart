import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divvyup/expense.dart';
import 'package:divvyup/sqlite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'expense.dart';

class ExpenseData extends ChangeNotifier {
  Map<String, double> dataMap = {
    "Food": 0,
    "Shopping": 0,
    "Bills": 0,
    "Others": 0,
  };
  String uID = "";
  List<dynamic> allExpense = [];
  double totalExpense = 0;

  ExpenseData() {
    final currentuser = FirebaseAuth.instance.currentUser;
    uID = (currentuser!.uid).toString();
    initExpenseData();
  }

  void initExpenseData() async {
    allExpense = await getallexpense();
    for (var i in allExpense) {
      totalExpense = totalExpense + i.expense;
      if (i.category == 1) {
        dataMap["Food"] = (dataMap["Food"]! + i.expense);
      } else if (i.category == 2) {
        dataMap["Shopping"] = (dataMap["Shopping"]! + i.expense);
      } else if (i.category == 3) {
        dataMap["Bills"] = (dataMap["Bills"]! + i.expense);
      } else {
        dataMap["Others"] = (dataMap["Others"]! + i.expense);
      }
      notifyListeners();
    }
  }

  void addExpense(expense) async {
    var expenseAsMap = expense.toMap();
    var f = await FirebaseFirestore.instance
        .collection(uID)
        .doc(expense.expenseName)
        .set(expenseAsMap);
    totalExpense = totalExpense + expense.expense;
    if (expense.category == 1) {
      dataMap["Food"] = (dataMap["Food"]! + expense.expense);
    } else if (expense.category == 2) {
      dataMap["Shopping"] = (dataMap["Shopping"]! + expense.expense);
    } else if (expense.category == 3) {
      dataMap["Bills"] = (dataMap["Bills"]! + expense.expense);
    } else {
      dataMap["Others"] = (dataMap["Others"]! + expense.expense);
    }
    allExpense.add(expense);
    notifyListeners();
  }

  Future<List<Expense>> getallexpense() async {
    var doc = await FirebaseFirestore.instance.collection(uID);
    var querysnap = await doc.get();
    List<Expense> tasksAsObjects = [];
    for (var qu in querysnap.docs) {
      tasksAsObjects.add(Expense.fromMap(qu.data()));
    }
    print(tasksAsObjects);
    return (tasksAsObjects);
  }
}
