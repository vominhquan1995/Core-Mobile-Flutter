class TimeUtil {
/*
    * @author Bình
    * lấy id năm theo năm học: getMonths(0-11)
    * tháng 9 -> 12
    *          ID_Nam= năm hiện tại
    * tháng 1 -> 8
    *          ID_Nam= năm hiện tại - 1
    */
  static int getNamHoc() {
    DateTime date = new DateTime.now();
    // trong khoảng hoặc bằng tháng 9 và 12
    if (date.month <= 12 && date.month >= 9) {
      return date.year;
    }
    return date.year - 1;
  }

/**
   * Tăng giảm học kỳ
   */
  static int tangGiamHocKy(bool tang, {int hoc_ky: 1}) {
    int result = 1;
    if (tang == true) {
      result = hoc_ky + 1;
    }
    if (tang == false) {
      result = hoc_ky - 1;
    }
    if (result > 3) {
      return 1;
    }
    if (result <= 0) {
      return 3;
    }
    return result;
  }

  static dynamic HOC_KY = {
    'I': 1,
    'II': 2,
    'III': 3,
  };
}
