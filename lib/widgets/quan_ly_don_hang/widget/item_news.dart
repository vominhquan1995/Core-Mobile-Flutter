import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/shared/divider-custom/divider-custom.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsItemShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final widthtImage = MediaQuery.of(context).size.width * .25;
    final height = widthtImage * 2 / 3;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, i) {
          return Container(
            margin: EdgeInsets.only(
              bottom: paddingM,
            ),
            padding: EdgeInsets.only(
              bottom: paddingM,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: paddingL),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: double.infinity,
                        height: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: paddingL),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 200,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: paddingM),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 200,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: paddingM),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        width: 200,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: paddingM),
                    DividerCustom(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
