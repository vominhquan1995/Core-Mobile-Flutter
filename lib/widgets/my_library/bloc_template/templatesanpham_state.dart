part of 'templatesanpham_bloc.dart';

abstract class TemplateSanPhamState extends Equatable {
  const TemplateSanPhamState();
  @override
  List<Object> get props => [];
}

class TemplateSanPhamInitial extends TemplateSanPhamState {}

class TemplateSanPhamLoaded extends TemplateSanPhamState {
  final List<TemplateModel> listTemplate;

  TemplateSanPhamLoaded({@required this.listTemplate});

  @override
  // TODO: implement props
  List<Object> get props => [listTemplate];
}

class TemplateSanPhamEmpty extends TemplateSanPhamState {}

class TemplateSanPhamError extends TemplateSanPhamState {
  final e;

  TemplateSanPhamError({this.e});

  @override
  // TODO: implement props
  List<Object> get props => [e];
}
