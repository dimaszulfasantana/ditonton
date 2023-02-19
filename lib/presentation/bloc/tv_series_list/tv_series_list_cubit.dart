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
            stateNowPlaying: RequestState.Empty,
            statePopularTvSeries: RequestState.Empty,
            stateTopRatedTvSeries: RequestState.Empty,
            allNowPlayingList: [],
            allPopularList: [],
            allTopRatedList: [],
            message: ''));

  Future<void> fetchNowPlayingTvSeries() async {
    emit(state.copyWith(
        stateNowPlaying: RequestState.Loading, allNowPlayingList: []));
    final result = await fetchNowPlayingTvSeriesData.execute();
    result.fold((failure) {
      emit(state.copyWith(
          stateNowPlaying: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          stateNowPlaying: RequestState.Loaded, allNowPlayingList: result));
    });
  }

  Future<void> fetchPopularTvSeries() async {
    emit(state.copyWith(
        statePopularTvSeries: RequestState.Loading, allPopularList: []));
    final result = await fetchPopularTvSeriesData.execute();
    result.fold((failure) {
      emit(state.copyWith(
          statePopularTvSeries: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          statePopularTvSeries: RequestState.Loaded, allPopularList: result));
    });
  }

  Future<void> fetchTopRatedTvSeries() async {
    emit(state.copyWith(
        stateTopRatedTvSeries: RequestState.Loading, allTopRatedList: []));
    final result = await fetchTopRatedTvSeriesData.execute();
    result.fold((failure) {
      emit(state.copyWith(
          stateTopRatedTvSeries: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          stateTopRatedTvSeries: RequestState.Loaded, allTopRatedList: result));
    });
  }
}
