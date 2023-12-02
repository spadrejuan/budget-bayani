import 'dart:async';
import 'package:budget_bayani/models/limits.dart';
import 'package:budget_bayani/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../models/goals.dart';
import 'package:path/path.dart';

import '../models/income.dart';

// import '../models/income.dart';
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
        "income_date TEXT, income_amount DOUBLE,"
        "income_category TEXT, income_note TEXT)");
    await database.execute("CREATE TABLE IF NOT EXISTS expenses(expense_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "expense_date TEXT, expense_amount DOUBLE,"
        "expense_category TEXT, expense_note TEXT)");
    await database.execute("CREATE TABLE IF NOT EXISTS goals(goal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "goal_name TEXT NOT NULL, goal_start TEXT NOT NULL,"
        "goal_end TEXT NOT NULL, goal_amount DOUBLE NOT NULL, income_category TEXT NOT NULL)");
    await database.execute("CREATE TABLE IF NOT EXISTS  limits(limit_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "limit_amount DOUBLE, limit_threshold TEXT)");
  }
  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'budget_bayani.db'),
      onCreate: (database, version) async {
        await createTables(database);
      },
      version: 1,
      onConfigure: _onConfigure,
    );
  }
  Future<int> insertExpense(Expenses expense) async{
    int result = await db.insert('expenses', expense.toMap());
    return result;
  }
  Future<List<Expenses>> retrieveExpenses() async {
    final List<Map<String, Object?>> queryResult = await db.query('expenses');
    return queryResult.map((e) => Expenses.fromMap(e)).toList();
  }
  Future<int> insertIncome(Incomes income) async{
    int result = await db.insert('incomes', income.toMap());
    return result;
  }
  Future<List<Incomes>> retrieveIncomes() async {
    final List<Map<String, Object?>> queryResult = await db.query('incomes');
    return queryResult.map((e) => Incomes.fromMap(e)).toList();
  }
  Future <List<Map<String, dynamic>>> retrieveIncomeCategories() async {
    return await db.rawQuery('SELECT * FROM incomes GROUP BY income_category');
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
  Future<void> deleteGoal(int id) async {
    await db.delete('goals', where: 'goal_id=?', whereArgs: [id]);
  }

  Future<int> insertLimit(Limit limit) async {
    int result = await db.insert('limits', limit.toMap());
    return result;
  }
  Future<int> updateLimit(Limit limit) async {
    int result = await db.update('limits', limit.toMap(), where: 'limit_id=?', whereArgs: [limit.limitId],);
    return result;
  }
  Future<List<Limit>> retrieveLimit() async {
    final List<Map<String, Object?>> queryResult = await db.query('limits');
    return queryResult.map((e) => Limit.fromMap(e)).toList();
  }
  Future<void> deleteLimit(int id) async {
    await db.delete('limits', where: 'limit_id=?', whereArgs: [id]);
  }
  Future<List<Limit>> retrieveLimitByThreshold(String string) async {
    final List<Map<String, Object?>> queryResult = await db.rawQuery('SELECT * FROM limits WHERE limit_threshold=?', [string]);
    return queryResult.map((e) => Limit.fromMap(e)).toList();
  }
  Future<void> deleteLimitByThreshold(String string) async {
    await db.delete('limits', where: 'limit_threshold=?', whereArgs: [string]);
  }
  Future<List<Expenses>> retrieveDailyExpenses() async {
    final List<Map<String, Object?>> queryResult = await db.rawQuery('SELECT * FROM expenses WHERE (expense_date <=?'
        'and expense_date >=?)', [DateTime.now().toIso8601String(), DateTime.now().subtract(const Duration(days: 1)).toIso8601String()]);
    return queryResult.map((e) => Expenses.fromMap(e)).toList();
  }

  Future<List<Expenses>> retrieveWeeklyExpenses() async {
    final List<Map<String, Object?>> queryResult = await db.rawQuery('SELECT * FROM expenses WHERE (expense_date <=?'
        'and expense_date >=?)', [DateTime.now().add(const Duration(days: 7)).toIso8601String(), DateTime.now().toIso8601String()]);
    return queryResult.map((e) => Expenses.fromMap(e)).toList();
  }

  Future<List<Expenses>> retrieveMonthlyExpenses() async {
    final List<Map<String, Object?>> queryResult = await db.rawQuery('SELECT * FROM expenses WHERE (expense_date <=?'
        'and expense_date >=?)', [DateTime.now().add(const Duration(days: 30)).toIso8601String(), DateTime.now().toIso8601String()]);
    return queryResult.map((e) => Expenses.fromMap(e)).toList();
  }
  Future <List<Map<String, dynamic>>> retrieveLimits() async {
    return await db.rawQuery('SELECT * FROM limits GROUP BY limit_threshold');
  }
  Future<List<Goal>> retrieveExistingGoals() async {
    final List<Map<String, Object?>> queryResult = await db.rawQuery('SELECT * FROM goals WHERE goal_end > ?',
        [DateFormat.yMMMd().format(DateTime.now())]);
    return queryResult.map((e) => Goal.fromMap(e)).toList();
  }
  Future<List<Goal>> retrieveExpiredGoals() async {
    final List<Map<String, Object?>> queryResult = await db.rawQuery('SELECT * FROM goals WHERE goal_end < ?',
        [DateFormat.yMMMd().format(DateTime.now())]);
    return queryResult.map((e) => Goal.fromMap(e)).toList();
  }

}
