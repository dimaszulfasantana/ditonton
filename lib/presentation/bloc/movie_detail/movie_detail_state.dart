import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final RequestState movieDetailState;
  final RequestState recommendationsState;
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final String message;

  MovieDetailState({
    required this.movieDetailState,
    required this.recommendationsState,
    required this.movieDetail,
    required this.movieRecommendations,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.message,
  });

  MovieDetailState copyWith({
    RequestState? movieDetailState,
    RequestState? recommendationsState,
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    String? message,
  }) {
    return MovieDetailState(
      movieDetailState: movieDetailState ?? this.movieDetailState,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        movieDetailState,
        recommendationsState,
        movieDetail,
        movieRecommendations,
        watchlistMessage,
        isAddedToWatchlist,
        message,
      ];
}
