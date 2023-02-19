import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries fetchTopRatedTvSeriesData;

  TopRatedTvSeriesCubit({
    required this.fetchTopRatedTvSeriesData,
  }) : super(TopRatedTvSeriesState(
            stateTopRatedTvSeries: RequestState.Empty,
            allTopRatedList: [],
            message: ''));

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
