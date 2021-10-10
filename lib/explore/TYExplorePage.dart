/*
 * Author : Johnny Cheung
 * Page: 探索
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TYExplorePage extends StatefulWidget {
  @override
  TYExplorePageState createState() => TYExplorePageState();
}

class TYExplorePageState extends State<TYExplorePage> {
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
  void didUpdateWidget(covariant TYExplorePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("TYExplorePage ------- ");
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
