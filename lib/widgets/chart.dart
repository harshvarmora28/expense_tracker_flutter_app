import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final List<Transaction> userTransactions;

  // Defining Colors
  var bcgColor = const Color(0xff1D0D25);
  var addIconColor = const Color(0xff577FFF);
  var cardBcgColor = const Color(0x90302636);
  var totalExpColor = const Color(0xffffd45e);

  Chart(this.recentTransactions, this.userTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 3),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  double get totalExpenses {
    double _total = 0.0;
    userTransactions.forEach(
      (expense) {
          _total = _total + expense.amount;
      },
    );
    return _total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: cardBcgColor,
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
        child: Column(
          children: [
            Text(
              "Expenses in the last 7 Days",
              style: TextStyle(color: Colors.white60),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data["day"],
                        data["amount"],
                        totalSpending == 0.0
                            ? 0.0
                            : (data["amount"] as double) / totalSpending,
                        totalExpenses == 0.0 ? 0.0 : (totalExpenses)));
              }).toList(),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.0),
              ),
              color: totalExpColor,
              elevation: 6,
              margin: EdgeInsets.only(top: 20, bottom: 3),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  width: 60,
                  height: 25,
                  child: FittedBox(
                    alignment: Alignment.center,
                    child: Text(
                      "₹${totalExpenses.toStringAsFixed(0)}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: bcgColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
