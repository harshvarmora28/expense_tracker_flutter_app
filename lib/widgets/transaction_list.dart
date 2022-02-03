import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_complete_guide/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  // Defining Colors
  var cardBcgColor = const Color(0x90302636);
  var addIconColor = const Color(0xff577FFF);
  var bcgColor = const Color(0xff1b161d);

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 250,
                    child: Image.asset(
                      "assets/images/no_transactions_yet.png",
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "No transactions yet, Keep saving!",
                  style: TextStyle(
                      fontFamily: "SofiaPro",
                      fontSize: 18,
                      color: Colors.purple.shade50,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          : Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardBcgColor,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple.shade50,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              "₹${transactions[index].amount}",
                              style: TextStyle(
                                  color: bcgColor, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w200),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: addIconColor,
                        onPressed: () {
                          deleteTx(transactions[index].id);
                        },
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
          ),
    );
  }
}
