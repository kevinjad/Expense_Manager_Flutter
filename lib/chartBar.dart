import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spendPctAmount;
  double height;
  ChartBar(this.label, this.spentAmount, this.spendPctAmount,this.height);

  @override
  Widget build(BuildContext context) {
    var inChartHeight = height-(2*height*0.05);
    var width = MediaQuery.of(context).size.width-(2*inChartHeight*0.05);
    return Container(
      margin: EdgeInsets.only(left:width*0.04,right: width*0.04),
      child: Column(
        children: <Widget>[
          Container(
            height: inChartHeight*.1,
            width: 22,
            child: FittedBox(
                          child: Text(
                '\$${spentAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            margin: EdgeInsets.only(top: inChartHeight*0.05,bottom: inChartHeight*0.05),
          ),
          
          Container(
            height: inChartHeight*0.53,
            width: 22,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                /*FractionallySizedBox(
                  heightFactor: this.spendPctAmount,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),*/
              ],
            ),
          ),
          
          Container(
            height: inChartHeight*.1,
            width: 22,
            child: FittedBox(
                          child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            margin: EdgeInsets.only(top: inChartHeight*0.05,bottom: inChartHeight*0.05),
          ),
        ],
      ),
    );
  }
}
