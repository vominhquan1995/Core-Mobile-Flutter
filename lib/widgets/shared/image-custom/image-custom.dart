import 'package:Core/utils/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HinhAnh extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final Color color;
  final Radius radius;
  HinhAnh({this.image, BoxFit fit, Color color, Radius radius})
      : assert(image != null),
        fit = fit ?? BoxFit.cover,
        color = color ?? colorGrey_1,
        radius = radius ?? Radius.circular(5);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(radius),
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => Container(
          color: color,
        ),
        fit: fit,
        errorWidget: (context, url, error) => Opacity(
          opacity: 0.5,
          child: Image.asset('assets/unnamed.jpg'),
        ),
      ),
    );
  }
}

class HinhAnhMemoryNetwork extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final Color color;
  HinhAnhMemoryNetwork({this.image, BoxFit fit, Color color})
      : assert(image != null),
        fit = fit ?? BoxFit.cover,
        color = color ?? colorGrey_1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: color),
        FadeInImage.memoryNetwork(
          key: Key(image),
          placeholder: kTransparentImage,
          fadeInDuration: Duration(milliseconds: 150),
          image: image,
          fit: fit,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}
