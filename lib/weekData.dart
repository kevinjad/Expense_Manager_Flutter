import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:flutter/material.dart';

class WeekData{
  String day;
  double amount;
  Charts.Color barColor=Charts.ColorUtil.fromDartColor(Colors.teal);

  WeekData(this.day,this.amount);
}