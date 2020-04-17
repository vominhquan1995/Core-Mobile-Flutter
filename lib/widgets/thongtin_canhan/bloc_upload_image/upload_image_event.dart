import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlocUploadImageEvent extends Equatable {
  const BlocUploadImageEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UploadImage extends BlocUploadImageEvent {
  final File file;
  UploadImage({this.file});
  @override
  String toString() => 'UploadImage $file';

  @override
  // TODO: implement props
  List<Object> get props => [file];
}
