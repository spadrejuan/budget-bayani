import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/screens/budget_planner.dart';
import 'package:flutter/material.dart';
import '../components/app_color.dart';
import '../models/limits.dart';

class SetLimit extends StatelessWidget {
  const SetLimit({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SetLimitForm(),
    );
  }
}

class SetLimitForm extends StatefulWidget {
  const SetLimitForm({super.key});
  @override
  State<SetLimitForm> createState() => _SetLimitFormState();
}

class _SetLimitFormState extends State<SetLimitForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dailyLimit = TextEditingController();
  TextEditingController weeklyLimit = TextEditingController();
  TextEditingController monthlyLimit = TextEditingController();
  late DBHelper db;

  @override
  void initState() {
    super.initState();
    db = DBHelper();
    db.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  Future<void> addLimit() async {
    if (dailyLimit.text.isNotEmpty) {
      Limit limit = Limit(limitAmount: double.parse(dailyLimit.text), limitThreshold: 'Daily');
      List<Limit> validator = await getOldLimits('Daily');
      if (validator == null) {
        await insertLimit(limit);
      }
      await deleteOldLimit('Daily');
      await insertLimit(limit);
    }
    if (weeklyLimit.text.isNotEmpty) {
      Limit limit = Limit(limitAmount: double.parse(weeklyLimit.text), limitThreshold: 'Weekly');
      List<Limit> validator = await getOldLimits('Weekly');
      if (validator == null) {
        await insertLimit(limit);
      }
      await deleteOldLimit('Weekly');
      await insertLimit(limit);
    }
    if (monthlyLimit.text.isNotEmpty) {
      Limit limit = Limit(limitAmount: double.parse(monthlyLimit.text), limitThreshold: 'Monthly');
      List<Limit> validator = await getOldLimits('Monthly');
      if (validator == null) {
        await insertLimit(limit);
      }
      await deleteOldLimit('Monthly');
      await insertLimit(limit);
    }
  }

  Future<int> insertLimit(Limit limit) async {
    return await db.insertLimit(limit);
  }

  Future<List<Limit>> getOldLimits(String string) async {
    return await db.retrieveLimitByThreshold(string);
  }

  Future<void> deleteOldLimit(String string) async {
    return await db.deleteLimitByThreshold(string);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Set Budget Limit'),
        backgroundColor: AppColors.PanelBGColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffCCD3D9),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BudgetPlanner(),
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
              await addLimit();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BudgetPlanner(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    style: const TextStyle(color: AppColors.TextColor),
                    controller: dailyLimit,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Daily Budget',
                      labelStyle: TextStyle(
                        color: AppColors.TextColor, fontSize: 20,
                      ),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: AppColors.TextColor),
                    controller: weeklyLimit,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Weekly Budget',
                      labelStyle: TextStyle(
                        color: AppColors.TextColor, fontSize: 20,
                      ),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: AppColors.TextColor),
                    controller: monthlyLimit,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Monthly Budget',
                      labelStyle: TextStyle(
                        color: AppColors.TextColor, fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
