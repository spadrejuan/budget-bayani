import 'package:budget_bayani/screens/cash_flow_tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/components/AppColor.dart';

import '../models/logs.dart';



class AddEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: AddEntriesForm()
    );
  }
}

class AddEntriesForm extends StatefulWidget{
  const AddEntriesForm({super.key});
  @override
  State<AddEntriesForm> createState() => _AddEntriesFormState();
}

class _AddEntriesFormState extends State<AddEntriesForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController expenseName= TextEditingController();
  TextEditingController expenseAmount = TextEditingController();
  TextEditingController expenseDate = TextEditingController();
  List<String> sampleCategory = ['Food', 'Transporations'];
  String _selectedCategory = 'Food';

  late DBHelper db;
  @override
  void initState(){
    super.initState();
    db = DBHelper();
    db.initDB().whenComplete(() async{
      setState(() {});
    });
  }

  Future<void> addExpense() async{
    String note = expenseName.text;
    String date = DateTime.parse(expenseDate.text).toIso8601String();//DateTime.parse(expenseDate.text).toIso8601String();
    double amount = double.parse(expenseAmount.text);
    String expenseCategory = _selectedCategory;
    Expenses expense = Expenses (date: date, amount: amount, expenseCategory: expenseCategory, expenseNote: note);
    await insertExpense(expense);
  }
  Future<int> insertExpense(Expenses expense) async{
    return await db.insertExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: AppBar(
        backgroundColor: AppColors.PanelBGColor,
        title: Text ('something'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffCCD3D9)
          ),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CashFlowPage(),
            ));
          }
        ),
        actions: <Widget>[
          IconButton(
          icon: const Icon(
              Icons.save,
              color: Color(0xffCCD3D9)
          ),
          onPressed: () async{
            await addExpense();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => CashFlowPage(),
            ));
          },
        ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container (
          decoration: const BoxDecoration(
            color: AppColors.PanelBGColor,
            border: Border(
              top: BorderSide(color: AppColors.StrokeColor, width:1.5),
              bottom: BorderSide(color: AppColors.StrokeColor, width:1.5),
            )
          ),
          padding: EdgeInsets.only(left:20, right: 20, bottom: 30),
          child: Column(
            children:[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    IncomeExpenseButton,
                    //For Date and Time Picker
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text('Date: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.TextColor
                              )
                            ),
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            style: const TextStyle(color: AppColors.TextColor),
                            controller: expenseDate,
                            // decoration: const InputDecoration()
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now().subtract(const Duration(days: 50)),
                                lastDate: DateTime.now().add(const Duration(days: 1096))
                              );
                              if(pickedDate != null){
                                String expenseDateFormatted = DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  expenseDate.text = expenseDateFormatted;
                                });
                              }
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if(pickedTime != null){
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                setState(() {
                                  expenseDate.text += 'T' + formattedTime;
                                });
                              }
                            }
                          ),
                        ),
                      ]
                    ),
                    Row (
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('Category:',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.TextColor
                            )
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child: DropdownButton(
                            style: const TextStyle(color: AppColors.TextColor),
                            value: _selectedCategory,
                            items: sampleCategory.map((String val){
                              return DropdownMenuItem(
                                value:val,
                                child: Text(val),
                              );
                            }).toList(),
                            onChanged: (value){
                              setState((){
                                _selectedCategory = value!;
                              });
                            }
                          )
                        )
                      ]
                    ),
                    Row (
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text('Amount:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.TextColor
                            )
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child:TextFormField(
                            style: const TextStyle(color: AppColors.TextColor),
                            controller: expenseAmount,
                            keyboardType: TextInputType.phone,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return ('This field cannot be empty');
                              }
                              return null;
                            },
                          ),
                        )
                      ]
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('Note:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.TextColor
                            )
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            style: const TextStyle(color: AppColors.TextColor),
                            controller: expenseName,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return ('This field cannot be empty');
                              }
                              return null;
                            }
                          ),
                        )
                      ]
                    ),
                  ]
                ),
              )
            ],
          )
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

