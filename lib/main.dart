import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';
import 'package:personalexpenses/widgets/chart.dart';
import 'package:personalexpenses/widgets/new-transaction.dart';
import 'package:personalexpenses/widgets/transaction-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        accentColor: Colors.yellow,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontSize: 18),
            button: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _startAddTx(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewTransaction(_addTx);
      },
    );
  }

  List<Transaction> _userTransactions = [];
  void _addTx(Transaction tx) => setState(() => _userTransactions.add(tx));
  void _deleteTx(String id) =>
      setState(() => _userTransactions.removeWhere((tx) => tx.id == id));
  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddTx(context),
          )
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            Expanded(
              child: TransactionList(_userTransactions, _deleteTx),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddTx(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
