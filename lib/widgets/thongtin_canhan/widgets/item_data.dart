import 'package:Midas/core/translate/public.dart';
import 'package:Midas/widgets/shared/border-dash/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Midas/utils/index.dart';
import 'package:shimmer/shimmer.dart';

class ItemData extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool lastItem;
  final bool titleBold;
  final String svg;
  final VoidCallback onTap;

  ///Màu chữ
  final Color color;
  ItemData({
    this.title,
    this.subtitle,
    this.lastItem = false,
    this.titleBold = false,
    this.svg,
    this.color = Colors.black,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   onTap: onTap,
    //   // isThreeLine: true,
    //   title: Text(
    //     title ?? "Chưa cập nhật",
    //     style: style13.copyWith(
    //         color: color,
    //         fontWeight: titleBold ? FontWeight.w600 : FontWeight.normal),
    //   ),
    //   subtitle: Text(
    //     subtitle,
    //     style: style13_lightgrey,
    //   ),
    // );
    return InkWell(
      onTap: onTap ?? null,
      child: Container(
        padding: const EdgeInsets.only(top: paddingL),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: svg != null ? paddingL : paddingM),
                  child: svg != null
                      ? SvgPicture.asset(
                          svg,
                          width: style28.fontSize,
                          height: style28.fontSize,
                        )
                      : null,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title ?? tr('profile_9'),
                        style: style13.copyWith(
                            color: color,
                            fontWeight: titleBold
                                ? FontWeight.w600
                                : FontWeight.normal),
                      ),
                      SizedBox(height: subtitle != null ? paddingS : 0),
                      subtitle != null
                          ? Text(
                              subtitle,
                              style: style13_lightgrey,
                            )
                          : SizedBox(height: 0),
                      SizedBox(height: subtitle != null ? paddingS : 0),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingL),
              child: MySeparator(
                color: colorGrey_1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemDataControl extends StatelessWidget {
  final String title;
  final bool lastItem;
  final String svg;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final bool noDetail;
  ItemDataControl(
      {this.title,
      this.lastItem = false,
      this.svg,
      this.onTap,
      this.noDetail = false,
      this.textStyle});
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: paddingL,
                      right: paddingL - (!lastItem ? 0.0 : 6.0)),
                  child: Center(
                    child: SvgPicture.asset(
                      svg,
                      width: 24,
                      height: 24,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(title, style: style13.merge(this.textStyle)),
                ),
                !noDetail
                    ? Padding(
                        padding: EdgeInsets.only(right: paddingL),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: paddingL,
                          color: colorGrey_2,
                        ),
                      )
                    : Container()
              ],
            ),
            SizedBox(height: paddingM),
            !lastItem
                ? Padding(
                    padding: EdgeInsets.only(
                        right: paddingL, left: paddingL + 16 + 24),
                    child: MySeparator(
                      color: colorGrey_2,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(right: paddingL, left: paddingL),
                    child: Divider(),
                  )
          ],
        ),
      ),
    );
  }
}

class ItemDataShimmmer extends StatelessWidget {
  final double height;

  ItemDataShimmmer({
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: svg != null ? paddingL : paddingM),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: borderSide.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                height: height,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: paddingS),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
