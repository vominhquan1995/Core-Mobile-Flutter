import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:Core/utils/dio_util.dart';
import 'package:Core/widgets/thongtin_canhan/service/upload_image_service.dart';
import './bloc.dart';

class BlocUploadImageBloc
    extends Bloc<BlocUploadImageEvent, BlocUploadImageState> {
  final UploadImageService service;

  BlocUploadImageBloc({@required this.service});
  @override
  BlocUploadImageState get initialState => InitialBlocUploadImageState();

  @override
  Stream<BlocUploadImageState> mapEventToState(
    BlocUploadImageEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is UploadImage) {
      yield WaittingBlocUploadImageState();
      try {
        var res = await this.service.uploadImage(event.file);
        var tt = await this.service.updateThongTinTaiKhoan(
            avatar: res['path'],
            file_system_guid: res['id'],
            path_resize: res['path_resize']);

        yield SuccessUploadImageState(
            '${DioUtil.getApiUploadFile()}/${res['path']}');
      } catch (e) {
        print(e);
        yield ErrorBlocUploadImageState();
      }
    }
  }
}
