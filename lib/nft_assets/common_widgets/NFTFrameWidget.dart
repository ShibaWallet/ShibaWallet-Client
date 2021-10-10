import 'package:flutter/material.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class NFTFrameWidget extends StatelessWidget {
  final Widget image;
  final double maxWidth;
  NFTFrameWidget({
    Key? key,
    required this.image,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    double margin = 15;
    final width = maxWidth;
    final height = maxWidth + margin * 2;
    double radiusValue = 8;
    final c = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(150),
            blurRadius: radiusValue,
            offset: Offset(8, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: margin / 2),
            width: width - margin,
            height: width - margin,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusValue / 2),
              child: image,
            ),
          ),
          Container(
            height: 15,
            alignment: Alignment.centerLeft,
            margin:
                EdgeInsets.only(left: margin / 2, top: 5, right: margin / 2),
            child: RichText(
              text: TextSpan(
                text: "NFT name      : ",
                style: TextStyle(
                  fontSize: 9.5,
                  color: PublicColors.grayTitle,
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "The Beauty of The Code",
                    style: TextStyle(
                      fontSize: 9.5,
                      color: PublicColors.mainBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 15,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: margin / 2, right: margin / 2),
            child: RichText(
              text: TextSpan(
                text: "NFT Token Id : ",
                style: TextStyle(
                  fontSize: 9.5,
                  color: PublicColors.grayTitle,
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "#1000",
                    style: TextStyle(
                      fontSize: 9.5,
                      color: PublicColors.mainBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return c;
  }
}
