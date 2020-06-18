import 'dart:convert';

import './weekly_chart.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import './transaction.dart';
import './expenses.dart';
import './set_alert.dart';
import './userTransaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*List<Transaction> transactions = [
    Transaction('1', 'shoes', 5, DateTime.now()),
    Transaction('2', 'eggs', 5, DateTime.now()),
    Transaction('3', 'water', 5, DateTime.now())
  ];*/

  List<Transaction> transactions = [];
  String currency = '\$';
  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile() async {
    final path = await localPath();
    return File('$path/data.txt');
  }

  Future<File> writeContent(String s) async {
    final file = await localFile();
    // Write the file
    return file.writeAsString(s, mode: FileMode.write);
  }

  Future<String> readContent() async {
    try {
      final file = await localFile();
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  void addTransaction(String title, double amount, DateTime d) {
    if (d == null) {
      d = DateTime.now();
    }
    this.transactions.add(Transaction('4', title, amount, d));
    setState(() {
      writeContent(jsonEncode(transactions));
    });
  }

  void deleteTransaction(Transaction tx) {
    transactions.remove(tx);
    setState(() {
      writeContent(jsonEncode(transactions));
    });
  }

  void addUserTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return UserTransaction(addTransaction);
        });
  }

  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      if (value != "") {
        var R = jsonDecode(value) as List;
        this.transactions = R.map((l) {
          return Transaction.fromJson(l);
        }).toList();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> recentTransaction = [];
    recentTransaction = transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    var appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Expenses Manager',
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
      actions: [
        DropdownButton<String>(
          dropdownColor: Colors.black,
          value: currency,
          items:
              <String>['\$', '₹'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              child: Text(
                value,
                style: TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
              ),
              value: value,
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(() {
              currency = newValue;
            });
          },
        ),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addUserTransaction(context);
            })
      ],
    );
    var chartHeight = (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
        0.4;
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Text(
                'Expenses Manager',
                style: TextStyle(
                    fontFamily: 'Quicksand', fontSize: 20, color: Colors.white),
              )),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text(
                'Set Alert',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SetAlert();
                }));
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(20),
                  child: Weekly_Chart(recentTransaction)),
            ), //
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: Expenses(this.transactions, deleteTransaction, currency),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUserTransaction(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
