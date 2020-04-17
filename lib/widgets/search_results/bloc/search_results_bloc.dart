import 'dart:async';

import 'package:Core/widgets/my_library/models/sanpham_model.dart';
import 'package:Core/widgets/search_results/model/parram_filter_model.dart';
import 'package:Core/widgets/search_results/service/service_search_results.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'search_results_event.dart';
part 'search_results_state.dart';

const PER_PAGE = 8;

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  int currentPage = 1;
  SearchResultsService service;
  SearchResultsBloc({this.service});
  @override
  SearchResultsState get initialState => SearchResultsInitial();
  @override
  Stream<SearchResultsState> mapEventToState(
    SearchResultsEvent event,
  ) async* {
    if (event is SearchData) {
      try {
        yield LoadingData();
        var data;
        if (event.isPrivate) {
          data = await service.searchDataPrivate(
              filter: event.filter, perPage: PER_PAGE);
        } else {
          data =
              await service.searchData(filter: event.filter, perPage: PER_PAGE);
        }
        if (data.isEmpty) {
          yield EmptyData();
          return;
        }
        yield LoadedData(list: data, hasLoadMore: data.length < PER_PAGE);
      } catch (e) {
        yield LoadDataError(e: e);
      }
    }
    if (event is LoadMoreData && !_isFullData(state)) {
      try {
        currentPage++;
        var data;
        if (event.isPrivate) {
          data = await service.searchDataPrivate(
              filter: event.filter,
              perPage: PER_PAGE,
              id: (state as LoadedData).list.last.id);
          yield LoadedData(
              list: (state as LoadedData).list + data,
              hasLoadMore: data.isEmpty);
        } else {
          data = await service.searchData(
              filter: event.filter,
              perPage: PER_PAGE,
              id: (state as LoadedData).list.last.id);
          yield LoadedData(
              list: (state as LoadedData).list + data,
              hasLoadMore: data.isEmpty);
        }
      } catch (e) {
        yield LoadedData(list: [], hasLoadMore: false);
      }
    }
  }

  bool _isFullData(SearchResultsState state) =>
      state is LoadedData && state.hasLoadMore;
}
