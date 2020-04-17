bool checkpermission({String menuID, List<String> menu}) {
  ///Menu publish
  if (menuID == '-1') {
    return true;
  }

  ///Danh sách rỗng -> menu không phân quyền
  if (menu.isEmpty) {
    return false;
  }

  ///Tìm kiếm id trong danh sách
  final m = menu.firstWhere((x) => x == menuID, orElse: () => null);

  /// Nếu có menu true : còn lại false
  return m != null ? true : false;
}
