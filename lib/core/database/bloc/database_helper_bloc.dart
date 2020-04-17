import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Core/core/database/appdatabaseinfo.dart';
import 'package:Core/core/database/dbhelper.dart';
import './bloc.dart';

class DatabaseHelperBloc
    extends Bloc<DatabaseHelperEvent, DatabaseHelperState> {
  @override
  DatabaseHelperState get initialState => InitialDatabaseHelperState();

  @override
  Stream<DatabaseHelperState> mapEventToState(
    DatabaseHelperEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is OpenDatabase) {
      try {
        await DBHelper.dbHelper.openDB();

        yield OnDBCreatedDatabaseHelperState();

        add(OnDatabaseCreated());
      } catch (e) {
        print('Error while tring to open db: ' + e.toString());
        yield OnDBErrorDatabaseHelperState();
      }
    }

    if (event is OnDatabaseCreated) {
      try {
        await DBHelper.dbHelper.init(AppDatabaseInfo());
        yield OnDBCompletedDatabaseHelperState();
      } catch (e) {
        yield OnDBErrorDatabaseHelperState();
      }
    }

    if (event is ClearDatabase) {
      // await DBHelper.dbHelper.init(AppDatabaseInfo());
    }
  }
}
