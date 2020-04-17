import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/widgets/cart/cart_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Core/core/connection-status/index.dart';
import 'package:Core/core/function/snackbar.dart';
import 'package:Core/core/google_analytics/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/core_cart_bloc.dart';
import 'bloc/core_cart_event.dart';
import 'bloc/core_cart_state.dart';

class CartBadge extends StatefulWidget {
  final Color color;
  CartBadge({Key key, @required this.color}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartBadge> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
    GoogleAnalytics.trackScreen(notification_list_page);
  }

  /// Thay đổi trạng thái mạng
  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      BlocProvider.of<CoreCartBloc>(context).add(InitCartBadge());
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
  }

  @override
  void dispose() async {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreCartBloc, CoreCartState>(
      builder: (BuildContext _, CoreCartState state) {
        if (state is InitCartBadgeSuccessState) {
          return Stack(children: <Widget>[
            IconButton(
                icon: SvgPicture.asset(
                  'assets/images/cart.svg',
                  width: 30,
                  height: 30,
                  color: widget.color,
                ),
                onPressed: () => openListPage()),
            state.count != 0
                ? Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '${state.count}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Container()
          ]);
        }
        return IconButton(
            icon: Icon(Icons.notifications), onPressed: () => openListPage());
      },
    );
  }

  openListPage() {
    Navigator.push(
      context,
      // PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) =>
      //       CartListPage(),
      //   transitionsBuilder: (BuildContext context,
      //       Animation<double> animation,
      //       Animation<double> secondaryAnimation,
      //       Widget child) {
      //     return new SlideTransition(
      //       position: new Tween<Offset>(
      //         begin: const Offset(1.0, 0.0),
      //         end: Offset.zero,
      //       ).animate(animation),
      //       child: child,
      //     );
      //   },
      // )
      MaterialPageRoute(builder: (context) => WidgetsCore(widget: CartListPage())),
    );
  }
}
