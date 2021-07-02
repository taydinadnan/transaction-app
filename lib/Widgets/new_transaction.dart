import 'package:flutter/material.dart';

class NewTransactiopn extends StatefulWidget {
  final Function addTx;

  NewTransactiopn(this.addTx);

  @override
  _NewTransactiopnState createState() => _NewTransactiopnState();
}

class _NewTransactiopnState extends State<NewTransactiopn> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Tittle'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              //onChanged: (value) {
              //  titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              //onChanged: (value) => amountInput = value,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Theme.of(context).primaryColorDark,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
