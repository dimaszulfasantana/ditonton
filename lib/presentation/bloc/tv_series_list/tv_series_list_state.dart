import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesListState extends Equatable {
  final RequestState stateNowPlaying;
  final RequestState statePopularTvSeries;
  final RequestState stateTopRatedTvSeries;
  final List<TvSeries> allNowPlayingList;
  final List<TvSeries> allPopularList;
  final List<TvSeries> allTopRatedList;
  final String message;

  TvSeriesListState({
    required this.stateNowPlaying,
    required this.statePopularTvSeries,
    required this.stateTopRatedTvSeries,
    required this.allNowPlayingList,
    required this.allPopularList,
    required this.allTopRatedList,
    required this.message,
  });

  TvSeriesListState copyWith({
    RequestState? stateNowPlaying,
    RequestState? statePopularTvSeries,
    RequestState? stateTopRatedTvSeries,
    List<TvSeries>? allNowPlayingList,
    List<TvSeries>? allPopularList,
    List<TvSeries>? allTopRatedList,
    String? message,
  }) {
    return TvSeriesListState(
        stateNowPlaying: stateNowPlaying ?? this.stateNowPlaying,
        statePopularTvSeries: statePopularTvSeries ?? this.statePopularTvSeries,
        stateTopRatedTvSeries:
            stateTopRatedTvSeries ?? this.stateTopRatedTvSeries,
        allNowPlayingList: allNowPlayingList ?? this.allNowPlayingList,
        allPopularList: allPopularList ?? this.allPopularList,
        allTopRatedList: allTopRatedList ?? this.allTopRatedList,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        stateNowPlaying,
        statePopularTvSeries,
        stateTopRatedTvSeries,
        allNowPlayingList,
        allPopularList,
        allTopRatedList,
        message,
      ];
}
