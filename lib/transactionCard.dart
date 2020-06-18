import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  Transaction transaction;
  Function deleteTransaction;
  String currency;
  TransactionCard(Transaction transaction,Function deleteTransaction,String currency) {
    this.transaction = transaction;
    this.deleteTransaction = deleteTransaction;
    this.currency=currency;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child:  Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3)),
                child: Text(
                  currency + this.transaction.amount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Quicksand'),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.transaction.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Quicksand'),
                  textAlign: TextAlign.left,
                ),
                Text(
                  DateFormat().format(this.transaction.date),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Spacer(),
            IconButton(
              
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: (){
                  deleteTransaction(this.transaction);
                }),
          ],
        ),
      
    );
  }
}
