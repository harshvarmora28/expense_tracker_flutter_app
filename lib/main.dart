import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wallet.me',
      home: MyHomePage(),
      theme: ThemeData(
          // primarySwatch: Colors.purple,
          primaryColor: Colors.purple.shade50,
          accentColor: Colors.blue.shade300,
          fontFamily: "SofiaPro",
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: "SofiaPro",
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [
    // Transaction(
    //     id: "t1", title: "New Course", amount: 385, date: DateTime.now()),
    // Transaction(
    //     id: "t2", title: "Mobile Recharge", amount: 799, date: DateTime.now())
  ];

  SharedPreferences sharedPreferences;

  // Defining Colors
  var bcgColor = const Color(0xff1b161d);
  var addIconColor = const Color(0xff577FFF);

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
    saveData();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: bcgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
      saveData();
    });
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData() {
    List<String> spList =
        _userTransactions.map((e) => json.encode(e.toMap())).toList();

    sharedPreferences.setStringList('list', spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');

    setState(() {
      _userTransactions =
          spList.map((e) => Transaction.fromMap(json.decode(e))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcgColor,
      appBar: AppBar(
        backgroundColor: bcgColor,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Dashboard',
            style:
                TextStyle(fontFamily: "SofiaPro", fontWeight: FontWeight.w600),
          ),
        ),
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions, _userTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.all(10.0),
        child: FloatingActionButton(
          backgroundColor: addIconColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
