import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlistMovies getAllWatchListMovie;
  final GetTvSeriesWatchlist getAllTvSeriesWatchlist;

  WatchlistCubit({
    required this.getAllWatchListMovie,
    required this.getAllTvSeriesWatchlist,
  }) : super(
          WatchlistState(
            allWatchedMovieState: RequestState.Empty,
            allWatchedListTvSeriesState: RequestState.Empty,
            allMovie: [],
            allTvSeriesList: [],
            message: '',
          ),
        );

  Future<void> fetchMoviesWatchlist() async {
    emit(state.copyWith(allWatchedMovieState: RequestState.Loading));
    final result = await getAllWatchListMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(
          allWatchedMovieState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          allWatchedMovieState: RequestState.Loaded, allMovie: result));
    });
  }

  Future<void> fetchTvSeriesWatchlist() async {
    emit(state.copyWith(allWatchedListTvSeriesState: RequestState.Loading));
    final result = await getAllTvSeriesWatchlist.execute();
    result.fold((failure) {
      emit(state.copyWith(
          allWatchedListTvSeriesState: RequestState.Error,
          message: failure.message));
    }, (result) {
      emit(state.copyWith(
          allWatchedListTvSeriesState: RequestState.Loaded,
          allTvSeriesList: result));
    });
  }
}
