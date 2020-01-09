import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';
import 'package:personalexpenses/widgets/chart.dart';
import 'package:personalexpenses/widgets/new-transaction.dart';
import 'package:personalexpenses/widgets/transaction-list.dart';

import 'chart.dart';
import 'transaction-list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddingTransaction() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewTransaction(_addTx);
        });
  }

  final List<Transaction> _transactions = [];
  void _addTx(Transaction tx) {
    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
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
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTx)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _startAddingTransaction,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}