import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class VersionState extends Equatable {
  const VersionState([List props = const []]);
}

class VersionUninitialized extends VersionState {
  @override
  String toString() => 'VersionUninitialized';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CheckingVersion extends VersionState {
  @override
  String toString() {
    return 'CheckingVersion{}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HardUpdate extends VersionState {
  @override
  String toString() => 'HardUpgrade';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SoftUpdate extends VersionState {
  final String message;
  SoftUpdate({this.message});
  @override
  String toString() => 'SoftUpgrade $message';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class NoUpdate extends VersionState {
  @override
  String toString() {
    return 'NoUpdate{}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CheckVersionError extends VersionState {
  final error;

  CheckVersionError({@required this.error});

  @override
  String toString() {
    return 'CheckVersionError{error: $error}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
