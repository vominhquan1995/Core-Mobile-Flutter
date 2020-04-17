import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:Midas/utils/index.dart';

class AppSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Chụp ảnh và đọc dữ liệu',
              style: style20,
            ),
            SizedBox(height: paddingM),
            Text(
              'Cho phép ứng đọc dữ liệu hình ảnh trên thiết bị hoặc truy cập camera',
              textAlign: TextAlign.center,
              style: style13.copyWith(color: Colors.grey),
            ),
            SizedBox(height: paddingL),
            Container(
              height: 56.0,
              child: RaisedButton(
                color: Colors.blue,
                elevation: 0.0,
                onPressed: () => AppSettings.openAppSettings(),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                child: Text(
                  'Đi đến cài đặt',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
