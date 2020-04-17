import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlocUploadImageEvent extends Equatable {
  BlocUploadImageEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitUpdate extends BlocUploadImageEvent {
  String path;
  InitUpdate({this.path});
  @override
  String toString() => 'InitUpdate';
  @override
  List<Object> get props => [path];
}

class InitUpload extends BlocUploadImageEvent {
  InitUpload();
  @override
  String toString() => 'InitUpload';
  @override
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
