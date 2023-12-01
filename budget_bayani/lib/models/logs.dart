import 'package:budget_bayani/models/db_objects.dart';
// uses Abstract Class dbObject for Abstraction
class Logs extends dbObject{
  // Private Objects with Setters & Getters for Encapsulation
  int? id;
  String _date;
  double _amount;

  Logs({
  this.id,
  required String date,
  required double amount,
  }):
        // _id = id,
        _date = date,
        _amount = amount;

  String get date => _date;
  set date(String value) {
    _date = value;
  }

  double get amount => _amount;
  set amount(double value) {
    _amount = value;
  }

  @override
    Map<String, Object?> toMap(){
      return{
        'id': id,
        'date': date,
        'amount': amount,
      };
    }
    Logs.fromMap(Map <String, dynamic> map)
      :
      id = map["id"],
      _date = map["date"],
      _amount = map["amount"];

  @override
  String toString(){
    return 'Expense{id: $id, date: $date, amount: $amount}';
  }
}

// Inherited Class for Expenses and Income for Inheritance
class Expenses extends Logs{
  String _expenseCategory;
  String _expenseNote;
  String _date;
  double _amount;
  int? id;

  Expenses ({
    super.id,
    required super.date,
    required super.amount,
    required String expenseCategory,
    required String expenseNote
  }):
        _date = date,
        _amount = amount,
        _expenseCategory = expenseCategory,
        _expenseNote = expenseNote;

  String get date => _date;
  set date(String value) {
    _date = value;
  }

  double get amount => _amount;
  set amount(double value) {
    _amount = value;
  }

  String get expenseCategory => _expenseCategory;
  set expenseCategory(String value) {
    _expenseCategory = value;
  }

  String get expenseNote => _expenseNote;
  set expenseNote(String value) {
    _expenseNote = value;
  }

  // Method Override for Inherited Object for Polymorphism
  @override
  Map<String, Object?> toMap(){
    return{
      'expense_id': id,
      'expense_date': date,
      'expense_amount': amount,
      'expense_category': expenseCategory,
      'expense_note': expenseNote,
    };
  }
  @override
  Expenses.fromMap(Map <String, dynamic> map)
    :
      id = map["expense_id"],
      _date = map["expense_date"],
      _amount = map["expense_amount"],
      _expenseCategory = map["expense_category"],
      _expenseNote = map["expense_note"],
      super.fromMap(map);

  @override
  String toString(){
    return 'Expense{expenseId: $id, expenseDate: $date, expenseAmount: $amount, expenseCategory: $expenseCategory, '
        'expenseNote: $expenseNote}';
  }
}

class Incomes extends Logs{
  String _incomeCategory;
  String _incomeNote;
  String _date;
  double _amount;
  int? incId;

  Incomes ({
    this.incId,
    required super.date,
    required super.amount,
    required String incomeCategory,
    required String incomeNote
  }):
      _date = date,
      _amount = amount,
      _incomeCategory = incomeCategory,
      _incomeNote = incomeNote;

  String get date => _date;
  set date(String value) {
    _date = value;
  }

  double get amount => _amount;
  set amount(double value) {
    _amount = value;
  }

  String get incomeCategory => _incomeCategory;
  set incomeCategory(String value) {
    _incomeCategory = value;
  }

  String get incomeNote => _incomeNote;
  set incomeNote(String value) {
    _incomeNote = value;
  }

  // Method Override for Inherited Object for Polymorphism
  @override
    Map<String, Object?> toMap(){
      return{
        'incomeId': incId,
        'incomeDate': date,
        'incomeAmount': amount,
        'incomeCategory': incomeCategory,
        'incomeNote': incomeNote,
      };
    }
  @override
  Incomes.fromMap(Map <String, dynamic> map)
      :
        incId = map["incomeId"],
        _date = map["incomeDate"],
        _amount = map["expenseAmount"],
        _incomeCategory = map["incomeCategory"],
        _incomeNote = map["incomeNote"],
        super.fromMap(map);

  @override
  String toString(){
    return 'Income{incomeId: $id, incomeDate: $date, incomeAmount: $amount, incomeCategory: $incomeCategory, '
        'incomeNote: $incomeNote}';
  }
}