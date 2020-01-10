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
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _date;
  void _onSubmit() {
    String title = _titleController.text;
    double price = double.parse(_priceController.text);
    if (title == '' || price <= 0 || _date == null) {
      return;
    }
    widget._addTx(Transaction(
        title: title,
        price: price,
        date: _date,
        id: DateTime.now().toString()));
    Navigator.pop(context);
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      setState(() {
        _date = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _onSubmit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: _priceController,
                onSubmitted: (_) => _onSubmit(),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _date == null
                          ? 'No Date Choosen!'
                          : formatDate(_date, [M, ' ', dd, ' ,', ' ', yyyy]),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: _selectDate,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Trasaction',
                  style:
                      TextStyle(color: Theme.of(context).textTheme.button.color),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
