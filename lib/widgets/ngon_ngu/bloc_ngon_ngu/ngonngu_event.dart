part of 'ngonngu_bloc.dart';

abstract class NgonnguEvent extends Equatable {
  const NgonnguEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDSNgonNgu extends NgonnguEvent {
  final String language;
  GetDSNgonNgu({this.language});
  @override
  // TODO: implement props
  List<Object> get props => [language];
}

class SelectNgonNgu extends NgonnguEvent {
  final QuocGiaModel selected;

  SelectNgonNgu({this.selected});

  @override
  // TODO: implement props
  List<Object> get props => [selected];
}
