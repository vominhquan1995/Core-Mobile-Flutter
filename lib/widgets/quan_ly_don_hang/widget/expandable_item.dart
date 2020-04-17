import 'package:Midas/utils/index.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class ExpandableItem extends StatelessWidget {
  final Function onTap;
  ExpandableItem({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Builder(builder: (_) {
        var controller = ExpandableController.of(_);
        return InkWell(
          onTap: () {
            controller.toggle();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset('assets/images/check_white.svg'),
              SizedBox(width: paddingL),
              Text("Sử dụng MIDAS Rewards", style: style17_semibold),
            ],
          ),
        );
      });
    }

    buildExpanded1() {
      return Builder(
        builder: (BuildContext _) {
          var controller = ExpandableController.of(_);
          return InkWell(
            onTap: () {
              controller.toggle();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset('assets/images/check_blue.svg'),
                SizedBox(width: paddingL),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Sử dụng MIDAS Rewards", style: style17_semibold),
                      SizedBox(height: paddingL),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('MIDAS Rewards', style: style15),
                          Text('0 đ', style: style15_semibold),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Còn thiếu', style: style15),
                          Text('2,400,000đ', style: style15_semibold),
                        ],
                      ),
                      SizedBox(height: paddingL),
                      Text(
                          'Vui lòng chọn hình thức thanh toán bổ sung bên dưới!',
                          style: style15_semibold.copyWith(color: Colors.red)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.all(paddingL),
        child: ScrollOnExpand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
