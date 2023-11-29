import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/goals.dart';

class DBHelper {
  static Future<void> createDB(Database db) async{
    await db.execute('CREATE TABLE incomes(income_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL'
        ', income_date DATETIME, income_amount DOUBLE, '
        'income_category TEXT, income_note TEXT)');
    await db.execute('expenses(expense_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        ' expense_date DATETIME, expense_amount DOUBLE, '
        'expense_category TEXT, expense_note TEXT)');
    await db.execute('CREATE TABLE goals(goal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        ' goal_name TEXT, goal_start DATETIME, '
        'goal_end DATETIME, goal_amount DOUBLE)');
    await db.execute('CREATE TABLE limits(limit_key INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        ' limit_number DOUBLE)');
  }

  static Future<Database> db() async {
    return openDatabase('budget_bayani.db',
        version: 1,
        onCreate: (Database db, int version) async{
          await createDB(db);
        },
    );
  }

}
