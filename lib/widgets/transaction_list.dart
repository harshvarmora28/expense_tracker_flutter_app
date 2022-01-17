import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_complete_guide/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transactions.isEmpty ? Column(children: [
        SizedBox(
          height: 30,
        ),
        Container(
          height: 250,
          child: Image.asset("assets/images/no_transactions_yet.jpg", fit: BoxFit.cover,)),
          SizedBox(
            height: 30,
          ),
          Text("No transactions yet, Keep saving!", style: TextStyle(fontFamily: "OpenSans", fontSize: 18, fontWeight: FontWeight.bold),)
      ],) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
        elevation: 5,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor, width: 1.4)),
              padding: EdgeInsets.all(10),
              child: Text(
                "₹${transactions[index].amount.toStringAsFixed(2)}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactions[index].title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.purple),
                ),
                Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                )
              ],
            )
          ],
        ),
      ); 
        },
        itemCount: transactions.length,
        ),);
  }
}
