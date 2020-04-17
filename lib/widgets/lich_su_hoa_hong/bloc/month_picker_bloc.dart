import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'month_picker_event.dart';
part 'month_picker_state.dart';

class MonthPickerBloc extends Bloc<MonthPickerEvent, MonthPickerState> {
  @override
  MonthPickerState get initialState => MonthPickerInitial();

  @override
  Stream<MonthPickerState> mapEventToState(
    MonthPickerEvent event,
  ) async* {
    if (event is ChangePickerEvent) {
      try {
        var date = new DateTime.now();
        var curentMonth = event.curentMonth;
        if (event.loai != '' && event.loai != '') {
          if (event.loai == '-1') {
            curentMonth++;
          } else {
            curentMonth--;
          }
        }
        var start = new DateTime(date.year, date.month - curentMonth);//Lấy ngày bắt đầu của tháng
        var end = new DateTime(date.year, date.month - curentMonth + 1, 0);//Lấy ngày kết thúc của tháng
        var formatter = new DateFormat('yyyy/MM/dd');
        String tu_ngay = formatter.format(start);
        String toi_ngay = formatter.format(end);



        yield GetedMonthPickerState(
            nam: start.year.toString(),
            thang: start.month.toString(),
            curentMonth: curentMonth,
            dateTime: {'tu_ngay': tu_ngay, 'toi_ngay': toi_ngay});
      } catch (e) {

        var date = new DateTime.now();
        var start = new DateTime(date.year, date.month - 1);
        var end = new DateTime(date.year, date.month, 0);
        var formatter = new DateFormat('yyyy/MM/dd');
        String tu_ngay = formatter.format(start);
        String toi_ngay = formatter.format(end);

        yield ErrorMonthPickerState(
            nam: start.year.toString(),
            thang: start.month.toString(),
            curentMonth: 1,
            dateTime: {'tu_ngay': tu_ngay, 'toi_ngay': toi_ngay});
      }
    }
  }
}
