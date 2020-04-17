part of 'configjson_bloc.dart';

abstract class ConfigjsonEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetConfigJson extends ConfigjsonEvent {
  final ConfigJson jsonConfig;

  GetConfigJson({this.jsonConfig});
}

class InitJsonConfig extends ConfigjsonEvent {
  final String codeC, codeL;
  InitJsonConfig({this.codeC, this.codeL});

  @override
  // TODO: implement props
  List<Object> get props => [codeC, codeL];
}
