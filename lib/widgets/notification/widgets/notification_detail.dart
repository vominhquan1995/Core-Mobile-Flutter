import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:Midas/core/authentication/bloc/bloc.dart';
import 'package:Midas/utils/index.dart';

class NotificationHtml extends StatelessWidget {
  final Widget appBar;
  final String notifiid;
  NotificationHtml({this.appBar, this.notifiid});

  @override
  Widget build(BuildContext context) {
    final headers = DioUtil.headers;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext _, state) {
        if (state is AuthenticationAuthenticated) {
          headers.addAll({"Authorization": 'JWT ${state.user.token}'});

          return FutureBuilder(
            future: Future.delayed(
                Duration(milliseconds: 500), () => DeviceId.getID),
            builder: (BuildContext context, deviceid) {
              if (!deviceid.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              print(
                  '${DioUtil.getApiMidas()}/notifications/show-detail?app_id=${Variables.appId}&diuu=${deviceid.data}&notifi_id=${notifiid.toString()}');

              return WebviewScaffold(
                appBar: appBar,
                withJavascript: true,
                clearCookies: true,
                scrollBar: false,
                clearCache: true,
                hidden: true,
                headers: headers,
                url:
                    '${DioUtil.getApiMidas()}/notifications/show-detail?app_id=${Variables.appId}&diuu=${deviceid.data}&notifi_id=${notifiid.toString()}',
                initialChild: Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
