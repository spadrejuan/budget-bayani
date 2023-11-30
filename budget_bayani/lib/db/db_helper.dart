import 'dart:async';
import 'dart:async';

import 'package:budget_bayani/models/limits.dart';
import 'package:budget_bayani/models/logs.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../models/goals.dart';

class DBHelper {
  static Future _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> createTables(Database database) async {
    await database.execute("CREATE TABLE incomes(income_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "income_date DATETIME, income_amount DOUBLE,"
        "income_category TEXT, income_note TEXT)");
    await database.execute("CREATE TABLE expenses(expense_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "expense_date DATETIME, expense_amount DOUBLE,"
        "expense_category TEXT, expense_note TEXT)");
    await database.execute("CREATE TABLE goals(goal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "goal_name TEXT, goal_start DATETIME,"
        "goal_end DATETIME, goal_amount DOUBLE, income_category TEXT)");
    await database.execute("CREATE TABLE limits(limit_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "limit_number DOUBLE)");
  }

  static Future<Database> db() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase('budget_bayani.db',
      version: 1,
      onConfigure: _onConfigure,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createGoal(Goal goal) async {
    final db = await DBHelper.db();
    final data = goal.toMap();
    final id = await db.insert(
        'goals', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getGoals() async {
    final db = await DBHelper.db();
    return db.query('goals', orderBy: 'goal_id');
  }

  // To get a specific instance
  // static Future<List<Map<String, dynamic>>> getGoal(Goal goal) async{
  //   final db = await DBHelper.db();
  //   return db.query('goals', where: "goal_id=?", whereArgs: [goal.goalId], limit: 1);
  // }
  static Future<int> updateGoal(int id, Goal goal) async {
    final db = await DBHelper.db();
    final data = goal.toMap();
    final result = await db.update(
        'goals', data, where: "goal_id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteGoal(int id, Goal goal) async {
    final db = await DBHelper.db();
    try {
      await db.delete('goals', where: 'goal_id=?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong: $err");
    }
  }
}
