import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/Widgets/adaptive_flat_button.dart';

class NewTransactiopn extends StatefulWidget {
  final Function addTx;

  NewTransactiopn(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactiopnState createState() {
    print('createState NewTransaction Widget');
    return _NewTransactiopnState();
  }
}

class _NewTransactiopnState extends State<NewTransactiopn> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactiopnState() {
    print('Constructor NewTransaction Widget');
  }
  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransactiopn oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedData;
      });
    });
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Tittle'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                //onChanged: (value) {
                //  titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                //onChanged: (value) => amountInput = value,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    // ignore: deprecated_member_use
                    AdaptiveFlatButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              Platform.isIOS
                  ? CupertinoButton(
                      color: Colors.orange[400],
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _submitData,
                    )
                  // ignore: deprecated_member_use
                  : RaisedButton(
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: _submitData,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
