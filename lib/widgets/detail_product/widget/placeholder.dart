
import 'package:Core/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderBodyContent extends StatelessWidget {
  const PlaceholderBodyContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.fromLTRB(
          paddingL, paddingM, paddingL, paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PlaceholderItem(),
          PlaceholderItem(height: 30),
          SizedBox(height: paddingM),
          PlaceholderItem(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          SizedBox(height: paddingM),
          PlaceholderItem(),
        ],
      ),
    );
  }
}

class PlaceholderBottomButton extends StatelessWidget {
  const PlaceholderBottomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: paddingXS, vertical: paddingM),
      height: 50,
      child: PlaceholderItem(height: 30),
    );
  }
}

class PlaceholderItem extends StatelessWidget {
  final double height;
  final double width;
  const PlaceholderItem({Key key, this.height = 20, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: paddingS),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          width: width != null ? width : MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
      ),
    );
  }
}

class PlaceholderGallery extends StatelessWidget {
  const PlaceholderGallery({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: const EdgeInsets.all(paddingL),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
      ),
    );
  }
}