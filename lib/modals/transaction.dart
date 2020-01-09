import 'package:flutter/cupertino.dart';

class Transaction {
  String title;
  double price;
  String id;
  DateTime date;
  Transaction(
      {@required this.title,
      @required this.price,
      @required this.id,
      @required this.date});
}
