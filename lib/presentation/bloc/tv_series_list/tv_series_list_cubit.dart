import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';

class TvSeriesListCubit extends Cubit<TvSeriesListState> {
  final GetNowPlayingTvSeries fetchNowPlayingTvSeriesData;
  final GetPopularTvSeries fetchPopularTvSeriesData;
  final GetTopRatedTvSeries fetchTopRatedTvSeriesData;

  TvSeriesListCubit({
    required this.fetchNowPlayingTvSeriesData,
    required this.fetchPopularTvSeriesData,
    required this.fetchTopRatedTvSeriesData,
  }) : super(TvSeriesListState(
            nowPlayingState: RequestState.Empty,
            popularState: RequestState.Empty,
            topRatedState: RequestState.Empty,
            nowPlayingList: [],
            popularList: [],
            topRatedList: [],
            message: ''));

  Future<void> fetchNowPlayingTvSeries() async {
    emit(state
        .copyWith(nowPlayingState: RequestState.Loading, nowPlayingList: []));
    final result = await fetchNowPlayingTvSeriesData.execute();
    result.fold((failure) {
      emit(state.copyWith(
          nowPlayingState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          nowPlayingState: RequestState.Loaded, nowPlayingList: result));
    });
  }

  Future<void> fetchPopularTvSeries() async {
    emit(state.copyWith(popularState: RequestState.Loading, popularList: []));
    final result = await fetchPopularTvSeriesData.execute();
    result.fold((failure) {
      emit(state.copyWith(
          popularState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          popularState: RequestState.Loaded, popularList: result));
    });
  }

  Future<void> fetchTopRatedTvSeries() async {
    emit(state.copyWith(topRatedState: RequestState.Loading, topRatedList: []));
    final result = await fetchTopRatedTvSeriesData.execute();
    result.fold((failure) {
      emit(state.copyWith(
          topRatedState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          topRatedState: RequestState.Loaded, topRatedList: result));
    });
  }
}
