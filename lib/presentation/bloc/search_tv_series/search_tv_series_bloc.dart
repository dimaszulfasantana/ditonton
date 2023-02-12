import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;
  SearchTvSeriesBloc({
    required this.searchTvSeries,
  }) : super(
          SearchTvSeriesState(
            searchTvSeriesState: RequestState.Empty,
            tvSeriesList: [],
            message: '',
          ),
        ) {
    on<SearchTvSeriesEvent>(_fetchSearchedTvSeries);
  }

  Future<void> _fetchSearchedTvSeries(
      SearchTvSeriesEvent event, Emitter<SearchTvSeriesState> emit) async {
    if (event is SearchTvSeriesFetchEvent) {
      emit(state.copyWith(searchTvSeriesState: RequestState.Loading));
      final result = await searchTvSeries.execute(event.query);
      result.fold((failure) {
        emit(state.copyWith(
            searchTvSeriesState: RequestState.Error, message: failure.message));
      }, (result) {
        emit(state.copyWith(
            searchTvSeriesState: RequestState.Loaded, tvSeriesList: result));
      });
    }
  }
}
