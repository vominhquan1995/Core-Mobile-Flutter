import 'package:Midas/widgets/detail_product/model/gallery_item_model.dart';
import 'package:Midas/widgets/shared/image-custom/image-custom.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'gallery_photo_view_wrapper.dart';

class GalleryImage extends StatefulWidget {
  final List<GalleryItem> items;
  final double hImgage;
  final double hThumnail;
  final double wThumnail;
  GalleryImage(
      {Key key,
      @required this.items,
      this.hImgage = 300,
      this.hThumnail = 50,
      this.wThumnail = 50})
      : assert(items != null, 'Required param items type List<GalleryItem>'),
        super(key: key);

  @override
  _GalleryImageState createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  dynamic index;
  dynamic images;
  dynamic thumnails;
  @override
  @override
  void initState() {
    super.initState();
    setState(() {
      index = 0;
    });
  }

  void open(BuildContext context, final String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          items: widget.items.where((x) => x.isVideo == false).toList(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialId: id,
          scrollDirection: Axis.horizontal,
          hThumnail: widget.hThumnail,
          wThumnail: widget.wThumnail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    thumnails = CarouselSlider.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int i) => Container(
        margin: const EdgeInsets.all(2.0),
        child: Container(
          height: widget.hThumnail,
          width: widget.wThumnail,
          decoration: index == i
              ? BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: const BorderRadius.all(Radius.circular(5)))
              : BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = i;
              });
              images.jumpToPage(i);
            }, // handle your image tap here
            child:
                HinhAnh(fit: BoxFit.contain, image: widget.items[i].thumnail),
          ),
        ),
      ),
      enlargeCenterPage: true, //effect scale item when scroll
      height: widget.wThumnail,
      viewportFraction: 0.2, //full screen
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
      enableInfiniteScroll: false, //cuộn qua lại
      initialPage: index,
      reverse: false, //đảo chiều list
      onPageChanged: (index) {},
    );
    images = CarouselSlider.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int i) => Container(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = i;
              });
            }, // handle your image tap here
            child: !widget.items[i].isVideo
                ? GestureDetector(
                    onTap: () {
                      open(context, widget.items[i].id);
                    }, // handle your image tap here
                    child: HinhAnh(
                        fit: BoxFit.contain, image: (widget.items[i].resource)),
                  )
                : YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                          widget.items[i].resource),
                      flags: YoutubePlayerFlags(
                          disableDragSeek: true,
                          controlsVisibleAtStart: true,
                          autoPlay: false,
                          hideControls: false,
                          hideThumbnail: false),
                    ),
                    showVideoProgressIndicator: false,
                  ),
          )),
      height: widget.hImgage,
      initialPage: index,
      reverse: false,
      enableInfiniteScroll: false,
      viewportFraction: 1.0, //full screen
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
      onPageChanged: (i) {
        setState(() {
          index = i;
        });
        thumnails.jumpToPage(i);
      },
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(aspectRatio: 5 / 4, child: images),
          thumnails
        ],
      ),
    );
  }
}
