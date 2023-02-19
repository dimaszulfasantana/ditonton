import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final RequestState stateAllTvSeriesDetail;
  final RequestState stateAllRecommendationTvSeries;
  final TvDetails allTvSeriesDetail;
  final List<TvSeries> allTvSeriesRecommendations;
  final String allWatchedListMessage;
  final bool isAddedToWatchListorNot;
  final String message;

  TvSeriesDetailState({
    required this.stateAllTvSeriesDetail,
    required this.stateAllRecommendationTvSeries,
    required this.allTvSeriesDetail,
    required this.allTvSeriesRecommendations,
    required this.allWatchedListMessage,
    required this.isAddedToWatchListorNot,
    required this.message,
  });

  TvSeriesDetailState copyWith({
    RequestState? stateAllTvSeriesDetail,
    RequestState? stateAllRecommendationTvSeries,
    TvDetails? allTvSeriesDetail,
    List<TvSeries>? allTvSeriesRecommendations,
    String? allWatchedListMessage,
    bool? isAddedToWatchListorNot,
    String? message,
  }) {
    return TvSeriesDetailState(
      stateAllTvSeriesDetail:
          stateAllTvSeriesDetail ?? this.stateAllTvSeriesDetail,
      stateAllRecommendationTvSeries:
          stateAllRecommendationTvSeries ?? this.stateAllRecommendationTvSeries,
      allTvSeriesDetail: allTvSeriesDetail ?? this.allTvSeriesDetail,
      allTvSeriesRecommendations:
          allTvSeriesRecommendations ?? this.allTvSeriesRecommendations,
      allWatchedListMessage:
          allWatchedListMessage ?? this.allWatchedListMessage,
      isAddedToWatchListorNot: isAddedToWatchListorNot ?? this.isAddedToWatchListorNot,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateAllTvSeriesDetail,
        stateAllRecommendationTvSeries,
        allTvSeriesDetail,
        allTvSeriesRecommendations,
        allWatchedListMessage,
        isAddedToWatchListorNot,
        message,
      ];
}
