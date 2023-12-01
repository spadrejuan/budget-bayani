import 'db_objects.dart';
// Inheritance, Encapsulation
class Limit extends dbObject {
  int? limitId;
  double _limitAmount;
  String _limitThreshold;

  Limit({
    this.limitId,
    required double limitAmount,
    required String limitThreshold,
  })
      :
        _limitAmount = limitAmount,
        _limitThreshold = limitThreshold;

  double get limitAmount => _limitAmount;

  set limitAmount(double value) {
    _limitAmount = value;
  }

  String get limitThreshold => _limitThreshold;

  set limitThreshold(String value) {
    _limitThreshold = value;
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'limit_id': limitId,
      'limit_amount': limitAmount,
      'limit_threshold': limitThreshold
    };
  }
  Limit.fromMap(Map <String, dynamic> map)
      :
        limitId = map["limit_id"],
        _limitAmount = map["limit_amount"],
        _limitThreshold = map["limit_threshold"];

  @override
  String toString() {
    return 'Limit{key: $limitId, limitAmount: $limitAmount, limitThreshold: $limitThreshold}';
  }

}