import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/widgets/user_transactions.dart';


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

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          Card(
            color: Colors.blue,
            child: Container(
              child: Text("Chart"),
              width: double.infinity,
            ),
            elevation: 8,
          ),
          UserTransactions()
        ],
      ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
