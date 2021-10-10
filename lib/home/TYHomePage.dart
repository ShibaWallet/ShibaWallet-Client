/*
 * Author : Johnny Cheung
 * Page: 首页
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TYHomePage extends StatefulWidget {
  @override
  TYHomePageState createState() => TYHomePageState();
}

class TYHomePageState extends State<TYHomePage> {
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
  void didUpdateWidget(covariant TYHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("TYHomePage ------- ");
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
