import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DatabaseHelperState extends Equatable {
  const DatabaseHelperState();
}

class InitialDatabaseHelperState extends DatabaseHelperState {
  @override
  String toString() => 'InitialDatabaseHelperState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnDBCreatedDatabaseHelperState extends DatabaseHelperState {
  @override
  String toString() => 'OnDBCreatedDatabaseHelperState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnDBCompletedDatabaseHelperState extends DatabaseHelperState {
  @override
  String toString() => 'OnDBCompletedDatabaseHelperState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnDBErrorDatabaseHelperState extends DatabaseHelperState {
  @override
  String toString() => 'OnDBErrorDatabaseHelperState';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
