import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/financial_goals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/app_color.dart';
import '../models/goals.dart';
import '../models/income.dart';
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
  late DBHelper db;
  late List<Map<String,dynamic>> categories;
  late String selectedCategory;
  _loadList() async{
    categories = await db.retrieveIncomeCategories();
    selectedCategory = categories[0]['income_category'];
    setState(() {
    });
  }
  @override
  void initState(){
    super.initState();
    db = DBHelper();
    _loadList();
  }

  Future<void> addGoal() async{
    String name = goalName.text;
    String start = DateFormat.yMMMd().format(DateTime.now());
    String end = DateFormat.yMMMd().format(DateTime.parse(goalEnd.text));
    double amount = double.parse(goalAmount.text);
    String incomeCategory = selectedCategory;
    Goal goal = Goal (goalName: name, goalStart: start, goalEnd: end, goalAmount: amount, incomeCategory: incomeCategory);
    await insertGoal(goal);
  }
  Future<int> insertGoal (Goal goal) async{
    return await db.insertGoal(goal);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BGColor,
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
                    await addGoal();
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
                DropdownButton<String>(
                    value: selectedCategory==""? 'Others': selectedCategory,
                    hint: const Text('Pick category'),
                    items: categories?.map<DropdownMenuItem<String>>((Map<String, dynamic> val){
                      return DropdownMenuItem(
                        value: val['income_category'],
                        child: Text(val['income_category']),
                      );
                    })?.toList()??[],
                  onChanged: (newVal) async {
                    print(newVal);
                    setState(() {
                      selectedCategory=newVal!;
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
