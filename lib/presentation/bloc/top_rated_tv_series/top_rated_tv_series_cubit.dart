import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries fetchTopRatedTvSeriesData;

  TopRatedTvSeriesCubit({
    required this.fetchTopRatedTvSeriesData,
  }) : super(TopRatedTvSeriesState(
            topRatedState: RequestState.Empty, topRatedList: [], message: ''));

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
