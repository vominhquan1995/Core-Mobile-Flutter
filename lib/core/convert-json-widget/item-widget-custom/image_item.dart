import 'dart:async';
import 'dart:developer';

import 'package:Midas/utils/index.dart';

import 'index.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

var allowedExtension = ['.jpeg', '.jpg', '.png', '.gif', '.bmp'];

class ImageItemWidget extends StatelessWidget {
  final dynamic data;

  const ImageItemWidget({Key key, this.data}) : super(key: key);
  bool checkFormat(String input) {
    bool result = false;
    allowedExtension.forEach((x) {
      if (input.contains(x)) {
        result = true;
      }
    });
    return result;
  }

  buildItem(context) {
    var url = data["file"] != null ? data['file']['url'] : data['url'];
    return CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: url,
        imageBuilder: (context, imageProvider) {
          if (!checkFormat(imageProvider.toString())) {
            return Container(
              color: colorGrey_2,
              width: MediaQuery.of(context).size.width,
              // height: 50,
              child: Center(
                  child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.warning, color: colorGrey_1),
                  Container(
                    margin: EdgeInsets.only(left: paddingM),
                    child: Text("Hình ảnh này không hiển thị được",
                        style: style15),
                  )
                ],
              )),
            );
          }
          return Image(image: imageProvider);
        },
        placeholder: (context, url) => Container(
              color: colorGrey_1,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
        errorWidget: (context, url, error) {
          return Container(
            color: colorGrey_2,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Center(
                child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.warning, color: colorGrey_1),
                Container(
                  margin: EdgeInsets.only(left: paddingM),
                  child:
                      Text("Hình ảnh này không hiển thị được", style: style15),
                )
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: paddingL),
              decoration: BoxDecoration(
                border: data["withBorder"] == true
                    ? Border.all(width: 0.5, color: colorGrey_1)
                    : Border.all(width: 0.0, color: Colors.transparent),
                color: data["withBackground"] == true
                    ? colorGrey_2
                    : Colors.transparent,
              ),
              child: buildItem(context)),
          data['caption'] != null && data['caption'].trim().length != 0
              ? Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: paddingL),
                  padding: EdgeInsets.all(paddingL),
                  decoration: BoxDecoration(
                      color: colorGrey_2,
                      border: Border.all(width: 0.5, color: colorGrey_1)),
                  child: Text(
                    data['caption'],
                    style: style10,
                  ),
                )
              : Container(
                  height: 0,
                )
        ],
      ),
    );
  }
}
