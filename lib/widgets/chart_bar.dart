import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  final double totalExpense;

// Defining Colors
  var barBcgColor = const Color(0x5087bfff);
  var barBorColor = const Color(0x4087bfff);

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal, this.totalExpense);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 20,
        child: FittedBox(
            child: Text(
          "₹${spendingAmount.toStringAsFixed(0)}",
          style: TextStyle(
              color: Colors.purple.shade50, fontWeight: FontWeight.w700),
        )),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 64,
        width: 10,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  // color: Colors.grey.shade700,
                  color: barBcgColor,
                  width: 0.4,
                ),
                // color: Color.fromRGBO(220, 220, 220, 0.3),
                color: barBcgColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      // Text(label, style: TextStyle(color: Colors.white60),),
      Text(
        label,
        style: TextStyle(color: Colors.white60),
      ),
    ]);
  }
}
