part of 'search_results_bloc.dart';

abstract class SearchResultsState extends Equatable {
  const SearchResultsState();
}

class SearchResultsInitial extends SearchResultsState {
  @override
  List<Object> get props => [];
}

class LoadedData extends SearchResultsState {
  final List<SanPhamModel> list;
  final bool hasLoadMore;
  LoadedData({this.list, this.hasLoadMore});
  @override
  String toString() => 'LoadedData';
  @override
  List<Object> get props => [list, hasLoadMore];
}

class LoadDataError extends SearchResultsState {
  final e;
  LoadDataError({this.e});
  @override
  String toString() => 'LoadDataError';
  @override
  List<Object> get props => [e];
}

class EmptyData extends SearchResultsState {
  @override
  String toString() => 'EmptyData';
  @override
  List<Object> get props => [];
}

class LoadingData extends SearchResultsState {
  @override
  String toString() => 'LoadingData';
  @override
  List<Object> get props => [];
}
