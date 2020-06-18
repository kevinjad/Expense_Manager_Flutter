import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;
import './weekData.dart';
import './transaction.dart';
class Weekly_Chart extends StatelessWidget{
  List<Transaction> recentTransactions;
  List<WeekData> data=[];
  List<double> dayToAmt=[
      0,0,0,0,0,0,0
    ];
  Weekly_Chart(List<Transaction> recentTransactions){
    this.recentTransactions=recentTransactions;
    for(int i =0;i<recentTransactions.length;i++){
      if(recentTransactions[i].date.weekday == DateTime.sunday){
        dayToAmt[0] += recentTransactions[i].amount;
      }
      else if(recentTransactions[i].date.weekday == DateTime.monday){
        dayToAmt[1] += recentTransactions[i].amount;
      }
      else if(recentTransactions[i].date.weekday == DateTime.tuesday){
        dayToAmt[2] += recentTransactions[i].amount;
      }
      else if(recentTransactions[i].date.weekday == DateTime.wednesday){
        dayToAmt[3] += recentTransactions[i].amount;
      }
      else if(recentTransactions[i].date.weekday == DateTime.thursday){
        dayToAmt[4] += recentTransactions[i].amount;
      }
      else if(recentTransactions[i].date.weekday == DateTime.friday){
        dayToAmt[5] += recentTransactions[i].amount;
      }
      else if(recentTransactions[i].date.weekday == DateTime.saturday){
        dayToAmt[6] += recentTransactions[i].amount;
      }
    }
    data = [
      WeekData('S', dayToAmt[0]),
      WeekData('M', dayToAmt[1]),
      WeekData('T', dayToAmt[2]),
      WeekData('W', dayToAmt[3]),
      WeekData('Th', dayToAmt[4]),
      WeekData('F', dayToAmt[5]),
      WeekData('Sa', dayToAmt[6]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Charts.Series<WeekData,String>> series =[
      Charts.Series(data: data,
      id: "Data",
      domainFn: (WeekData wd,_){
        return wd.day;
      },
      measureFn: (WeekData wd,_){
        return wd.amount;
      },
      colorFn: (WeekData wd,_){
        return wd.barColor;
      }
      ,)
    ];

    return Charts.BarChart(series,animate: true,);
  }
}