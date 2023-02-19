import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_state.dart';

class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries fetchNowPlayingTvSeriesData;

  NowPlayingTvSeriesCubit({
    required this.fetchNowPlayingTvSeriesData,
  }) : super(NowPlayingTvSeriesState(
            stateNowPlaying: RequestState.Empty,
            allNowPlayingList: [],
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
}
