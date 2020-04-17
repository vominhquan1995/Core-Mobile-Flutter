import 'dart:async';
import 'dart:io';
import 'package:Core/core/config_json/db/config_json_provider.dart';
import 'package:Core/core/config_json/models/config_json.dart';
import 'package:Core/core/config_json/service/configjson_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
part 'configjson_event.dart';

class ConfigjsonBloc extends Bloc<ConfigjsonEvent, ConfigJson> {
  IBaseConfigJsonService service;

  /// CounterStorage counterStorage;
  final ConfigJsonProvider configProvider = ConfigJsonProvider();

  ConfigjsonBloc({@required this.service});

  @override
  ConfigJson get initialState => ConfigJson();

  @override
  Stream<ConfigJson> mapEventToState(
    ConfigjsonEvent event,
  ) async* {
    ///
    if (event is GetConfigJson) {
      yield event.jsonConfig;
    }

    ///
    if (event is InitJsonConfig) {
      try {
        Observable<dynamic>.merge([
          service.getConfigJsonFull().asStream(),
          configProvider
              .getDataJsonLocal(
                event.codeC,
                event.codeL,
              )
              .asStream()
        ]).listen((onData) async {
          if (onData is String) {
            await configProvider.insert(onData);
            ConfigJson jsonLocal = await configProvider.getDataJsonLocal(
              event.codeC,
              event.codeL,
            );

            add(GetConfigJson(jsonConfig: jsonLocal));
          }

          if (onData is ConfigJson) {
            add(GetConfigJson(jsonConfig: onData));
          }
        }).onError((handleError) {
          add(GetConfigJson(jsonConfig: null));
        });

        ///
        // service.getConfigJsonFull().then((dataJsonString) async {
        // await configProvider.insert(dataJsonString);
        //   ConfigJson jsonLocal = await configProvider.getDataJsonLocal(
        //     event.codeC,
        //     event.codeL,
        //   );

        //   print(jsonLocal);
        //   // yield jsonLocal != null ? jsonLocal : ConfigJson();
        // });

        // ConfigJson jsonLocal = await configProvider.getDataJsonLocal(
        //   event.codeC,
        //   event.codeL,
        // );

        // ///check exist on data on db
        // if (jsonLocal != null) {
        //   yield jsonLocal;
        // } else {
        //   /// yield await FileUtil().loadFileLocal();
        // }

        ///not exist data json local
      } catch (e) {
        ConfigJson jsonLocal =
            await configProvider.getDataJsonLocal(event.codeC, event.codeL);
        if (jsonLocal != null) {
          //skip and update not required await
          yield jsonLocal;
        } else {
          yield ConfigJson();
        }
      }
    }
  }

  Future<bool> insertDataJson() async {
    try {
      final dataJsonString = await service.getConfigJsonFull();
      configProvider.insert(dataJsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}

// class FileUtil {
//   Future loadFileLocal() async {
//     final ByteData s = await rootBundle.load('assets/json/dataJson.json');
//     return utf8.decode(s.buffer.asUint8List());
//   }
// }

class CounterStorage<T> {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<String> readCounter({String fileName}) async {
    try {
      final file = await _localFile(fileName);

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeCounter({String fileName, String s}) async {
    final file = await _localFile(fileName);

    // Write the file
    return file.writeAsString('$s');
  }

  Future<File> saveFile(File file) async {
    try {
      bool fileExist = await file.exists();
      if (!fileExist) {
        file.createSync();
      }

      return file;
    } catch (e) {
      print(e);
    }
  }
}
