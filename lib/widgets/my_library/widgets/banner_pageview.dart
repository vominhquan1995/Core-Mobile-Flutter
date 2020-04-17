import 'package:Midas/widgets/my_library/models/banner_model.dart';
import 'package:Midas/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shimmer/shimmer.dart';

class BannerPageView extends StatelessWidget {
  final List<BannerModel> list;

  const BannerPageView({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      autoplay: true,
      autoplayDelay: 2500,
      itemBuilder: (BuildContext context, int index) {
        return HinhAnh(
          image: list[index].image,
          fit: BoxFit.cover,
          radius: Radius.zero,
        );
      },
      itemCount: list.length,
    );
  }
}

class BannerErrorPageView extends StatelessWidget {
  const BannerErrorPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.asset('assets/images/no_internet.png');
      },
      itemCount: 1,
    );
  }
}

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        width: double.infinity,
        height: 250,
        color: Colors.white,
      ),
    );
  }
}
