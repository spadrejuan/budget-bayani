import 'package:budget_bayani/models/db_objects.dart';
// Inheritance, Encapsulation
class Limits extends dbObject{
  int? _limitId;
  double? _limitNumber;

  int get limitId => _limitId!;
  set limitId(int value) {
    _limitId = value;
  }
  double get limitNumber => _limitNumber!;
  set limitNumber(double value) {
    _limitNumber = value;
  }

  @override
  Map<String, dynamic> toMap(){
    return{
      'limitId': limitId,
      'limitNumber': limitNumber,
    };
  }
  @override
  String toString(){
    return 'Limit{limitId: $limitId, limitNumber: $limitNumber}';
  }
}