import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/financial_goals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/app_color.dart';
import '../models/goals.dart';


class AddGoal extends StatelessWidget {
  const AddGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddGoalForm(),
    );
  }
}

class AddGoalForm extends StatefulWidget {
  const AddGoalForm({Key? key}) : super(key: key);

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
  void initState() {
    super.initState();
    db = DBHelper();
    _loadList();
  }


  Future<void> addGoal() async {
    String name = goalName.text;
    String start = DateFormat.yMMMd().format(DateTime.now());
    String end = DateFormat.yMMMd().format(DateTime.parse(goalEnd.text));
    double amount = double.parse(goalAmount.text);
    String incomeCategory = selectedCategory;
    Goal goal = Goal (goalName: name, goalStart: start, goalEnd: end, goalAmount: amount, incomeCategory: incomeCategory);
    await insertGoal(goal);
  }

  Future<int> insertGoal(Goal goal) async {
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
            color: Color(0xffCCD3D9),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const FinancialGoals(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Color(0xffCCD3D9),
            ),
            onPressed: () async {
              await addGoal();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const FinancialGoals(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildInputWithDivider(
                  label: 'Goal Target Date',
                  controller: goalEnd,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 1096)),
                    );
                    if (pickedDate != null) {
                      String goalDateFormatted = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        goalEnd.text = goalDateFormatted;
                      });
                    }
                  },
                ),
                buildInputWithDivider(
                  label: 'Goal Name',
                  controller: goalName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                buildInputWithDivider(
                  label: 'Goal Amount',
                  controller: goalAmount,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
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
                    setState(() {
                      selectedCategory=newVal!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputWithDivider({
    required String label,
    required TextEditingController controller,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          style: const TextStyle(color: AppColors.TextColor),
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: AppColors.TextColor,
              fontSize: 20,
            ),
          ),
          readOnly: onTap != null,
          onTap: onTap,
        ),

      ],
    );
  }
}
