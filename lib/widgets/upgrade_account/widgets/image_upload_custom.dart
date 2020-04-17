import 'package:Midas/core/translate/public.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/shared/image-custom/image-custom.dart';
import 'package:Midas/widgets/upgrade_account/bloc_upload_image/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const heightUploadImage = 200.0;

class ImageUploadCustom extends StatelessWidget {
  String path;
  final UploadImageBloc blocImage;
  final Function onTap;
  ImageUploadCustom({
    Key key,
    this.path,
    @required this.blocImage,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: blocImage,
        builder: (BuildContext context, BlocUploadImageState state) {
          if (state is InitialBlocUploadImageState) {
            return BoxUploadImage(onTap: onTap);
          }
          if (state is ErrorBlocUploadImageState) {
            return BoxUploadImage(onTap: onTap, isError: true);
          }
          if (state is SuccessUploadImageState) {
            path = state.image;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: heightUploadImage,
                      width: MediaQuery.of(context).size.width,
                      child: HinhAnh(
                        image: state.image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Text(
                  tr('upgrade_salon_30'),
                  style: style15.copyWith(
                      color: colorBlue, fontStyle: FontStyle.italic),
                )
              ],
            );
          }
          return LinearProgressIndicator();
        });
  }
}

class BoxUploadImage extends StatelessWidget {
  final Function onTap;
  final bool isError;
  const BoxUploadImage({Key key, @required this.onTap, this.isError = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorBgImage),
      width: MediaQuery.of(context).size.width,
      height: heightUploadImage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isError
              ? Text(tr('upgrade_salon_43'),
                  style: style13.copyWith(color: colorRed))
              : Container(),
          GestureDetector(
            onTap: onTap,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/add_image.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
          SizedBox(height: paddingM),
          Text(tr('upgrade_salon_7'), style: style15),
          Text(tr('upgrade_salon_8'), style: style15),
        ],
      ),
    );
  }
}
