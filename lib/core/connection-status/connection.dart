import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:Core/core/connection-status/connectionStatusSingleton.dart';
import 'package:Core/core/connection-status/iconwifi.dart';
import 'package:Core/core/data-status/index.dart';

class ConnectionWidget extends StatefulWidget {
  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  bool isOffline = true;
  @override
  void initState() {
    // TODO: implement initState

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    )..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    isOffline = connectionStatus.hasConnection;

    if (!isOffline) {
      animationController?.forward();
    }

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          !connectionStatus.hasConnection) {
        animationController?.repeat(period: Duration(seconds: 3));
      }

      if (status == AnimationStatus.completed && isOffline) {
        Future.delayed(
            Duration(seconds: 2), () => animationController?.reverse());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // animationController?.dispose();
    super.dispose();
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection) {
      /// Có kết nối mạng

    } else {
      /// Mất kết nối mạng
      animation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animationController);
    }
    animationController?.forward();
    isOffline = hasConnection;

    ///tương tác khi chuyển state on off
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NoConnection(connected: isOffline, controller: animationController);
  }
}

class Connection extends StatelessWidget {
  final errorType;
  final VoidCallback onPressed;
  final textButton;
  Connection({this.errorType, this.onPressed, this.textButton});
  @override
  Widget build(BuildContext context) {
    if (errorType is DioError) {
      switch (errorType.type) {
        case DioErrorType.DEFAULT:
          return DataStatusWidget(
            style: DataStatus.disconnect,
            onPress: onPressed,
          );

        case DioErrorType.RESPONSE:
          if (errorType.response.statusCode == 401) {
            return Center(child: CircularProgressIndicator());
          }
          if (errorType.response.statusCode == 403) {
            return Center(child: CircularProgressIndicator());
          }
          if (errorType.response.statusCode == 400) {
            var a;
            try {
              a = errorType.response.data['message'];
            } catch (e) {
              a = '';
            }
            return SingleChildScrollView(
              child: Html(
                defaultTextStyle: TextStyle(
                  fontSize: 18.0,
                ),
                padding: EdgeInsets.all(8.0),
                data: a,
              ),
            );
          }
          return new DataStatusWidget(
            style: DataStatus.server_error,
            onPress: onPressed,
            textButton: textButton,
          );

        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          return new DataStatusWidget(
            style: DataStatus.time_out,
            onPress: onPressed,
          );

        default:
          return Center(
            child: CircularProgressIndicator(),
          );
      }
    } else {
      return Container();
    }
  }
}
