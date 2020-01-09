import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;
  TransactionList(this._transactions, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                    child: Text(_transactions[index].price.toString())),
              ),
              title: Text(_transactions[index].title),
              subtitle: Text(formatDate(
                  _transactions[index].date, [M, ' ', dd, ', ', yyyy])),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => _deleteTx(_transactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}
