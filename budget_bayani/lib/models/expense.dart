import 'package:budget_bayani/models/db_objects.dart';
// uses Abstract Class dbObject for Abstraction
class Expenses extends dbObject{
  int? id;
  String _date;
  double _amount;
  String _category;
  String _note;

  Expenses ({
    this.id,
    required String date,
    required double amount,
    required String category,
    required String note
  }):
        _date = date,
        _amount = amount,
        _category = category,
        _note = note;

  String get date => _date;
  set date(String value) {
    _date = value;
  }

  double get amount => _amount;
  set amount(double value) {
    _amount = value;
  }

  String get category => _category;
  set expenseCategory(String value) {
    _category = value;
  }

  String get note => _note;
  set note(String value) {
    _note = value;
  }

  // Method Override for Inherited Object for Polymorphism
  @override
  Map<String, Object?> toMap(){
    return{
      'expense_id': id,
      'expense_date': date,
      'expense_amount': amount,
      'expense_category': category,
      'expense_note': note,
    };
  }
  @override
  Expenses.fromMap(Map <String, dynamic> map)
    :
      id = map["expense_id"],
      _date = map["expense_date"],
      _amount = map["expense_amount"],
      _category = map["expense_category"],
      _note = map["expense_note"];

  @override
  String toString(){
    return 'Expense{expenseId: $id, expenseDate: $date, expenseAmount: $amount, expenseCategory: $category, '
        'expenseNote: $note}';
  }
}
//
// class Incomes extends dbObject{
//   int? id;
//   String _date;
//   double _amount;
//   String _category;
//   String _note;
//
//   Incomes ({
//     this.id,
//     required String date,
//     required double amount,
//     required String category,
//     required String note,
//   }):
//       _date = date,
//       _amount = amount,
//       _category = category,
//       _note = note;
//
//   String get date => _date;
//   set date(String value) {
//     _date = value;
//   }
//
//   double get amount => _amount;
//   set amount(double value) {
//     _amount = value;
//   }
//
//   String get category => _category;
//   set category(String value) {
//     _category = value;
//   }
//
//   String get note => _note;
//   set note(String value) {
//     _note = value;
//   }
//
//   // Method Override for Inherited Object for Polymorphism
//   @override
//     Map<String, Object?> toMap(){
//       return{
//         'income_id': id,
//         'income_date': date,
//         'income_amount': amount,
//         'income_category': category,
//         'income_note': note,
//       };
//     }
//   @override
//   Incomes.fromMap(Map <String, dynamic> map)
//       :
//         id = map["income_id"],
//         _date = map["income_date"],
//         _amount = map["income_amount"],
//         _category = map["income_category"],
//         _note = map["income_note"];
//         // super.fromMap(map);
//
//   // @override
//   String toString(){
//     return 'Income{incomeId: $id, incomeDate: $date, incomeAmount: $amount, incomeCategory: $category, '
//         'incomeNote: $note}';
//   }
// }