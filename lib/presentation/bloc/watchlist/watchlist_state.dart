import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  final RequestState watchlistMovieState;
  final RequestState watchlistTvSeriesState;
  final List<Movie> movieList;
  final List<TvSeries> tvSeriesList;
  final String message;

  WatchlistState({
    required this.watchlistMovieState,
    required this.watchlistTvSeriesState,
    required this.movieList,
    required this.tvSeriesList,
    required this.message,
  });

  WatchlistState copyWith({
    RequestState? watchlistMovieState,
    RequestState? watchlistTvSeriesState,
    List<Movie>? movieList,
    List<TvSeries>? tvSeriesList,
    String? message,
  }) {
    return WatchlistState(
      watchlistMovieState: watchlistMovieState ?? this.watchlistMovieState,
      watchlistTvSeriesState:
          watchlistTvSeriesState ?? this.watchlistTvSeriesState,
      movieList: movieList ?? this.movieList,
      tvSeriesList: tvSeriesList ?? this.tvSeriesList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        watchlistMovieState,
        watchlistTvSeriesState,
        movieList,
        tvSeriesList,
        message,
      ];
}
