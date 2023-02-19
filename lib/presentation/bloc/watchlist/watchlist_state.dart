import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  final RequestState allWatchedMovieState;
  final RequestState allWatchedListTvSeriesState;
  final List<Movie> allMovie;
  final List<TvSeries> allTvSeriesList;
  final String message;

  WatchlistState({
    required this.allWatchedMovieState,
    required this.allWatchedListTvSeriesState,
    required this.allMovie,
    required this.allTvSeriesList,
    required this.message,
  });

  WatchlistState copyWith({
    RequestState? allWatchedMovieState,
    RequestState? allWatchedListTvSeriesState,
    List<Movie>? allMovie,
    List<TvSeries>? allTvSeriesList,
    String? message,
  }) {
    return WatchlistState(
      allWatchedMovieState: allWatchedMovieState ?? this.allWatchedMovieState,
      allWatchedListTvSeriesState:
          allWatchedListTvSeriesState ?? this.allWatchedListTvSeriesState,
      allMovie: allMovie ?? this.allMovie,
      allTvSeriesList: allTvSeriesList ?? this.allTvSeriesList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        allWatchedMovieState,
        allWatchedListTvSeriesState,
        allMovie,
        allTvSeriesList,
        message,
      ];
}
