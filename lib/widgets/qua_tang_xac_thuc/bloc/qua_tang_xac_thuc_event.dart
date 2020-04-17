import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class QuaTangXacThucEvent extends Equatable {
  const QuaTangXacThucEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

/* 
khi mà nhập mã pin
 */
class InputMaPin extends QuaTangXacThucEvent {
  final String maPin;

  InputMaPin({this.maPin});

  @override
  String toString() {
    // TODO: implement toString
    return 'Nhập mã pin: ${maPin}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [maPin];
}

/* 
khi gửi api
 */
class SubmitXacThuc extends QuaTangXacThucEvent {
  @override
  String toString() {
    // TODO: implement toString
    return 'Bắt đầu xác thực thành viên';
  }
}
