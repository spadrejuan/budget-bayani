import 'package:flutter/material.dart';
import 'package:budget_bayani/components/AppColor.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class AddEntries extends StatefulWidget {
  @override
  State<AddEntries> createState() => _AddEntriesState();
}

class _AddEntriesState extends State<AddEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: AppBar(
        backgroundColor: AppColors.PanelBGColor,
        title: Text ('something'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            AddEntriesForm(),
            SaveCancelButton,
            //TODO make SaveCancelButton Stretch to end of screen
          ]
        )
      )
    );
  }
}

Widget IncomeExpenseButton = Container(
  padding: EdgeInsets.only(top:15),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        flex: 1,
          child:ElevatedButton(
            onPressed: ()=>{
              //TODO doSomething
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.BGColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.StrokeColor,
                  width: 1.5,
              )
            ),

            ),
            child: const Text('Income',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.TextColor
              ),
            )
        )
      ),
      SizedBox(width:20),
      Expanded(
        flex: 1,
        child: ElevatedButton(
          onPressed: ()=>{
            //TODO doSomething
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.BGColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.StrokeColor,
                  width: 1.5
                ),
            )
          ),
          child: const Text('Expense',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.TextColor,
            ),
          )
        )
      ),
    ]
  )
);

class AddEntriesForm extends StatefulWidget {
  const AddEntriesForm({super.key});

  @override
  State<AddEntriesForm> createState() => _AddEntriesFormState();
}

class _AddEntriesFormState extends State<AddEntriesForm> {
  bool autoValidate = true;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.PanelBGColor,
            border: Border(
              top: BorderSide(color: AppColors.StrokeColor, width:1.5),
              bottom: BorderSide(color: AppColors.StrokeColor, width:1.5),
            )
        ),
        padding: EdgeInsets.only(left:20, right: 20, bottom: 30),
        child: FormBuilder(
          key: _formKey,
          onChanged: (){
            _formKey.currentState!.save();
            debugPrint(_formKey.currentState!.value.toString());
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              IncomeExpenseButton,
              //For Date and Time Picker
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text('Date: '),
                    )
                  ),
                  Expanded(
                    flex: 4,
                    child: FormBuilderDateTimePicker(
                      name: '',

                    )
                  ),
                ]
              ),
              Row (
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Category:')
                  ),
                  Expanded(
                    flex: 4,
                    child: FormBuilderTextField(
                      name: ''
                    )
                  )
                ]
              ),
              Row (
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text('Amount:')
                  ),
                  Expanded(
                      flex: 4,
                      child: FormBuilderTextField(
                        name: '',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ])
                      )
                  )
                ]
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text('Note:')
                  ),
                  Expanded(
                      flex: 4,
                      child: FormBuilderTextField(
                        name: '',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ])
                      )
                  )
                ]
              ),
            ]
          ),
        )
      )
    );
  }
}

//TODO add saving to database
Widget SaveCancelButton = Container(
  decoration: const BoxDecoration(
      color: AppColors.PanelBGColor,
      border: Border(
        top: BorderSide(color: AppColors.StrokeColor, width:1.5),
        bottom: BorderSide(color: AppColors.StrokeColor, width:1.5),
      )
  ),
  margin: EdgeInsets.only(top:8),
  padding: EdgeInsets.only(left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child:ElevatedButton(
              onPressed: ()=>{
                //TODO doSomething
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.BGColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.StrokeColor,
                      width: 1.5
                  ),
                )
              ),
              child: const Text('Save',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.TextColor
                ),
              )
          )
        ),
        SizedBox(width:20),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: ()=>{
                //TODO doSomething
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.BGColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.StrokeColor,
                      width: 1.5
                  ),
                )
              ),
              child: const Text('Cancel',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.TextColor,
                ),
              )
          )
        ),
      ]
    )
);

