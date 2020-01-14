import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);
  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      double daySum = 0;
      double totalAmount = 0;
      for (Transaction tx in _recentTransactions) {
        totalAmount += tx.price;
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          daySum += tx.price;
        }
      }
      if (totalAmount == 0) {
        totalAmount = 1;
      }
      return {
        "day": formatDate(weekDay, [D]),
        "price": daySum,
        "ratio": daySum / totalAmount
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _groupedTransactionValues.map((data) {
            return Column(
              children: <Widget>[
                Text(data["day"]),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 60,
                  width: 10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12)),
                  child: FractionallySizedBox(
                    heightFactor: data["ratio"],
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Text(data["price"].toString()),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
