import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final RequestState tvSeriesDetailState;
  final RequestState recommendationsState;
  final TvDetails tvSeriesDetail;
  final List<TvSeries> tvSeriesRecommendations;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final String message;

  TvSeriesDetailState({
    required this.tvSeriesDetailState,
    required this.recommendationsState,
    required this.tvSeriesDetail,
    required this.tvSeriesRecommendations,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.message,
  });

  TvSeriesDetailState copyWith({
    RequestState? tvSeriesDetailState,
    RequestState? recommendationsState,
    TvDetails? tvSeriesDetail,
    List<TvSeries>? tvSeriesRecommendations,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    String? message,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesRecommendations:
          tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesDetailState,
        recommendationsState,
        tvSeriesDetail,
        tvSeriesRecommendations,
        watchlistMessage,
        isAddedToWatchlist,
        message,
      ];
}
