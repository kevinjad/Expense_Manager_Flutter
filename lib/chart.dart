import './chartBar.dart';
import './transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  List<double> dayToAmt=[
      0,0,0,0,0,0,0
    ];
    double chartHeight;
  double maxAmount=0;
  Chart(List<Transaction> recentTransactions,double chartHeight){
    this.chartHeight=chartHeight;
    this.recentTransactions= recentTransactions;
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
    this.maxAmount=this.dayToAmt.reduce(max);
  }
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    print(recentTransactions);
    if(recentTransactions == [] || recentTransactions == null){
      maxAmount=1;
    }
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(chartHeight*0.05),
      child: Container(
          
          /*child: Row(children: [
            ChartBar('S',dayToAmt[0],dayToAmt[0]/maxAmount,chartHeight),
            
            /*ChartBar('M',dayToAmt[1],dayToAmt[1]/maxAmount,chartHeight),
            
            ChartBar('T',dayToAmt[2],dayToAmt[2]/maxAmount,chartHeight),
            
            ChartBar('W',dayToAmt[3],dayToAmt[3]/maxAmount,chartHeight),
            
            ChartBar('Th',dayToAmt[4],dayToAmt[4]/maxAmount,chartHeight),
            
            ChartBar('F',dayToAmt[5],dayToAmt[5]/maxAmount,chartHeight),
            
            ChartBar('Sa',dayToAmt[6],dayToAmt[6]/maxAmount,chartHeight),*/
          ],),*/
        ),
    );
  }
}
