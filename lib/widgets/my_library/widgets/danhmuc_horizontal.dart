import 'package:Midas/core/page-core/widget_custom.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/my_library/models/danhmuc_model.dart';
import 'package:Midas/widgets/search_results/search_results.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DanhMucHorizontal extends StatelessWidget {
  final List<DanhMucModel> listDM;
  DanhMucHorizontal({
    @required this.listDM,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listDM.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WidgetsCore(
                  widget: SearchResults(
                    keySearch: listDM[index].key,
                    value: listDM[index].value,
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    backgroundColor: colorGrey_2,
                    backgroundImage: NetworkImage(listDM[index].image),
                  ),
                ),
                SizedBox(height: paddingM),
                Expanded(
                  child: Text(
                    listDM[index].name,
                    textAlign: TextAlign.center,
                    style: style13,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DanhMucHorizontalShimmer extends StatelessWidget {
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
