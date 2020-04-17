import 'package:Midas/core/page-core/service_custom.dart';
import 'package:Midas/widgets/quoc_gia/models/quocgia_model.dart';

abstract class IBaseNgonNguService extends ServiceCustom {
  IBaseNgonNguService() : super(null);

  Future<List<QuocGiaModel>> getDanhSachNgonNgu({String language}) async =>
      <QuocGiaModel>[];
}

class NgonNguService extends IBaseNgonNguService {
  @override
  Future<List<QuocGiaModel>> getDanhSachNgonNgu({String language}) async {
    // TODO: implement getDanhSachNgonNgu
    // return super.getDanhSachNgonNgu();
    final response = await dioE
        .get('/profile/get-quoc-gia', queryParameters: {"language": language});

    final list = response.data["result"] as List;

    return list.map((f) => QuocGiaModel.fromJson(f)).toList();
  }
}
