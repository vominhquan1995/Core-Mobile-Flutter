import 'package:Midas/core/connection-status/index.dart';
import 'package:Midas/core/custom_translate/easy_localization.dart';
import 'package:Midas/core/translate/public.dart';
import 'package:Midas/core/function/snackbar.dart';
import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/shared/sizedbox_bottom/sizedbox_bottom.dart';
import 'package:Midas/widgets/tra_cuu/models/news_model.dart';
import 'package:Midas/widgets/tra_cuu/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'models/tracuu_model.dart';
import 'service/tracuu_service.dart';
import 'widgets/list_item.dart';

class TraCuuPage extends StatefulWidget {
  @override
  _TraCuuPageState createState() => _TraCuuPageState();
}

class _TraCuuPageState extends State<TraCuuPage> {
  TracuuBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String language = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = TracuuBloc(
      service: TraCuuService(
        BlocProvider.of<ErrorhandleBloc>(context),
      ),
    );
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // language = EasyLocalizationProvider.of(context).data.locale.languageCode;
    language = Localization.locate.languageCode;
    bloc.add(GetDanhSachTraCuu(language: language));
  }

  void connectionChanged(dynamic hasConnection) async {
    if (hasConnection && mounted) {
      //call event from main
      // bloc.add(GetData());
      bloc.add(GetDanhSachTraCuu(language: language));
      showSnackBarUpdateDataKey(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('tracuu_1')),
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_appbar.jpg'),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.center,
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: colorGrey_2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: paddingL),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocBuilder(
                    bloc: bloc,
                    builder: (BuildContext _, TracuuState state) {
                      if (state is LoadedTracuuState) {
                        return Flexible(
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext _, int index) {
                              return ListItemTraCuu(
                                titleHeader: state.list[index].titleHeader,
                                list: state.list[index].list,
                                onPress: onPressItem,
                              );
                            },
                            itemCount: state.list.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: paddingL);
                            },
                          ),
                        );
                      }

                      if (state is ErrorTracuuState) {
                        return Connection(
                          errorType: state.e,
                          onPressed: () {
                            bloc.add(GetDanhSachTraCuu(language: language));
                          },
                        );
                      }
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 3,
                          child: Center(child: CircularProgressIndicator()));
                    },
                  ),
                ],
              ),
            ),
            SizedBoxBottom()
          ],
        ),
      ),
    );
  }

  onPressItem(TraCuu traCuu) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsDetail(
          id: traCuu.id,
          data: News(linkseo: traCuu.linkSeo),
        ),
      ),
    );
  }
}
