import 'package:equatable/equatable.dart';

abstract class BaoTriState extends Equatable {
  const BaoTriState();
}

class InitialBaoTriState extends BaoTriState {
  @override
  List<Object> get props => [];
}

/// Bảo trì gồm
/// Bảo trì app
/// Bảo trì page
/// Ưu tiên bảo trì page
class ErrorBaoTriState extends BaoTriState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CoBaoTriApp extends BaoTriState {
  final String message;
  CoBaoTriApp(this.message) : super();

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class KhongCoBaoTriApp extends BaoTriState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
