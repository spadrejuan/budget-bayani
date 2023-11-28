import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Goal{
  final int goal_key;
  final String goal_name;
  final DateTime goal_start;
  final DateTime goal_end;

  const Goal({
    required this.goal_key,
    required this.goal_name,
    required this.goal_start,
    required this.goal_end,
  });

  Map<String, dynamic> toMap(){
    return{
      'key': goal_key,
      'name': goal_name,
      'start': goal_start,
      'end': goal_end
    };
  }
  @override
  String toString(){
    return 'Goal{key: $goal_key, name: $goal_name, start: $goal_start, end: $goal_end}';
  }
}