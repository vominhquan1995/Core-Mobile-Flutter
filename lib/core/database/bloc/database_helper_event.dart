import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DatabaseHelperEvent extends Equatable {
  const DatabaseHelperEvent([List props = const []]);
}

class OpenDatabase extends DatabaseHelperEvent {
  @override
  String toString() => 'OpenDatabase';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnDatabaseCreated extends DatabaseHelperEvent {
  @override
  String toString() => 'OnDatabaseCreated';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ClearDatabase extends DatabaseHelperEvent {
  @override
  String toString() => 'ClearDatabase';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OpenDatabaseError extends DatabaseHelperEvent {
  @override
  String toString() => 'OpenDatabaseError';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
