import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TracuuEvent extends Equatable {
  const TracuuEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDanhSachTraCuu extends TracuuEvent {
  final String language;

  GetDanhSachTraCuu({@required this.language});

  @override
  String toString() => '$runtimeType $language';
}
