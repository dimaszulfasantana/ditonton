import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlistMovies fetchWatchListAllMovie;
  final GetTvSeriesWatchlist getTvSeriesWatchlist;

  WatchlistCubit({
    required this.fetchWatchListAllMovie,
    required this.getTvSeriesWatchlist,
  }) : super(
          WatchlistState(
            watchlistMovieState: RequestState.Empty,
            watchlistTvSeriesState: RequestState.Empty,
            movieList: [],
            tvSeriesList: [],
            message: '',
          ),
        );

  Future<void> fetchMoviesWatchlist() async {
    emit(state.copyWith(watchlistMovieState: RequestState.Loading));
    final result = await fetchWatchListAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(
          watchlistMovieState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          watchlistMovieState: RequestState.Loaded, movieList: result));
    });
  }

  Future<void> fetchTvSeriesWatchlist() async {
    emit(state.copyWith(watchlistTvSeriesState: RequestState.Loading));
    final result = await getTvSeriesWatchlist.execute();
    result.fold((failure) {
      emit(state.copyWith(
          watchlistTvSeriesState: RequestState.Error,
          message: failure.message));
    }, (result) {
      emit(state.copyWith(
          watchlistTvSeriesState: RequestState.Loaded, tvSeriesList: result));
    });
  }
}
