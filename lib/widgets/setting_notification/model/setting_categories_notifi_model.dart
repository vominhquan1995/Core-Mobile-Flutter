class SettingCategoryNotifiModel {
  int id;
  String key;
  String title;
  bool state = false;
  bool isLast = false;
  bool isDisabled =false;
  SettingCategoryNotifiModel(int id,String key,String title,bool state, bool isLast,bool isDisabled){
   this.id=id;
   this.key = key;
   this.title=title;
   this.state=state;
   this.isLast = isLast;
   this.isDisabled=isDisabled;
  }
}