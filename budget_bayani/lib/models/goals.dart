import 'db_objects.dart';
// Inheritance, Encapsulation
class Goal extends dbObject {
  int? goalId;
  String _goalName;
  String _goalStart;
  String _goalEnd;
  double _goalAmount;
  String _incomeCategory;

  Goal({
    this.goalId,
    required String goalName,
    required String goalStart,
    required String goalEnd,
    required double goalAmount,
    required String incomeCategory,
  })
      : _goalName = goalName,
        _goalStart = goalStart,
        _goalEnd = goalEnd,
        _goalAmount = goalAmount,
        _incomeCategory = incomeCategory;


  String get goalName => _goalName;

  set goalName(String value) {
    _goalName = value;
  }

  String get goalStart => _goalStart;

  set goalStart(String value) {
    _goalStart = value;
  }

  String get goalEnd => _goalEnd;

  set goalEnd(String value) {
    _goalEnd = value;
  }

  double get goalAmount => _goalAmount;

  set goalAmount(double value) {
    _goalAmount = value;
  }

  String get incomeCategory => _incomeCategory;

  set incomeCategory(String value) {
    _incomeCategory = value;
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'goal_id': goalId,
      'goal_name': goalName,
      'goal_start': goalStart,
      'goal_end': goalEnd,
      'goal_amount': goalAmount,
      'income_category': incomeCategory
    };
  }
  Goal.fromMap(Map <String, dynamic> map)
    :
      goalId = map["goal_id"],
      _goalName = map["goal_name"],
      _goalStart = map["goal_start"],
      _goalEnd = map["goal_end"],
      _goalAmount = map["goal_amount"],
      _incomeCategory = map["income_category"];

  @override
  String toString() {
    return 'Goal{key: $goalId, name: $goalName, start: $goalStart, end: $goalEnd'
        'goalAmount: $goalAmount, incomeCategory: $incomeCategory}';
  }

}