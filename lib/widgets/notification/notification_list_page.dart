import 'dart:async';
import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/data-status/index.dart';
import 'package:Core/core/page-core/bloc/bloc.dart';
import 'package:Core/widgets/notification/service/index.dart';
import 'package:Core/widgets/shared/fix_refresh/refreshIndicator_fix.dart';
import 'package:Core/widgets/shared/user_need_login/user_need_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/google_analytics/index.dart';
import 'package:Core/utils/theme.dart';
import 'bloc/bloc.dart';
import 'model/notification_model.dart';
import 'widgets/notification_list_item.dart';
import 'widgets/view_detail_html.dart';

class NotificationListPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationListPage> {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  NotificationBloc notificationBloc;

  ///init bloc page thông báo

  @override
  void initState() {
    // TODO: implement initState

    notificationBloc = NotificationBloc(
        service:
            NotificationService(BlocProvider.of<ErrorhandleBloc>(context)));

    if (BlocProvider.of<AuthenticationBloc>(context).state
        is AuthenticationAuthenticated) {
      notificationBloc.add(GetDataNotification());
    }

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        notificationBloc.add(GetMoreNotification());
      }
    });

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);

    super.initState();
    GoogleAnalytics.trackScreen(notification_list_page);
  }

  /// Thay đổi trạng thái mạng
  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      notificationBloc.add(GetDataNotification());
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    _scrollController?.dispose();
    super.dispose();
  }

  Future<Null> _handleRefresh() async {
    notificationBloc.add(RefreshNotification());
    showSnackBarUpdatedDataKey(_scaffoldKey);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext _, state) {
            if (state is AuthenticationAuthenticated) {
              notificationBloc.add(GetDataNotification());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  tr('notification_1'),
                  style: style15_semibold.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          flexibleSpace: Image(
            image: AssetImage('assets/images/background_appbar.jpg'),
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
          // actions: <Widget>[
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: paddingL),
          //     child: CartBadge(
          //       color: colorWhite,
          //     ),
          //   )
          // ],
        ),
        key: _scaffoldKey,
        backgroundColor: colorGrey_2,
        body: checkLoginUser(),
      ),
    );
  }

  checkLoginUser() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated) {
          notificationBloc.add(GetDataNotification());
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationAuthenticated) {
            return viewThongBao();
          }
          if (state is AuthenticationUnauthenticated) {
            return UserNeedLogin();
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  viewThongBao() {
    return Container(
      color: Colors.white,
      child: BlocBuilder(
        bloc: notificationBloc,
        builder: (BuildContext _, NotificationState state) {
          if (state is LoadedNotificationState) {
            return RefreshIndicatorFix(
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: buildList(state),
              ),
            );
          }

          if (state is EmptyNotificationState) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicatorFix(
                  child: Center(
                    child: DataStatusWidget(
                      style: DataStatus.not_data('notification_3'),
                      onPress: () =>
                          notificationBloc.add(GetDataNotification()),
                      textButton: tr('notification_2'),
                    ),
                  ),
                  onRefresh: _handleRefresh),
            );
          }

          if (state is ErrorNotificationState) {
            return Connection(
              errorType: state.e,
              onPressed: () => notificationBloc.add(GetDataNotification()),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

    // return RefreshIndicatorFix(
    //   onRefresh: _handleRefresh,
    //   child: SingleChildScrollView(
    //     controller: _scrollController,
    //     physics: AlwaysScrollableScrollPhysics(),
    //     child: Container(
    //       color: Colors.white,
    //       child: BlocBuilder(
    //         bloc: notificationBloc,
    //         builder: (BuildContext _, NotificationState state) {
    //           Widget w = Center(child: CircularProgressIndicator());

    //           if (state is LoadedNotificationState) {
    //             return buildList(state);
    //           }

    //           if (state is EmptyNotificationState) {
    //             w = DataStatusWidget(
    //               style:
    //                   DataStatus.not_data(DataStatusMessage.not_data_thong_bao),
    //             );
    //           }

    //           if (state is ErrorNotificationState) {
    //             w = Connection(
    //               errorType: state.e,
    //               onPressed: () => notificationBloc.add(GetDataNotification()),
    //             );
    //           }

    //           return w;
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget buildList(LoadedNotificationState state) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: paddingL),
      physics: NeverScrollableScrollPhysics(),
      itemCount:
          (state.hasReachedMax) ? state.list.length : state.list.length + 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext ctxt, int index) {
        return index >= state.list.length
            ? NotificationItemShimmer()
            : NotificationItem(
                onPressed: () => openDetailPage(state.list[index]),
                notification: state.list[index],
              );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: paddingL);
      },
    );
  }

  openDetailPage(NotificationModel data) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ViewDetailNotifiHtml(
                html: data.noidunghtml,
              );
            },
          ),
        );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => NotificationDetail(data: data)),
    // );
  }
}
