import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries fetchPopularTvSeriesData;

  PopularTvSeriesCubit({
    required this.fetchPopularTvSeriesData,
  }) : super(PopularTvSeriesState(
            popularState: RequestState.Empty, popularList: [], message: ''));

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
}
