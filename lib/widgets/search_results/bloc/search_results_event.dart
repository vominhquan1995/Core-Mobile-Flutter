part of 'search_results_bloc.dart';

abstract class SearchResultsEvent extends Equatable {
  const SearchResultsEvent();
}

class SearchData extends SearchResultsEvent {
  ParamFilter filter;
  bool isPrivate;
  SearchData({this.filter, this.isPrivate});
  @override
  String toString() => 'SearchData';
  @override
  // TODO: implement props
  List<Object> get props => [filter];
}

class LoadMoreData extends SearchResultsEvent {
  ParamFilter filter;
  bool isPrivate;
  LoadMoreData({this.filter, this.isPrivate});
  @override
  String toString() => 'LoadMoreData';
  @override
  List<Object> get props => [filter];
}
