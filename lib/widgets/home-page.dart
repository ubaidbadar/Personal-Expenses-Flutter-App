import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';
import 'package:personalexpenses/widgets/new-transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddingTransaction() {
    showModalBottomSheet(context: context, builder: (ctx){
      return NewTransaction(_addTx);
    });
  }
  final List<Transaction> _transactions = [];
  void _addTx(Transaction tx){
    _transactions.add(tx);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _startAddingTransaction,
          )
        ],
      ),
    );
  }
}
