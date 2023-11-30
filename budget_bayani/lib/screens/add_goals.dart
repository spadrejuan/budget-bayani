import 'package:budget_bayani/screens/financial_goals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../components/AppColor.dart';
import '../components/menu_bar.dart';
import 'package:intl/intl.dart';
class AddGoal extends StatefulWidget {
  const AddGoal({super.key});
  @override
  State<AddGoal> createState() => _AddGoalState();
}
class _AddGoalState extends State<AddGoal> {
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
              onPressed: (){
                //TODO add saving to database
              },
            ),
          ],
          ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //TODO implement these widgets
              AddGoalForm()
            ],
          ),
        )
    );
  }
}
class AddGoalForm extends StatefulWidget {
  const AddGoalForm({super.key});

  @override
  State<AddGoalForm> createState() => _AddGoalFormState();
}

class _AddGoalFormState extends State<AddGoalForm> {

  bool autoValidate = true;
  final _formKey = GlobalKey<FormBuilderState>();
  var options = ['Male', 'Female', 'Other'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        onChanged: (){
          _formKey.currentState!.save();
          debugPrint(_formKey.currentState!.value.toString());
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            FormBuilderDateRangePicker(
                name: 'goal_range',
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 1000)),
                format: DateFormat('yyyy-MM-dd'),
                decoration: const InputDecoration(
                  labelText: 'Goal Range',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
            ),
            FormBuilderTextField(
                name: 'goal_name',
                decoration: const InputDecoration(
                  labelText: 'Goal Name:'
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
            ),
            FormBuilderTextField(
              name: 'goal_amount',
              decoration: const InputDecoration(
                  labelText: 'Amount:'
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
            ),
            // TODO: add here the connection to categories in income
            FormBuilderDropdown<String>(
              name: 'income_category',
              decoration: const InputDecoration(
                  labelText: 'Category:',
                  hintText: 'Select income category'
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              items: options.map((category) => DropdownMenuItem(
                alignment: AlignmentDirectional.center,
                value: category,
                child: Text(category),
              )).toList(),
              valueTransformer: (val) => val?.toString(),
            ),
          ],
        ),
      ),
    );
  }
}


