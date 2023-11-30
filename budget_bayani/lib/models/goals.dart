import 'db_objects.dart';
// Inheritance, Encapsulation
class Goal extends dbObject{
  int _goalId;
  String _goalName;
  DateTime _goalStart;
  DateTime _goalEnd;
  double _goalAmount;
  Goal({
    required int goalId,
    required String goalName,
    required DateTime goalStart,
    required DateTime goalEnd,
    required double goalAmount,
  }): _goalId = goalId, _goalName = goalName, _goalStart = goalStart, _goalEnd = goalEnd, _goalAmount = goalAmount;

  int get goalId => _goalId!;
  set goalId(int value) {
    _goalId = value;
  }

  String get goalName => _goalName!;
  set goalName(String value) {
    _goalName = value;
  }

  DateTime get goalStart => _goalStart!;
  set goalStart(DateTime value) {
    _goalStart = value;
  }

  DateTime get goalEnd => _goalEnd!;
  set goalEnd(DateTime value) {
    _goalEnd = value;
  }

  double get goalAmount => _goalAmount!;
  set goalAmount(double value) {
    _goalAmount = value;
  }

  @override
  Map<String, dynamic> toMap(){
    return{
      'goalId': goalId,
      'goalName': goalName,
      'goalStart': goalStart,
      'goalEnd': goalEnd,
      'goalAmount': goalAmount
    };
  }
  @override
  String toString(){
    return 'Goal{key: $goalId, name: $goalName, start: $goalStart, end: $goalEnd'
        'goalAmount: $goalAmount}';
  }
}