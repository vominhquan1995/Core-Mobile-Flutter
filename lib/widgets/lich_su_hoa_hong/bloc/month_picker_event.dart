part of 'month_picker_bloc.dart';

@immutable
abstract class MonthPickerEvent {}

class ChangePickerEvent extends MonthPickerEvent {
  final String loai;
  final int curentMonth;

  ChangePickerEvent({this.loai, this.curentMonth});

  @override
  String toString() {
    return 'ChangePickerEvent ';
  }
}
