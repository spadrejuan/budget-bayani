import 'package:budget_bayani/screens/cash_flow_tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_bayani/db/db_helper.dart';
import 'package:budget_bayani/components/app_color.dart';
// import '../models/income.dart';
import '../models/income.dart';
import 'add_entries.dart';
import '../models/expense.dart';
class AddEntries2 extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
        home: AddEntries2Form()
    );
  }
}

class AddEntries2Form extends StatefulWidget{
  const AddEntries2Form({super.key});
  @override
  State<AddEntries2Form> createState() => _AddEntries2FormState();
}

class _AddEntries2FormState extends State<AddEntries2Form> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController incomeName= TextEditingController();
  TextEditingController incomeAmount = TextEditingController();
  TextEditingController incomeDate = TextEditingController();
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

  Future<void> addIncome() async{
    String note = incomeName.text;
    String date = DateTime.parse(incomeDate.text).toIso8601String();//DateTime.parse(incomeDate.text).toIso8601String();
    double amount = double.parse(incomeAmount.text);
    String incomeCategory = _selectedCategory;
    Incomes income = Incomes(date: date, amount: amount, category: incomeCategory, note: note);
    await insertIncome(income);
  }
  Future<int> insertIncome(Incomes income) async{
    return await db.insertIncome(income);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: AppColors.BGColor,
        appBar: AppBar(
          backgroundColor: AppColors.PanelBGColor,
          title: Text ('Income'),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children:[
              Container (
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
                          IncomeExpenseButton(context),
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
                                  controller: incomeDate,
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
                                      String incomeDateFormatted = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      setState(() {
                                        incomeDate.text = incomeDateFormatted;
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
                                        incomeDate.text += 'T' + formattedTime;
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
                                  controller: incomeAmount,
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
                                  controller: incomeName,
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
              ),
              Container(
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
                                onPressed: () async{
                                  await addIncome();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => CashFlowPage(),
                                  ));
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
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => CashFlowPage(),
                                  ))
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
              )
            ]
          )
        )
    );
  }
}


Widget IncomeExpenseButton(context) => Container(
    padding: EdgeInsets.only(top:15),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 1,
              child:ElevatedButton(
                  onPressed: ()=>{

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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AddEntries(),
                    ))
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
//
// //TODO add saving to database
// Widget SaveCancelButton = Container(
//     decoration: const BoxDecoration(
//         color: AppColors.PanelBGColor,
//         border: Border(
//           top: BorderSide(color: AppColors.StrokeColor, width:1.5),
//           bottom: BorderSide(color: AppColors.StrokeColor, width:1.5),
//         )
//     ),
//     margin: EdgeInsets.only(top:8),
//     padding: EdgeInsets.only(left: 20, right: 20),
//     child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//               flex: 2,
//               child:ElevatedButton(
//                   onPressed: ()=>{
//                     //TODO doSomething
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.BGColor,
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                             color: AppColors.StrokeColor,
//                             width: 1.5
//                         ),
//                       )
//                   ),
//                   child: const Text('Save',
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: AppColors.TextColor
//                     ),
//                   )
//               )
//           ),
//           SizedBox(width:20),
//           Expanded(
//               flex: 1,
//               child: ElevatedButton(
//                   onPressed: ()=>{
//                     //TODO doSomething
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.BGColor,
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                             color: AppColors.StrokeColor,
//                             width: 1.5
//                         ),
//                       )
//                   ),
//                   child: const Text('Cancel',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: AppColors.TextColor,
//                     ),
//                   )
//               )
//           ),
//         ]
//     )
// );

