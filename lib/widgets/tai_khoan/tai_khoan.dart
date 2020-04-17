import 'package:Core/core/authentication/bloc/bloc.dart';
import 'package:Core/core/authentication/login-mobile/index.dart';
import 'package:Core/core/authentication/models/profile_model.dart';
import 'package:Core/core/cart/cart_badge.dart';
import 'package:Core/core/config_json/bloc/configjson_bloc.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/translate/public.dart';
import 'package:Core/core/page-core/widget_custom.dart';
import 'package:Core/utils/index.dart';
import 'package:Core/widgets/hoa-hong-page/tong_hoa_hong_page.dart';
import 'package:Core/widgets/midas-rewards/midas_rewards_page.dart';
import 'package:Core/widgets/ngon_ngu/ngon_ngu.dart';
import 'package:Core/widgets/qua_tang_xac_thuc/qua_tang_xac_thuc.dart';
import 'package:Core/widgets/quan_ly_don_hang/quan_ly_don_hang_list_page.dart';
import 'package:Core/widgets/tai_khoan/tai_khoan_variable.dart';
import 'package:Core/widgets/tai_khoan/widgets/item.dart';
import 'package:Core/widgets/tai_khoan/widgets/item_quanly.dart';
import 'package:Core/widgets/tai_khoan/widgets/item_user_thuong.dart';
import 'package:Core/widgets/thanh_vien_f2_f3/thanh_vien_page.dart';
import 'package:Core/widgets/thongtin_canhan/index.dart';
import 'package:Core/widgets/tra_cuu/tra_cuu_page.dart';
import 'package:Core/widgets/upgrade_account/info_account_salon.dart';
import 'package:Core/widgets/upgrade_account/upgrade_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class TaiKhoan extends StatefulWidget {
  @override
  _TaiKhoanState createState() => _TaiKhoanState();
}

class _TaiKhoanState extends State<TaiKhoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey_1,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                tr('account_1'),
                style: style15_semibold.copyWith(color: Colors.white),
              ),
            ),
            CartBadge(
              color: colorWhite,
            )
          ],
        ),
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_appbar.jpg'),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.center,
        ),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext _, AuthenticationState state) {
          Widget w = Container(
            key: Key('1'),
            child: CircularProgressIndicator(),
          );

          if (state is AuthenticationAuthenticated) {
            w = SizedBox.expand(
                key: Key('2'), child: templateUserLogin(state.user));
          }

          if (state is AuthenticationUnauthenticated) {
            w = SizedBox.expand(key: Key('3'), child: templateUserNotLogin());
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: w,
          );
        },
      ),
    );
  }

  Widget templateUserNotLogin() {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(child: userNotLogin()),
        SliverToBoxAdapter(child: SizedBox(height: paddingM)),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Column(children: defaultItem()),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(height: paddingL, color: Colors.white))
      ],
    );
  }

  Widget templateUserLogin(Profile profile) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(child: userUpgrage(profile)),
        SliverToBoxAdapter(child: SizedBox(height: paddingM)),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Column(children: itemQuanLy()),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: paddingM)),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Column(children: defaultItem()),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: paddingL,
            color: Colors.white,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
        SliverToBoxAdapter(child: buttonDangXuat()),
        SliverToBoxAdapter(child: SizedBox(height: paddingXXS)),
      ],
    );
  }

  List<Widget> defaultItem() {
    return [
      BlocBuilder<ConfigjsonBloc, ConfigJson>(
        builder: (BuildContext _, state) {
          return ItemTaiKhoan(
            onPressed: () => phoneCall(state?.hotline?.value),
            child: RichText(
              text: new TextSpan(
                style: style15,
                children: [
                  TextSpan(text: tr('account_4')),
                  TextSpan(text: ':'),
                  TextSpan(
                    text: ' ${state?.hotline?.value}',
                    style: style15_semibold.copyWith(color: colorBlue),
                  )
                ],
              ),
            ),
            icon: false,
          );
        },
      ),
      ItemTaiKhoan(
        onPressed: () => goToPage(TraCuuPage()),
        child: Text(
          tr('account_5'),
          style: style15,
        ),
        icon: true,
      ),
      ItemTaiKhoan(
        onPressed: () {
          goToPage(NgonNguPage());
        },
        child: Text(
          tr('account_6'),
          style: style15,
        ),
        icon: true,
      ),
      ItemTaiKhoan(
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            if (!snapshot.hasData) return Container();
            return RichText(
              text: new TextSpan(
                style: style15,
                children: [
                  TextSpan(text: tr('account_7')),
                  TextSpan(text: ':'),
                  TextSpan(
                    text: ' ${snapshot.data.version}',
                    style: style15_semibold,
                  )
                ],
              ),
            );
          },
        ),
        icon: false,
      ),
    ];
  }

  userUpgrage(Profile profile) {
    return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: ListTile.divideTiles(
          context: context,
          color: borderSide.color,
          tiles: [
            userLogin(profile),

            ///Nếu quyền SALON menu này ẩn
            ///Nếu đã xác thực rồi.... có người giới thiêu .... hiển thị nội dung khác như giao diện
            profile.userEnum != LOAI_USER.SALON
                ? Container(
                    color: Colors.white,
                    child: profile.quaTang
                        ? ItemUserNormal(
                            image: 'assets/icon_menu/check.svg',
                            title: tr('account_20'),
                            detail: false,
                          )
                        : BlocBuilder<ConfigjsonBloc, ConfigJson>(
                            builder: (BuildContext context, ConfigJson state) {
                              return ItemUserNormal(
                                onPressed: openDialogQuaTang,
                                image: 'assets/icon_menu/gift.svg',
                                title: tr('account_9',
                                    args: [state?.dataQT?.text]),
                                subtitle: tr('account_10'),
                              );
                            },
                          ),
                  )
                : Container(),

            ///Menu chỗ này nếu quyền SALON hiển thị text thành "Thông tin SALON"
            profile.userEnum == LOAI_USER.SALON
                ? ItemUserNormal(
                    onPressed: () => goToPage(InfoAccountSalon()),
                    image: 'assets/icon_menu/king.svg',
                    title: tr('account_12'),
                  )
                : ItemUserNormal(
                    onPressed: () => goToPage(UpgradeAccount()),
                    image: 'assets/icon_menu/king.svg',
                    title: tr('account_11'),
                    subtitle: tr('account_13'),
                  )
          ],
        ).toList());
  }

  Widget userLogin(Profile profile) {
    return Material(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          goToPage(ThongTinCaNhan());
        },
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingL,
          vertical: paddingL,
        ),
        title: Row(
          children: <Widget>[
            CircleAvatar(
              minRadius: 25,
              backgroundColor: colorGrey_2,
              backgroundImage: AssetImage('assets/no-image.jpg'),
            ),
            SizedBox(width: paddingL),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profile.hoten.isEmpty
                    ? Text(tr('account_8'), style: style15)
                    : Text(
                        '${profile.hoten} ${profile.userEnum == LOAI_USER.SALON ? '(SALON)' : ''}',
                        style: style15),
                SizedBox(height: paddingS),
                Text(
                  profile.sodt,
                  style: style13_lightgrey,
                ),
              ],
            )
          ],
        ),
        trailing: Icon(
          Icons.navigate_next,
          color: colorGrey_2,
          size: 36,
        ),
      ),
    );
  }

  Widget userNotLogin() {
    return Material(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          goToPage(LoginDienThoai());
        },
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingL,
          vertical: paddingL,
        ),
        title: Row(
          children: <Widget>[
            CircleAvatar(
              minRadius: 25,
              backgroundColor: colorGrey_2,
              backgroundImage: AssetImage('assets/no-image.jpg'),
            ),
            SizedBox(width: paddingL),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(tr('account_1'), style: style15),
                SizedBox(height: paddingS),
                Text(
                  tr('account_3'),
                  style: style15_semibold.copyWith(color: colorBlue),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> itemQuanLy() {
    final user = (BlocProvider.of<AuthenticationBloc>(context).state
            as AuthenticationAuthenticated)
        .user;
    final listMenu = user.menuID;

    List<Widget> menu = [
      ItemQuanLy(
        onPressed: () => goToPage(QuanLyDonHangList()),
        image: 'assets/icon_menu/order-history.svg',
        title: tr('account_14'),
        subtitle: tr('account_15'),
      ),
    ];

    if (listMenu.indexOf(MENU_HOAHONG) != -1) {
      menu.add(
        ItemQuanLy(
          onPressed: () => goToPage(HoaHongPage()),
          image: 'assets/icon_menu/commission.svg',
          title: tr('account_16'),
        ),
      );
    }

    if (listMenu.indexOf(MENU_THANHVIEN) != -1) {
      menu.add(
        ItemQuanLy(
          onPressed: () => goToPage(ThanhVienPage()),
          image: 'assets/icon_menu/member-com.svg',
          title: tr('account_17'),
        ),
      );
    }

    menu.add(
      ItemQuanLy(
        onPressed: () => goToPage(MidasRewardsPage()),
        image: 'assets/icon_menu/reward.svg',
        title: tr('account_18'),
        divider: false,
      ),
    );

    return menu;
  }

  goToPage(page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => WidgetsCore(widget: page)));
  }

  buttonDangXuat() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingL,
      ),
      child: RaisedButton(
        elevation: 0.0,
        splashColor: colorGrey_2.withOpacity(0.5),
        padding: EdgeInsets.symmetric(
          vertical: paddingL,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.red, width: 2),
        ),
        color: Colors.white,
        onPressed: () {
          logOut();
        },
        child: Text(
          tr('account_19'),
          style: style15_semibold.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  void logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogLogout();
      },
    );
  }

  openDialogQuaTang() {
    showDialog(
      context: context,
      builder: (BuildContext context) => WidgetsCore(widget: QuaTangXacThuc(
        onSuccess: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            UpdateUser(
              new Profile(quaTang: true),
            ),
          );
        },
      )),
    );
  }

  phoneCall(String number) {
    launch("tel://$number");
  }
}

class AlertDialogLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        tr('account_21'),
        style: style15,
      ),
      content: Text(
        tr('account_22'),
        style: style15,
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text(
            tr('account_23'),
            style: style15,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new FlatButton(
          child: new Text(tr('account_24')),
          onPressed: () {
            _logout(context);
          },
        ),
      ],
    );
  }

  _logout(BuildContext context) async {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }
}
