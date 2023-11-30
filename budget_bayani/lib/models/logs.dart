import 'package:budget_bayani/models/db_objects.dart';
// uses Abstract Class dbObject for Abstraction
class Logs extends dbObject{
  // Private Objects with Setters & Getters for Encapsulation
  int _id;
  DateTime _date;
  double _amount;

  Logs({
  required int id,
  required DateTime date,
  required double amount,
  }): _id = id, _date = date, _amount = amount;
  int get id => _id!;
  set id(int value) {
    _id = value;
  }
  DateTime get date => _date!;
  set date(DateTime value) {
    _date = value;
  }
  double get amount => _amount!;
  set amount(double value) {
    _amount = value;
  }
  @override
    Map<String, dynamic> toMap(){
      return{
        'id': id,
        'date': date,
        'amount': amount,
      };
    }
  @override
  String toString(){
    return 'Expense{id: $id, date: $date, amount: $amount}';
  }
}
// Inherited Class for Expenses and Income for Inheritance
class Expenses extends Logs{
  String? _expenseCategory;
  String? _expenseNote;
  Expenses ({
    required super.id,
    required super.date,
    required super.amount,
    required String expenseCategory,
    required String expenseNote
  }): _expenseCategory = expenseCategory, _expenseNote = expenseNote;
  String get expenseCategory => _expenseCategory!;
  set expenseCategory(String value) {
    _expenseCategory = value;
  }
  String get expenseNote => _expenseNote!;
  set expenseNote(String value) {
    _expenseNote = value;
  }

  // Method Override for Inherited Object for Polymorphism
  @override
    Map<String, dynamic> toMap(){
      return{
        'expenseId': id,
        'expenseDate': date,
        'expenseAmount': amount,
        'expenseCategory': expenseCategory,
        'expenseNote': expenseNote,
      };
    }
  @override
  String toString(){
    return 'Expense{expenseId: $id, expenseDate: $date, expenseAmount: $amount, expenseCategory: $expenseCategory, '
        'expenseNote: $expenseNote}';
  }
}
class Incomes extends Logs{
  String? _incomeCategory;
  String? _incomeNote;
  Incomes ({
    required super.id,
    required super.date,
    required super.amount,
    required String incomeCategory,
    required String incomeNote
  }): _incomeCategory = incomeCategory, _incomeNote = incomeNote;
  String get incomeCategory => _incomeCategory!;
  set incomeCategory(String value) {
    _incomeCategory = value;
  }
  String get incomeNote => _incomeNote!;
  set incomeNote(String value) {
    _incomeNote = value;
  }

  // Method Override for Inherited Object for Polymorphism
  @override
    Map<String, dynamic> toMap(){
      return{
        'incomeId': id,
        'incomeDate': date,
        'incomeAmount': amount,
        'incomeCategory': incomeCategory,
        'incomeNote': incomeNote,
      };
    }
  @override
  String toString(){
    return 'Income{incomeId: $id, incomeDate: $date, incomeAmount: $amount, incomeCategory: $incomeCategory, '
        'incomeNote: $incomeNote}';
  }
}