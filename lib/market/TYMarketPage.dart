/*
 * Author : Johnny Cheung
 * Page: 市场页面
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/market/widgets/TYMarketTradingTableRow.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class TYMarketPage extends StatefulWidget {
  @override
  TYMarketPageState createState() => TYMarketPageState();
}

class TYMarketPageState extends State<TYMarketPage> {
  late bool isFavoritesTab = false;

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
  void didUpdateWidget(covariant TYMarketPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    var pageScaffold = CupertinoPageScaffold(
      backgroundColor: PublicColors.pureWhite,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: PublicColors.pureWhite,
        padding: EdgeInsetsDirectional.only(start: 8, end: 8),
        middle: Row(
          children: [
            createFavoritesTab(onTap: () {
              _changeToFavoritesTab();
            }),
            createSpotTab(onTap: () {
              _changeToSpotTab();
            })
          ],
        ),
        trailing: GestureDetector(
          child: Icon(
            Icons.manage_search,
            color: PublicColors.mainBlack,
          ),
          onTap: () {},
        ),
        border: Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            width: 0.5,
            color: PublicColors.grayNavLine,
          ),
        ),
      ),
      child: Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(80),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(
              color: PublicColors.pureWhite,
            ),
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsetsDirectional.only(start: 10),
                height: 28,
                width: 110,
                child: Text("Name / 24H",
                    style:
                        TextStyle(fontSize: 11, color: PublicColors.grayTitle),
                    textAlign: TextAlign.left),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 10),
                height: 28,
                child: Text("Market Price",
                    style:
                        TextStyle(fontSize: 11, color: PublicColors.grayTitle),
                    textAlign: TextAlign.right),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsetsDirectional.only(end: 10),
                height: 28,
                width: 80,
                child: Text("Change%",
                    style:
                        TextStyle(fontSize: 11, color: PublicColors.grayTitle),
                    textAlign: TextAlign.right),
              ),
            ],
          ),
          TYMarketTradingTableRow().createWidgets()
        ],
      ),
    );
    return pageScaffold;
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  void _changeToFavoritesTab() {
    setState(() {
      isFavoritesTab = true;
    });
  }

  void _changeToSpotTab() {
    setState(() {
      isFavoritesTab = false;
    });
  }
}

// 创建UI
extension _UICreates_TYMarketPageState on TYMarketPageState {
  // 自选 tab
  GestureDetector createFavoritesTab({required GestureTapCallback onTap}) {
    var c = Container(
      height: 44,
      alignment: Alignment.centerLeft,
      child: Text(
        'Favorites',
        style: TextStyle(
          fontSize: 18,
          color:
              isFavoritesTab ? PublicColors.mainBlack : PublicColors.grayTitle,
          fontWeight: isFavoritesTab ? FontWeight.w800 : FontWeight.w700,
        ),
      ),
    );
    return GestureDetector(
      child: c,
      onTap: onTap,
    );
  }

  // 热度 tab
  GestureDetector createSpotTab({required GestureTapCallback onTap}) {
    var c = Container(
      margin: EdgeInsetsDirectional.only(start: 15),
      height: 44,
      alignment: Alignment.centerLeft,
      child: Text(
        'Hot',
        style: TextStyle(
          fontSize: 18,
          color:
              !isFavoritesTab ? PublicColors.mainBlack : PublicColors.grayTitle,
          fontWeight: !isFavoritesTab ? FontWeight.w800 : FontWeight.w700,
        ),
      ),
    );
    return GestureDetector(
      child: c,
      onTap: onTap,
    );
  }
}
