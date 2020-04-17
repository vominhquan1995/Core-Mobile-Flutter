import 'package:Core/widgets/detail_product/model/gallery_item_model.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key key, this.galleryItem, this.onTap})
      : super(key: key);
  final GalleryItem galleryItem;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryItem.id,
          child: HinhAnh(fit: BoxFit.cover, image: (galleryItem.resource)),
        ),
      ),
    );
  }
}
