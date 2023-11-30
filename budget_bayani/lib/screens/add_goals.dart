import 'dart:ffi';

import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/financial_goals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/AppColor.dart';
import '../components/menu_bar.dart';
import '../models/goals.dart';
class AddGoal extends StatelessWidget {
  const AddGoal({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: AddGoalForm()
    );
  }
}
class AddGoalForm extends StatefulWidget {
  const AddGoalForm({super.key});

  @override
  State<AddGoalForm> createState() => _AddGoalFormState();
}

class _AddGoalFormState extends State<AddGoalForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController goalEnd = TextEditingController();
  TextEditingController goalName = TextEditingController();
  TextEditingController goalAmount = TextEditingController();
  List<String> sampleCategory = ['Salary', 'Saving'];
  String _selectedCategory = 'Salary';
  @override
  void initState(){
    goalEnd.text = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        drawer: SideMenuBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Financial Goals'),
          backgroundColor: AppColors.PanelBGColor,
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffCCD3D9)
            ),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const FinancialGoals(),
              ));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                  Icons.save,
                  color: Color(0xffCCD3D9)
              ),
              onPressed: () async{
                Goal newGoal = Goal(
                    goalName: goalName.text,
                    goalStart: DateTime.now().toIso8601String(),
                    goalEnd: DateTime.parse(goalEnd.text).toIso8601String(),
                    goalAmount: double.parse(goalAmount.text),
                    // To get again as DateTime: DateTime.tryParse(String);
                    incomeCategory: _selectedCategory
                );
                await DBHelper.createGoal(newGoal);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const FinancialGoals(),
                ));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  style: const TextStyle(color: AppColors.TextColor),
                  controller: goalEnd,
                  decoration: const InputDecoration(
                      labelText: 'Goal Target Date',
                      labelStyle: TextStyle(
                      color: AppColors.TextColor, fontSize: 20,
                      ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 1096))
                    );
                    if(pickedDate != null){
                      String goalDateFormatted = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        goalEnd.text = goalDateFormatted;
                      });
                    }
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: AppColors.TextColor),
                  controller: goalName,
                  decoration: const InputDecoration(
                      labelText: 'Goal Name',
                      labelStyle: TextStyle(
                      color: AppColors.TextColor, fontSize: 20,
                  ),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return ('This field cannot be empty');
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: AppColors.TextColor),
                  controller: goalAmount,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: 'Goal Amount',
                      labelStyle: TextStyle(
                      color: AppColors.TextColor, fontSize: 20,
                      ),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return ('This field cannot be empty');
                    }
                    return null;
                  },
                ),
                DropdownButton(
                  style: const TextStyle(color: AppColors.TextColor),
                  value: _selectedCategory,
                  items: sampleCategory.map((String val){
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                          val
                      ),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ],
            ),
          ),
            ],
          ),
        )
    );
  }
}
