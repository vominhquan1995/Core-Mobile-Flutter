import 'package:Core/utils/index.dart';
import 'package:Core/widgets/detail_product/model/option.model.dart';
import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/shared/image-custom/image-custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'body_content_detail.dart';

class SelectOptionProduct extends StatefulWidget {
  final SanPhamModel data;
  SelectOptionProduct({Key key, @required this.data}) : super(key: key);

  @override
  _SelectOptionProductState createState() => _SelectOptionProductState();
}

class _SelectOptionProductState extends State<SelectOptionProduct> {
  List<OptionModel> selected = [];
  List<OptionModel> colors = [
    OptionModel(key: 'color', title: 'Màu đỏ', value: '5000', active: false),
    OptionModel(key: 'color', title: 'Màu vàng', value: '6000', active: false),
    OptionModel(key: 'color', title: 'Màu xanh', value: '7000', active: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPurple,
        automaticallyImplyLeading: false,
        title: Text(
          'Lựa chọn thuộc tính',
          style: style17_semibold.copyWith(color: colorWhite),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: colorWhite,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
              delegate: HeaderInfoCustom(
                  data: widget.data,
                  height: MediaQuery.of(context).size.height * 0.3)),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: paddingL, vertical: paddingL),
              color: colorBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //color
                  TitleBoxOption(
                      title: 'Màu sắc', text: getTitleActive(colors)),
                  SizedBox(height: paddingL),
                  GridView.builder(
                      physics: new NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: colors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: paddingL,
                          mainAxisSpacing: paddingM),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: colors[index].active
                              ? BoxDecoration(
                                  color: colorWhite,
                                  border:
                                      Border.all(color: colorBlue, width: 1))
                              : BoxDecoration(color: colorWhite),
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: FlatButton(
                              onPressed: () {
                                onSelectOption(colors[index]);
                                setState(() {});
                                // widget.onSelect(colors[index]);
                              },
                              child: Text(
                                colors[index].title,
                                style: style15_lightgrey,
                                textAlign: TextAlign.center,
                              )),
                        );
                      })
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: colorBackground,
        child: Padding(
          padding: EdgeInsets.all(paddingL),
          child: FlatButton(
              color: colorOrange,
              onPressed: () {},
              child: Text('Xong', style: style17.copyWith(color: colorWhite))),
        ),
      ),
    );
  }

  String getTitleActive(List<OptionModel> items) {
    var item = items.where((f) => f.active == true);
    return item.isNotEmpty ? item.first.title : '';
  }

  onSelectOption(OptionModel item) {
    if (selected.where((f) => f.key == item.key).isEmpty) {
      selected.add(item);
    } else if (selected
        .where((f) => f.key == item.key && f.title == item.title)
        .isNotEmpty) {
      //exist item click on group => unselect
      selected.removeWhere((f) => f.key == item.key);
    } else {
      selected = [];
      selected.add(item);
    }
    //set active
    colors.forEach((f) {
      if (selected.isNotEmpty &&
          f.key == selected.first?.key &&
          f.title == selected.first?.title) {
        f.active = true;
      } else {
        f.active = false;
      }
    });
  }
}
class TitleBoxOption extends StatelessWidget {
  const TitleBoxOption({
    Key key,
    @required this.title,
    @required this.text,
  }) : super(key: key);
  final String text;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text('$title: $text',
        style: style17_semibold.copyWith(color: colorGrey_3));
  }
}

class BoxSelectOption extends StatefulWidget {
  final List<OptionModel> items;
  final Function(OptionModel item) onSelect;
  BoxSelectOption({Key key, @required this.items, @required this.onSelect})
      : super(key: key);

  @override
  _BoxSelectOptionState createState() => _BoxSelectOptionState();
}

class _BoxSelectOptionState extends State<BoxSelectOption> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: paddingL,
            mainAxisSpacing: paddingM),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: widget.items[index].active
                ? BoxDecoration(
                    color: colorWhite,
                    border: Border.all(color: colorBlue, width: 1))
                : BoxDecoration(color: colorWhite),
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    widget.items[index].active = !widget.items[index].active;
                  });
                  widget.onSelect(widget.items[index]);
                },
                child: Text(
                  widget.items[index].title,
                  style: style15_lightgrey,
                  textAlign: TextAlign.center,
                )),
          );
        });
  }
}

class HeaderInfoCustom extends SliverPersistentHeaderDelegate {
  final SanPhamModel data;
  final double height;
  HeaderInfoCustom({this.data, this.height = 200});
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
          color: colorWhite,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                    color: colorWhite,
                    padding: EdgeInsets.symmetric(
                        horizontal: paddingM, vertical: paddingM),
                    child: HinhAnh(
                      fit: BoxFit.cover,
                      image: (data.image),
                    ),
                  )),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TitleCodeProduct(title: data.maSanPham),
                    TitleProduct(title: data.tenSanPham),
                    SizedBox(height: paddingL),
                    PriceItem(
                      lastPrice: data.donGia,
                      salePrice: data.donGiaSale,
                      percent: data.phanTram,
                      type: data.typeDisplay,
                    ),
                  ],
                ),
              )
            ],
          ));

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
