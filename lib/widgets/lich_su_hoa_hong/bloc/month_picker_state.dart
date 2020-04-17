part of 'month_picker_bloc.dart';

@immutable
abstract class MonthPickerState {}

class MonthPickerInitial extends MonthPickerState {}

class InitialMonthPickerState extends MonthPickerState {
  @override
  String toString() => 'InitialMonthPicker';
}

class GetedMonthPickerState extends MonthPickerState {
  final String thang;
  final String nam;
  final int curentMonth;
  final dynamic dateTime;

  GetedMonthPickerState({this.thang, this.nam, this.curentMonth, this.dateTime});
  @override
  String toString() => 'GetedMonthPickerState';

  @override
  // TODO: implement props
  List<Object> get props => [thang, nam, curentMonth, dateTime];
}

class ErrorMonthPickerState extends MonthPickerState {
  final String thang;
  final String nam;
  final int curentMonth;
  final dynamic dateTime;

  ErrorMonthPickerState({this.thang, this.nam, this.curentMonth, this.dateTime});
  @override
  String toString() => 'ErrorMonthPickerState';

  @override
  // TODO: implement props
  List<Object> get props => [thang, nam, curentMonth, dateTime];
}
