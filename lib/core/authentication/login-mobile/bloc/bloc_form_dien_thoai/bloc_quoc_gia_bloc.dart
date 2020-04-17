import 'package:Midas/core/authentication/login-mobile/db/quoc_gia_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../index.dart';

class QuocGiaBloc {
  QuocGiaLoginService _service;
  BehaviorSubject<List<QuocGia>> _quocGiaStream =
      BehaviorSubject<List<QuocGia>>();
  Observable<List<QuocGia>> get quocGiaAll => _quocGiaStream.stream;
  QuocGiaDB _db;
  QuocGiaBloc() {
    this._service = new QuocGiaLoginService();
    _db = QuocGiaDB();
  }

  /* 
  lấy tất cả quốc gia
   */
  getQuocGias() async {
    try {
      this._quocGiaStream.sink.add(null);
      List<QuocGia> data = await _service.getQuocGia();
      this._quocGiaStream.sink.add(data);
      // this._db.insertAlls(data);
      if (data.length > 0) {
        return data[0];
      }
      return null;
    } catch (ex) {
      print(ex);
      // var model = await _db.getQuocGias();
      // if (model != null) {
      //   this._quocGiaStream.sink.add(model);
      // } else {
      this._quocGiaStream.sink.addError(ex);
      // }
      // if (model.length > 0) {
      //   return model[0];
      // }
      return null;
    }
  }

  dispose() {
    _quocGiaStream.close();
  }
}
