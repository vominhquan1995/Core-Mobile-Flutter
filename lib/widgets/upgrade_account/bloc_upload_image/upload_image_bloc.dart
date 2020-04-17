import 'dart:async';
import 'package:Midas/utils/index.dart';
import 'package:Midas/widgets/upgrade_account/service/image_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class UploadImageBloc extends Bloc<BlocUploadImageEvent, BlocUploadImageState> {
  final ImageService service;
  UploadImageBloc({@required this.service});
  @override
  BlocUploadImageState get initialState => InitialBlocUploadImageState();

  @override
  Stream<BlocUploadImageState> mapEventToState(
    BlocUploadImageEvent event,
  ) async* {
    if (event is InitUpload) {
      yield InitialBlocUploadImageState();
    }
    if (event is UploadImage) {
      yield WaittingBlocUploadImageState();
      try {
        var res = await this.service.uploadImage(event.file);
        yield SuccessUploadImageState(
            '${DioUtil.getApiUploadFile()}/${res['path']}');
      } catch (e) {
        print(e);
        yield ErrorBlocUploadImageState();
      }
    }
    if (event is InitUpdate) {
      yield SuccessUploadImageState(event.path);
    }
  }
}
