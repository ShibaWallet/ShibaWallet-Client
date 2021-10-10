import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class TYMarketTradingTableRow {
  
  late TableRow tableRow;

  TableRow createWidgets() {
    tableRow = TableRow(
      decoration: BoxDecoration(
        color: Colors.blue, //PublicColors.pureWhite,
      ),
      children: <Widget>[
        Container(
          height: 55,
          color: Colors.purple,
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 32,
          color: Colors.yellow,
        ),
        Center(
          child: Container(
            height: 32,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PublicColors.buttonRed,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              "+50%",
              style: TextStyle(
                fontSize: 15,
                color: PublicColors.pureWhite,
              ),
            ),
          ),
        ),
      ],
    );
    return tableRow;
  }
}
