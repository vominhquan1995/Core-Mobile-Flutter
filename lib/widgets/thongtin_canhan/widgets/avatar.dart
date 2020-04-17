import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Core/utils/index.dart';
import 'package:shimmer/shimmer.dart';

class Avatar extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatar;
  final VoidCallback loadAssets;
  Avatar({this.title, this.subtitle, this.avatar, this.loadAssets});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: 144,
                width: 138,
                color: Colors.grey[100],
              ),
              Container(
                  height: 144,
                  width: 138,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: borderSide.color,
                          width: borderSide.width,
                          style: borderSide.style)),
                  child: CachedNetworkImage(
                    imageUrl: avatar,
                    errorWidget: (BuildContext _, String s, Object object) {
                      return Image.asset('assets/no-image.jpg',
                          fit: BoxFit.cover);
                    },
                  )),
              // buildBtnUploadImage(),
            ],
          ),
          SizedBox(height: paddingM),
          Text(
            title ?? '',
            style: style15.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: paddingS),
          Text(
            subtitle ?? '',
            style: style13.copyWith(
                fontStyle: FontStyle.normal, color: Colors.black),
          ),
        ],
      ),
    );
  }

  buildBtnUploadImage() {
    return Container(
      width: 80,
      height: 30,
      padding:
          EdgeInsets.only(bottom: paddingS, left: paddingM, right: paddingM),
      child: RaisedButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(4.0)),
        color: Color.fromRGBO(255, 255, 255, 0.88),
        onPressed: loadAssets,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.camera_alt,
              size: 18,
            ),
            SizedBox(width: paddingS),
            Text(
              'Sửa',
              style: style13.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontStyle: FontStyle.normal),
            )
          ],
        ),
      ),
    );
  }
}

class AvatarShimmer extends StatelessWidget {
  final double height;
  AvatarShimmer({this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: paddingS),
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  color: Colors.white,
                  height: 144,
                  width: 138,
                ),
              ),
            ],
          ),
          // Container(
          //   height: 144,
          //   width: 138,
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //           color: Color.fromRGBO(112, 112, 112, 1),
          //           width: 1.0,
          //           style: BorderStyle.solid)),
          //   child: Image.network(
          //     'http://api.hutech.edu.vn/files/public/avatar/file/e5040d077d26814b9c64b06b8c8e5df9.png',
          //     fit: BoxFit.cover,
          //     scale: 138 / 144,
          //   ),
          // ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: 150,
              height: 10.0,
              color: Colors.white,
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: 100,
              height: 8.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
