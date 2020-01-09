import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:personalexpenses/modals/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);
  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      double daySum = 0.0;
      double _totalPrice = 0;
      for (Transaction tx in _recentTransactions) {
        _totalPrice += tx.price;
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          daySum += tx.price;
        }
      }
      return {
        "price": daySum,
        "day": formatDate(weekDay, [D]),
        "ratio": (daySum / _totalPrice)
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  FittedBox(child: Text(data['price'].toString())),
                  Container(
                    height: 70,
                    width: 10,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: data['ratio'],
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(data['day']),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
