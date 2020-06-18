import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserTransaction extends StatefulWidget {
  Function addTransaction;
  UserTransaction(Function addTransaction) {
    this.addTransaction = addTransaction;
  }

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  TextEditingController titleText = TextEditingController();

  TextEditingController amountText = TextEditingController();
  DateTime selectedDate;

  void presentDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
              2019,
            ),
            lastDate: DateTime.now())
        .then((value){
          if(value == null){
            return;
          }
          setState(() {
            this.selectedDate=value;
          });
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleText,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountText,
              keyboardType: TextInputType.number,
            ),
            Row(
              children: <Widget>[
                Text(
                    selectedDate == null ? "No date Chosen" : DateFormat.yMd().format(selectedDate),
                  style: TextStyle(fontFamily: 'Quicksand'),
                ),
                FlatButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: presentDate,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  if (titleText.text != '' && amountText.text != '') {
                    this.widget.addTransaction(
                        titleText.text, double.parse(amountText.text),selectedDate);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add transaction',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
