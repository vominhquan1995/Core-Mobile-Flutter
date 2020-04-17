import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Midas/core/bao-tri/db/baotri_provider.dart';
import 'package:Midas/core/bao-tri/models/baotri.dart';
import 'package:Midas/core/maintenance-page/db/maintenance_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import '../baotri_service.dart';
import './bloc.dart';

class BaoTriBloc extends Bloc<BaoTriEvent, BaoTriState> {
  BaoTriProvider provider = BaoTriProvider();
  BaoTriService service = BaoTriService();
  @override
  BaoTriState get initialState => InitialBaoTriState();

  @override
  Stream<BaoTriState> mapEventToState(
    BaoTriEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is BaoTriStart) {
      /// Stream get local

      /// Stream Lấy api Firebase
      DatabaseReference _ref =
          FirebaseDatabase.instance.reference().child('BaoTri');
      var streamB = _ref.onValue;

      var streamA = provider.select();

      Observable<dynamic>.merge([streamA.asStream(), streamB])
          .listen((onData) async {
        if (onData is Event) {
          var data = onData?.snapshot?.value;
          final firebase = BaoTriLocal(
              key: BaoTriProvider.KEY,
              html: data["BaoTriApp"]["message"],
              tinhTrang: data["BaoTriApp"]["bao_tri"]);

          await provider.delete();
          await provider.insert(firebase);

          if (firebase.tinhTrang) {
            /// Có bảo trì
            /// Save local

            ///dispatch event Bảo trì app
            add(CoBaoTri(firebase.html));
          } else {
            BaoTriLocal bt = BaoTriLocal(
                key: MaintenanceProvider.KEY,
                html: data["BaoTriPage"]["data_change"].toString(),
                tinhTrang: data["BaoTriPage"]["bao_tri"]);
            bool a = await provider.insert(bt);
            print('Đã insert bảo trì page : $a');
            add(KhongBaoTri());
          }
        }

        if (onData is BaoTriLocal) {
          if (onData.tinhTrang) {
            add(CoBaoTri(onData.html));
          } else {
            add(KhongBaoTri());
          }
        }
      }).onError(_handleError);
    }

    if (event is CoBaoTri) {
      yield CoBaoTriApp(event.message);
    }

    if (event is KhongBaoTri) {
      yield KhongCoBaoTriApp();
    }

    if (event is RestartBaoTri) {
      yield InitialBaoTriState();
    }
  }

  _handleError(e) async {
    print('error $e');
    final result = await service.getBaoTri();

    final firebase = BaoTriLocal(
        key: BaoTriProvider.KEY,
        html: result["BaoTriApp"]["message"],
        tinhTrang: result["BaoTriApp"]["bao_tri"]);

    if (firebase.tinhTrang) {
      /// Có bảo trì
      /// Save local
      await provider.delete();
      await provider.insert(firebase);

      ///dispatch event Bảo trì app
      add(CoBaoTri(firebase.html));
    } else {
      BaoTriLocal bt = BaoTriLocal(
          key: MaintenanceProvider.KEY,
          html: result["BaoTriPage"]["data_change"].toString(),
          tinhTrang: result["BaoTriPage"]["bao_tri"]);

      bool a = await provider.insert(bt);
      print('Đã insert bảo trì page : $a');
      add(KhongBaoTri());
    }
  }
}
