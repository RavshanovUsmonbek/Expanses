import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ChartBar extends StatelessWidget {
  final double spendingAmount;
  final String label;
  final double spendingPctOfTotal;

  ChartBar({
    @required this.spendingAmount,
    @required this.label,
    @required this.spendingPctOfTotal,
  });


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
      return Column(
              children: <Widget> [
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(
                    child: Text(
                      '\$${this.spendingAmount.toStringAsFixed(0)}'
                    ),
                  ),
                ),
                SizedBox(
                  height:constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  width: 10,
                  child: Stack(children: <Widget>[
                    Container(decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width:1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    )),
                    FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],),
                ),
                SizedBox(
                  height:constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(
                          child: Text(
                          '${this.label}'
                        ),
                  ),
                ),
              ],
            );
    });
  }
}