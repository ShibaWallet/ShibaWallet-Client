/*
 * Author : Johnny Cheung
 * Page: 设置页面的每一条item
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class TYSettingPageListTileWidget extends StatefulWidget {
  final int index;
  final String title;
  final String? trailingTitle;
  final double topMargin;
  final bool needBottomLine;
  final bool isTopRadius;
  final bool isBottomRadius;
  final bool isHiddenTrailingArrow;
  final VoidCallback onTap;
  TYSettingPageListTileWidget(
      {required this.index,
      required this.title,
      this.trailingTitle,
      this.topMargin = 0,
      this.needBottomLine = false,
      this.isTopRadius = false,
      this.isBottomRadius = false,
      this.isHiddenTrailingArrow = false,
      required this.onTap});

  @override
  State<StatefulWidget> createState() => _TYSettingPageListTileWidgetState();
}

class _TYSettingPageListTileWidgetState
    extends State<TYSettingPageListTileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listTile = ListTile(
      leading: null,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 17, color: PublicColors.pureBlack),
      ),
      trailing: Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.5),
            child: Text(
              widget.trailingTitle ?? "",
              style: TextStyle(fontSize: 16, color: PublicColors.mainBlack),
            ),
          ),
          Icon(Icons.chevron_right, color: widget.isHiddenTrailingArrow ? Colors.white : PublicColors.grayTitle,),
        ],
      ),
    );

    final radiusValue = Radius.circular(8);
    var decoration = BoxDecoration(
      color: PublicColors.pureWhite,
    );
    if (!widget.isTopRadius && !widget.isBottomRadius) {

    } else if (widget.isTopRadius && !widget.isBottomRadius) {
      decoration = BoxDecoration(
        color: PublicColors.pureWhite,
        borderRadius: BorderRadius.only(
          topLeft: radiusValue,
          topRight: radiusValue,
        ),
      );
    } else if (!widget.isTopRadius && widget.isBottomRadius) {
      decoration = BoxDecoration(
        color: PublicColors.pureWhite,
        borderRadius: BorderRadius.only(
          bottomLeft: radiusValue,
          bottomRight: radiusValue,
        ),
      );
    } else {
      decoration = BoxDecoration(
          color: PublicColors.pureWhite,
          borderRadius: BorderRadius.all(radiusValue));
    }

    Widget? _container;
    if (widget.needBottomLine) {
      _container = Wrap(
        direction: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: widget.topMargin, right: 20),
            decoration: decoration,
            child: listTile,
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 35, right: 35),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: PublicColors.grayNavLine, width: 0.5),
              ),
            ),
          ),
        ],
      );
    } else {
      _container = Container(
        margin: EdgeInsets.only(left: 20, top: widget.topMargin, right: 20),
        decoration: decoration,
        child: listTile,
      );
    }

    return GestureDetector(
      child: _container,
      onTap: () => widget.onTap(),
    );
  }
}
