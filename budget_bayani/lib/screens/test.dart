import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {

  var db;
  int count = 0;
  @override
  void initState() {
    tableIsEmpty();
    super.initState();
  }
  void tableIsEmpty()async{
    db = await openDatabase('budget_bayani.db');
    count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM incomes'))!;
    print(count);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text( (count == 0)?'Table  is empty':'$count entries in the table'
        ),
      ),
    );
  }
}