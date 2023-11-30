import 'package:budget_bayani/models/limits.dart';
import 'package:budget_bayani/models/logs.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import '../models/goals.dart';

class DBHelper {
  static Future<void> createTables(Database database) async{
    await database.execute("""CREATE TABLE incomes(income_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL'
        ', income_date DATETIME, income_amount DOUBLE, '
        'income_category TEXT, income_note TEXT)""");
    await database.execute("""expenses(expense_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        ' expense_date DATETIME, expense_amount DOUBLE, '
        'expense_category TEXT, expense_note TEXT)""");
    await database.execute("""CREATE TABLE goals(goal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        ' goal_name TEXT, goal_start DATETIME, '
        'goal_end DATETIME, goal_amount DOUBLE)""");
    await database.execute("""CREATE TABLE limits(limit_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        ' limit_number DOUBLE)""");
  }

  static Future<Database> db() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase('budget_bayani.db',
        version: 1,
        onCreate: (Database database, int version) async{
          await createTables(database);
        },
    );
  }

  static Future<int> createGoal(Goal goal) async {
    final db = await DBHelper.db();
    final data = goal.toMap();
    final id = await db.insert('goals', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Goal>> getGoals() async{
    final db = await DBHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('goals', orderBy: 'goal_id');
    return List.generate(maps.length, (i) {
      return Goal(
        goalId: maps[i]['goal_id'] as int,
        goalName: maps[i]['goal_name'] as String,
        goalStart: maps[i]['goal_start'] as DateTime,
        goalEnd: maps[i]['goal_end'] as DateTime,
        goalAmount: maps[i]['goal_amount'] as double,
      );
    });
  }

  // To get a specific instance
  // static Future<List<Map<String, dynamic>>> getGoal(Goal goal) async{
  //   final db = await DBHelper.db();
  //   return db.query('goals', where: "goal_id=?", whereArgs: [goal.goalId], limit: 1);
  // }

  static Future<int> updateGoal(Goal goal) async{
    final db = await DBHelper.db();
    final data = goal.toMap();
    final result = await db.update('goals', data, where: "goal_id=?", whereArgs: [goal.goalId]);
    return result;
  }

  static Future<void> deleteGoal(Goal goal) async{
    final db = await DBHelper.db();
    try{
      await db.delete('goals', where: 'goal_id=?', whereArgs: [goal.goalId]);
    } catch (err){
      debugPrint("Something went wrong: $err");
    }
  }

  static Future<int> createIncome(Logs income) async {
    final db = await DBHelper.db();
    final data = income.toMap();
    final id = await db.insert('incomes', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Incomes>> getIncomes() async{
    final db = await DBHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('incomes', orderBy: 'income_id');
    return List.generate(maps.length, (i) {
      return Incomes(
        id: maps[i]['id'] as int,
        date: maps[i]['date'] as DateTime,
        amount: maps[i]['amount'] as double,
        incomeCategory: maps[i]['income_category'] as String,
        incomeNote: maps[i]['income_note'] as String,
      );
    });
  }

  static Future<int> updateIncome(Logs income) async{
    final db = await DBHelper.db();
    final data = income.toMap();
    final result = await db.update('incomes', data, where: "income_id=?", whereArgs: [income.id]);
    return result;
  }

  static Future<void> deleteIncome(Logs income) async{
    final db = await DBHelper.db();
    try{
      await db.delete('incomes', where: 'income_id=?', whereArgs: [income.id]);
    } catch (err){
      debugPrint("Something went wrong: $err");
    }
  }
  static Future<int> createExpense(Logs expense) async {
    final db = await DBHelper.db();
    final data = expense.toMap();
    final id = await db.insert('expenses', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Expenses>> getExpenses() async{
    final db = await DBHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('incomes', orderBy: 'income_id');
    return List.generate(maps.length, (i) {
      return Expenses(
        id: maps[i]['id'] as int,
        date: maps[i]['date'] as DateTime,
        amount: maps[i]['amount'] as double,
        expenseCategory: maps[i]['expense_category'] as String,
        expenseNote: maps[i]['expense_note'] as String,
      );
    });
  }

  static Future<int> updateExpense(Logs expense) async{
    final db = await DBHelper.db();
    final data = expense.toMap();
    final result = await db.update('expenses', data, where: "expense_id=?", whereArgs: [expense.id]);
    return result;
  }
  static Future<void> deleteExpense(Logs expense) async{
    final db = await DBHelper.db();
    try{
      await db.delete('expenses', where: 'expense_id=?', whereArgs: [expense.id]);
    } catch (err){
      debugPrint("Something went wrong: $err");
    }
  }
  static Future<int> createLimit(Limits limit) async {
    final db = await DBHelper.db();
    final data = limit.toMap();
    final id = await db.insert('limits', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Limits>> getLimits() async{
    final db = await DBHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('incomes', orderBy: 'income_id');
    return List.generate(maps.length, (i) {
      return Limits(
        limitId: maps[i]['limit_id'] as int,
        limitNumber: maps[i]['limit_number'] as double,
      );
    });
  }

  static Future<int> updateLimit(Limits limit) async{
    final db = await DBHelper.db();
    final data = limit.toMap();
    final result = await db.update('limits', data, where: "limit_id=?", whereArgs: [limit.limitId]);
    return result;
  }
  static Future<void> deleteLimit(Limits limit) async{
    final db = await DBHelper.db();
    try{
      await db.delete('limits', where: 'limit_id=?', whereArgs: [limit.limitId]);
    } catch (err){
      debugPrint("Something went wrong: $err");
    }
  }

}
