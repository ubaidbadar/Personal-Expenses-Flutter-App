import 'package:flutter/material.dart';

final kMeQuery = (BuildContext context) => MediaQuery.of(context);
bool kIsLandScap (BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;