import 'package:Midas/core/page-core/service_custom.dart';
class TranslateService extends ServiceCustom {
  TranslateService() : super(null);
  @override
  Future<Map<String, dynamic>> getLang(String lang) async {
    final response = await dioPub
        .get('/cauhinhchung/get-language', queryParameters: {"language": lang});
    return response.data;
  }
}
