import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final RequestState movieDetailState;
  final RequestState stateAllRecommendationTvSeries;
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  final String allWatchedListMessage;
  final bool isAddedToWatchListorNot;
  final String message;

  MovieDetailState({
    required this.movieDetailState,
    required this.stateAllRecommendationTvSeries,
    required this.movieDetail,
    required this.movieRecommendations,
    required this.allWatchedListMessage,
    required this.isAddedToWatchListorNot,
    required this.message,
  });

  MovieDetailState copyWith({
    RequestState? movieDetailState,
    RequestState? stateAllRecommendationTvSeries,
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    String? allWatchedListMessage,
    bool? isAddedToWatchListorNot,
    String? message,
  }) {
    return MovieDetailState(
      movieDetailState: movieDetailState ?? this.movieDetailState,
      stateAllRecommendationTvSeries:
          stateAllRecommendationTvSeries ?? this.stateAllRecommendationTvSeries,
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      allWatchedListMessage:
          allWatchedListMessage ?? this.allWatchedListMessage,
      isAddedToWatchListorNot:
          isAddedToWatchListorNot ?? this.isAddedToWatchListorNot,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        movieDetailState,
        stateAllRecommendationTvSeries,
        movieDetail,
        movieRecommendations,
        allWatchedListMessage,
        isAddedToWatchListorNot,
        message,
      ];
}
