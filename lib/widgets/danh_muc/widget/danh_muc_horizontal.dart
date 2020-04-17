import 'package:Core/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CongDungHorizontal extends StatelessWidget {
  final String linkImage;
  final String name;
  final Function onTap;

  const CongDungHorizontal({Key key, this.linkImage, this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: paddingL),
        width: 120,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundColor: colorGrey_2,
                backgroundImage: NetworkImage(linkImage),
              ),
            ),
            SizedBox(height: paddingM),
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: style13,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ThuongHieuHorizontal extends StatelessWidget {
  final String linkImage;
  final Function onTap;

  const ThuongHieuHorizontal({Key key, this.linkImage, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(right: paddingL, top: paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 150,
              child: Container(
                decoration: BoxDecoration(
                    color: colorGrey_2,
                    image: DecorationImage(
                        image: NetworkImage(
                          linkImage,
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CongDungHorizontalShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: List.generate(3, (int index) => buildShimmer()),
    );
  }

  buildShimmer() {
    return Container(
      margin: EdgeInsets.only(left: paddingM),
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 80,
            child: CircleAvatar(backgroundColor: colorGrey_2),
          ),
          SizedBox(height: paddingM),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: double.infinity,
              height: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
