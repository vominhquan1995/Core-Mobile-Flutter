import 'dart:collection';

class SettingNotificationModel {
  bool state = true;
  // bool is_new  = false;
  List<ItemPageConfig> list_config_page =[];
  SettingNotificationModel() {
  }
  List<ItemPageConfig> mapDataListConfigPage(LinkedHashMap<String, dynamic>json) {
    List<ItemPageConfig> result = [];
    if(json != null){
      List<dynamic> listValue = json.values.toList();
      List<dynamic> listKey=json.keys.toList();
      for (int i = 0; i < listValue.length; i++) {
        ItemPageConfig item = ItemPageConfig(int.parse(listKey[i].toString()),listValue[i].toString()== "true" ? true : false);
        result.add(item);
      }
    }
    return result;
  }
}
class ItemPageConfig {
  int key ;
  bool value  ;
  ItemPageConfig(key1,value1) {
    this.key=key1;
    this.value=value1;
  }
}

