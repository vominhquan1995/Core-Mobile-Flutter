import 'package:Core/core/page-core/service_custom_1.dart';
class TranslateService extends ServiceCustom1 {
  TranslateService() : super(null);
  @override
  Future<Map<String, dynamic>> getLang(String lang) async {
    final response = await dioE
        .get('/cauhinhchung/get-language', queryParameters: {"language": lang});
    return response.data;
  }
}
