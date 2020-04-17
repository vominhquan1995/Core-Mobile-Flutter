import 'package:Midas/core/page-core/bloc/bloc.dart';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/my_library/bloc_sanpham/sanpham_bloc.dart';
import 'package:Midas/widgets/my_library/service/library_service.dart';
import 'package:Midas/widgets/my_library/widgets/sanpham_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class XemThemPage extends StatefulWidget {
  final String keyword;

  const XemThemPage({Key key, @required this.keyword}) : super(key: key);

  @override
  _XemThemPageState createState() => _XemThemPageState();
}

class _XemThemPageState extends State<XemThemPage> {
  SanPhamBloc sanPhamBloc;

  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sanPhamBloc = SanPhamBloc(
        service: LibraryService(BlocProvider.of<ErrorhandleBloc>(context)));
    sanPhamBloc.add(GetDanhSachPham(key: widget.keyword));

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent * 2 / 3)) {
        sanPhamBloc.add(GetMoreDanhSachPham(key: widget.keyword));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sanPhamBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_appbar.jpg'),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.center,
        ),
      ),
      backgroundColor: colorGrey_2,
      body: BlocBuilder(
        bloc: sanPhamBloc,
        builder: (BuildContext context, state) {
          if (state is SanPhamLoaded) {
            return SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: paddingXXS),
              child: Container(
                color: Colors.white,
                child: GridView.builder(
                  padding: EdgeInsets.all(paddingL),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: paddingL,
                    crossAxisSpacing: paddingL,
                    childAspectRatio: 0.64,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return SanPhamWidget(sanPhamModel: state.list[index]);
                  },
                ),
              ),
            );
          }

          if (state is SanPhamEmpty) {
            return Center(
              child: Text('Empty', style: style15_semibold),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
