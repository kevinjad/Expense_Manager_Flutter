import 'package:flutter/material.dart';
import './transaction.dart';
import './transactionCard.dart';

class Expenses extends StatelessWidget {
  List<Transaction> transactions;
  Function deleteTransaction;
  String currency;
  Expenses(List<Transaction> transactions, Function deleteTransaction,String currency) {
    this.transactions = transactions;
    this.deleteTransaction = deleteTransaction;
    this.currency=currency;
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return TransactionCard(transactions[index], this.deleteTransaction,currency);
          },
          itemCount: this.transactions.length,
        ),
      ),
    );
  }
}
