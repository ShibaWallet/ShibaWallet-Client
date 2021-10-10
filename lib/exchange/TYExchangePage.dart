/*
 * Author : Johnny Cheung
 * Page: 交易页面
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';


class TYExchangePage extends StatefulWidget {
  @override
  TYExchangePageState createState() => TYExchangePageState();
}

class TYExchangePageState extends State<TYExchangePage> {
  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  bool get mounted {
    print("mounted");
    return super.mounted;
  }

  @override
  void didUpdateWidget(covariant TYExchangePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("TYExchangePage ------- ");
    return Container(
      color: Color.fromARGB(1, 1, 1, 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }
}
