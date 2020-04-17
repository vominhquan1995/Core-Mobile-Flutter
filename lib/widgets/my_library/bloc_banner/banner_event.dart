part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetBanner extends BannerEvent {
  GetBanner();
}
