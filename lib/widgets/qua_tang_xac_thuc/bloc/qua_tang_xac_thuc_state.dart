import 'package:flutter/material.dart';

@immutable
abstract class QuaTangXacThucState {}

class QuaTangXacThucInitial extends QuaTangXacThucState {}

class InitialQuaTangXacThucState extends QuaTangXacThucState {
  @override
  String toString() => 'InitialQuaTangXacThuc';
  @override
  List<Object> get props => [];
}

/* 
khi muốn disable form
 */
class WaitingForm extends QuaTangXacThucState {
  @override
  String toString() => 'Waiting form';
}

/* 
lưu giữ giá trị
 */
class FormXacThucState extends QuaTangXacThucState {
  final String maPin;
  final String error;

  FormXacThucState({this.maPin, this.error});

  @override
  List<Object> get props => [maPin, error];

  FormXacThucState copyWith({errorMessage, maPinNew}) {
    return FormXacThucState(
        error: errorMessage ?? this.error, maPin: maPinNew ?? this.maPin);
  }

  @override
  String toString() => 'Form xác thực mã pin ${this.maPin}';
}

/* 
khi thành công
 */
class XacThucSuccess extends QuaTangXacThucState {
  @override
  String toString() => 'Xác thực thành công';
}
