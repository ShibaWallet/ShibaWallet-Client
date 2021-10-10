/*
 * Author : Johnny Cheung
 * Page: ListTile的丰富化
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class TYListTileWidget extends StatefulWidget {
  final int index;
  final String title;
  final String? subtitle;
  final String? trailingTitle;
  final double topMargin;
  final bool needBottomLine;
  final bool isTopRadius;
  final bool isBottomRadius;
  final bool isHiddenTrailingArrow;
  final VoidCallback? onTap;
  TYListTileWidget(
      {required this.index,
      required this.title,
      this.subtitle,
      this.trailingTitle,
      this.topMargin = 0,
      this.needBottomLine = false,
      this.isTopRadius = false,
      this.isBottomRadius = false,
      this.isHiddenTrailingArrow = false,
      this.onTap});

  @override
  State<StatefulWidget> createState() => _TYListTileWidgetState();
}

class _TYListTileWidgetState extends State<TYListTileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> trailingChildren = [];
    trailingChildren.add(
      Container(
        margin: EdgeInsets.only(top: 2.5),
        child: Text(
          widget.trailingTitle ?? "",
          style: TextStyle(fontSize: 16, color: PublicColors.mainBlack),
        ),
      ),
    );
    if (!widget.isHiddenTrailingArrow) {
      trailingChildren.add(Icon(
        Icons.chevron_right,
        color: PublicColors.grayTitle,
      ));
    }
    final listTile = ListTile(
      leading: null,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 17, color: PublicColors.pureBlack),
      ),
      subtitle: widget.subtitle == null ? null : Text(widget.subtitle!),
      trailing: Wrap(
        children: trailingChildren,
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
            padding: EdgeInsets.only(top: widget.subtitle == null ? 0 : 10),
            height: widget.subtitle == null ? 60 : 80,
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
        padding: EdgeInsets.only(top: widget.subtitle == null ? 0 : 10),
        height: widget.subtitle == null ? 60 : 80,
        decoration: decoration,
        child: listTile,
      );
    }

    return GestureDetector(
      child: _container,
      onTap: () => {
        if (widget.onTap != null) { widget.onTap!()}
      },
    );
  }
}
