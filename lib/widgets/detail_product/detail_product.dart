import 'package:Midas/core/authentication/bloc/authentication_state.dart';
import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/core/authentication/models/profile_model.dart';
import 'package:Midas/core/cart/bloc/core_cart_event.dart';
import 'package:Midas/core/cart/bloc/index.dart';
import 'package:Midas/core/cart/cart_badge.dart';
import 'package:Midas/core/cart/model/cart_model.dart';
import 'package:Midas/core/cart/service/cart_service.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/detail_product/service/service_detail_product.dart';
import 'package:Midas/widgets/detail_product/widget/body_content_detail.dart';
import 'package:Midas/widgets/detail_product/widget/button_custom.dart';
import 'package:Midas/widgets/detail_product/widget/gallery_image.dart';
import 'package:Midas/widgets/detail_product/widget/modal_add_product_success.dart';
import 'package:Midas/widgets/detail_product/widget/placeholder.dart';
import 'package:Midas/widgets/my_library/models/sanpham_model.dart';
import 'package:Midas/widgets/quoc_gia/bloc/quocgia_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'bloc/detail_product_bloc.dart';
import 'model/gallery_item_model.dart';
import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/data-status/index.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/theme.dart';
import 'package:Midas/widgets/quan_ly_don_hang/widget/item_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProduct extends StatefulWidget {
  final String sanPhamId;
  DetailProduct({Key key, @required this.sanPhamId}) : super(key: key);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DetailProductBloc bloc;
  String urlShare;
  String subUrlShare;
  bool isLogin;
  LOAI_USER typeUser;
  @override
  void initState() {
    bloc = DetailProductBloc(
        service:
            DetailProductService(BlocProvider.of<ErrorhandleBloc>(context)));
    isLogin = (BlocProvider.of<AuthenticationBloc>(context).state)
        is AuthenticationAuthenticated;
    //login => get type user; not login => type unknown
    typeUser = isLogin
        ? (BlocProvider.of<AuthenticationBloc>(context).state
                as AuthenticationAuthenticated)
            .user
            .userEnum
        : LOAI_USER.UNKNOWN;
    bloc.add(GetData(sanPhamId: widget.sanPhamId, isPrivate: isLogin));
    urlShare = (BlocProvider.of<QuocgiaBloc>(context).state as DanhSachQuocgia)
        .confirm
        .linkWeb;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  _share() {
    if (urlShare != null) {
      Share.share('${urlShare}san-pham/chi-tiet/${subUrlShare}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorWhite,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              // shape: Border.all(color: colorGrey_3),
              backgroundColor: colorWhite,
              pinned: true,
              titleSpacing: 0,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorGrey_4,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/share.svg',
                    width: 30,
                    height: 30,
                    color: colorGrey_4,
                  ),
                  onPressed: _share,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingL),
                  child: CartBadge(
                    color: colorGrey_4,
                  ),
                )
              ]),
          BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, DetailProductState state) {
                if (state is LoadedData) {
                  subUrlShare = state.detail.urlSeo;
                  return SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GalleryImage(
                          items: mapDataImages(state.detail.image,
                              state.detail.hinhLienQuan, state.detail.videos),
                          hImgage: MediaQuery.of(context).size.height * 0.4,
                          hThumnail: 50,
                          wThumnail: 50,
                        ),
                        BodyContentDetail(
                            detail: state.detail, typeUser: typeUser)
                      ],
                    ),
                  );
                }
                //placeholder
                return SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PlaceholderGallery(),
                    PlaceholderBodyContent()
                  ],
                ));
              }),
        ],
      ),
      bottomNavigationBar: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, DetailProductState state) {
            if (state is LoadedData &&
                (state.detail.policy.length <= 0 ||
                    typeUser == LOAI_USER.SALON) &&
                !state.detail.hetHang) {
              return Container(
                height: kToolbarHeight + paddingXXS,
                padding: EdgeInsets.symmetric(
                  horizontal: paddingL,
                  vertical: paddingL,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: colorGrey_3, width: 1)),
                child: ButtonCustomDetail(
                  text: tr('product_details_4'),
                  onClick: () {
                    var item = new CartItemModel(
                        sanphamid: state.detail.id, listtinhchatids: []);
                    CoreCartService().addToCart(item).then((result) {
                      if (result) {
                        BlocProvider.of<CoreCartBloc>(context).add(AddToCart());
                        addCartSuccess(state.detail);
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(tr('product_details_8')),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    });
                  },
                  bgImage: true,
                ),
              );
            }
            if (state is LoadedData &&
                (state.detail.policy.length > 0 || state.detail.hetHang)) {
              return SizedBox();
            }
            return PlaceholderBottomButton();
          }),
    );
  }

  addCartSuccess(SanPhamModel detail) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: false,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              maxChildSize: 1,
              minChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ModalAddProductSuccess(detail: detail);
              },
            ),
          );
        });
  }

  mapDataImages(
      String hinhDaiDien, List<HinhLienQuan> images, List<VideoItem> videos) {
    List<GalleryItem> out = [];
    out.add(GalleryItem(
        id: hinhDaiDien,
        resource: hinhDaiDien,
        thumnail: hinhDaiDien,
        isVideo: false));
    videos.forEach((image) {
      out.add(GalleryItem(
          id: image.path,
          resource: image.path,
          thumnail: image.thumnail,
          isVideo: true));
    });
    images.forEach((image) {
      out.add(GalleryItem(
          id: image.path,
          resource: image.w520,
          thumnail: image.w280,
          isVideo: false));
    });
    return out;
  }
}
