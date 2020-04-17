import 'package:equatable/equatable.dart';

abstract class VersionEvent extends Equatable {
  const VersionEvent([List props = const []]);
}

class VersionAppStarted extends VersionEvent {
  @override
  String toString() {
    return 'VersionAppStarted{}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TellMeLater extends VersionEvent {
  @override
  String toString() {
    return 'TellMeLater{}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
