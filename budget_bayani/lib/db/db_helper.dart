import 'dart:async';
import 'package:budget_bayani/models/limits.dart';
import 'package:budget_bayani/models/logs.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/goals.dart';
import 'package:path/path.dart';
class DBHelper {
  static final DBHelper _databaseHelper = DBHelper._();
  DBHelper._();
  late Database db;
  factory DBHelper() {
    return _databaseHelper;
  }
  Future _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> createTables(Database database) async {
    await database.execute("CREATE TABLE IF NOT EXISTS incomes(income_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "income_date DATETIME, income_amount DOUBLE,"
        "income_category TEXT, income_note TEXT)");
    await database.execute("CREATE TABLE IF NOT EXISTS expenses(expense_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "expense_date DATETIME, expense_amount DOUBLE,"
        "expense_category TEXT, expense_note TEXT)");
    await database.execute("CREATE TABLE IF NOT EXISTS goals(goal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "goal_name TEXT NOT NULL, goal_start TEXT NOT NULL,"
        "goal_end TEXT NOT NULL, goal_amount DOUBLE NOT NULL, income_category TEXT NOT NULL)");
    await database.execute("CREATE TABLE IF NOT EXISTS  limits(limit_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "limit_number DOUBLE)");
  }
  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'budget_bayani.db'),
      onCreate: (database, version) async {
        await createTables(database);
      },
      version: 1,
    );
  }
  Future<int> insertGoal(Goal goal) async {
    int result = await db.insert('goals', goal.toMap());
    return result;
  }
  Future<int> updateGoal(Goal goal) async {
    int result = await db.update('goals', goal.toMap(), where: 'goal_id=?', whereArgs: [goal.goalId],);
    return result;
  }
  Future<List<Goal>> retrieveGoals() async {
    final List<Map<String, Object?>> queryResult = await db.query('goals');
    return queryResult.map((e) => Goal.fromMap(e)).toList();
  }
  Future<void> deleteUser(int id) async {
    await db.delete('goals', where: 'goal_id=?', whereArgs: [id]);
  }

}
