import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import './addaptiveFlatButton.dart';

class NewTransaction extends StatefulWidget {
  Function saveFunction;

  NewTransaction(Function addFun){
    this.saveFunction = addFun;
  }

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(){
    String title = this._titleController.text;
    double amount = double.parse(this._amountController.text);

    if(title.isEmpty || amount <=0 || _selectedDate==null){
      return;
    }
    widget.saveFunction(title, amount, _selectedDate);
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top:10,
            left:10,
            right:10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ) ,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                controller: _amountController,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 
                      "No date chosen yet" : 
                      'Chosen Date: ${DateFormat.yMd().format(_selectedDate)}'
                    ),
                  ),
                  AddaptiveFlatButton(
                    label: 'Choose Date',
                    handler: _presentDatePicker,
                  ),
                ],
              ),
              FlatButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor, 
                child: Text(
                  "Add Transaction",
                  style:Theme.of(context).textTheme.button,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}