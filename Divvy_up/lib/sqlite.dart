// import 'package:divvyup/expense.dart';
// import 'package:flutter/cupertino.dart';
// import "package:path/path.dart";
// import 'package:sqflite/sqflite.dart';
//
// class SqliteDB {
//   static Database? _db;
//   static Future<Database> get db async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDb();
//     return _db!;
//   }
//
//   static Future _onCreate(Database db, int t) async {
//     await db.execute('CREATE TABLE EXPENSE (expenseID INTEGER PRIMARY KEY, '
//         'expenseName TEXT, '
//         'category INTEGER, '
//         'expenses INTEGER,'
//         'friends INTEGER,'
//         'paid TEXT)');
//   }
//
//   /// Initialize DB
//   static initDb() async {
//     String folderPath = await getDatabasesPath();
//     String path = join(folderPath, "divvyup.db");
//     //await deleteDatabase(path);
//     var taskDb = await openDatabase(
//       path,
//       version: 2,
//       onCreate: _onCreate,
//     );
//     _db = taskDb;
//     return taskDb;
//   }
//
//   static Future<int?> insertExpense(Map<String, dynamic> taskData) async {
//     var dbClient = await db;
//     int id = await dbClient.insert("EXPENSE", taskData);
//     if (id != 0) {
//       return (id);
//     } else {
//       return (null);
//     }
//   }
//
//   static Future<List<Expense>> getAllExpense() async {
//     var dbClient = await db;
//     List<Map<String, dynamic>> expensesFromDB = await dbClient.query("EXPENSE");
//     List<Expense> tasksAsObjects = [];
//     for (var map in expensesFromDB) {
//       tasksAsObjects.add(Expense.fromMap(map));
//     }
//     return (tasksAsObjects);
//   }
// }
