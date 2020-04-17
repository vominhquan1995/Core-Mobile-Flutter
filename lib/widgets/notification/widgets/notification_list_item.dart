import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/shared/border-dash/index.dart';
import 'package:flutter/material.dart';
import 'package:Midas/widgets/notification/model/notification_model.dart';
import 'package:shimmer/shimmer.dart';

class NotificationItem extends StatelessWidget {
  final VoidCallback onPressed;
  final NotificationModel notification;

  NotificationItem({
    this.onPressed,
    this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                notification.timecreate ?? '',
                style: style13_lightgrey,
              ),
              SizedBox(height: paddingM),
              Text(notification.tieude ?? '', style: style15_semibold),
              SizedBox(height: paddingS),
              MySeparator(color: colorGrey_2)
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          SizedBox(height: paddingM),
          subtitle,
          SizedBox(height: paddingS),
          MySeparator(color: colorGrey_2)
        ],
      ),
    );
  }

  final title = Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    child: Container(
      width: double.infinity,
      height: 10.0,
      color: Colors.white,
    ),
  );

  final subtitle = Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    child: Container(
      width: 150,
      height: 10.0,
      color: Colors.white,
    ),
  );
}
