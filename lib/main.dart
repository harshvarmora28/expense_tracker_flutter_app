import 'package:flutter/material.dart';
import 'transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: "t1", title: "New Course", amount: 385, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Mobile Recharge", amount: 799, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.blue,
            child: Container(
              child: Text("Chart"),
              width: double.infinity,
            ),
            elevation: 8,
          ),
          Column(
              children: transactions.map((tx) {
            return Card(
              elevation: 5,
              child: Row(children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 1.4)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "₹${tx.amount}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(tx.title,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.purple),
                  ),
                  Text(tx.date.toString(),
                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  )
                ],)
              ],),
            );
          }).toList())
        ],
      ),
    );
  }
}
