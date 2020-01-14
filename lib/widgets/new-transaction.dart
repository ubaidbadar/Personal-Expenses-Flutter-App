import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTx;
  NewTransaction(this._addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();

  final _priceInputController = TextEditingController();

  DateTime _selectedDate;

  void _chooseDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDate) => setState(() => _selectedDate = selectedDate));
  }

  void _addTx() {
    final title = _titleInputController.text;
    final price = double.parse(_priceInputController.text);
    if (title == "" || price <= 0 || _selectedDate == null) {
      return;
    }
    widget._addTx(
      Transaction(
        title: title,
        price: price,
        date: _selectedDate,
        id: DateTime.now().toString(),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleInputController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Price",
              ),
              controller: _priceInputController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? "No date choosen!"
                      : formatDate(_selectedDate, [M, ' ', dd, ' ,', yyyy]),
                ),
                FlatButton(
                  child: Text(
                    "Choose Date",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () => _chooseDate(context),
                )
              ],
            ),
            RaisedButton(
              child: Text(
                "Save Transaction",
                style:
                    TextStyle(color: Theme.of(context).textTheme.button.color),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: _addTx,
            )
          ],
        ),
      ),
    );
  }
}
