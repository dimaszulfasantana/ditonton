import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesListState extends Equatable {
  final RequestState nowPlayingState;
  final RequestState popularState;
  final RequestState topRatedState;
  final List<TvSeries> nowPlayingList;
  final List<TvSeries> popularList;
  final List<TvSeries> topRatedList;
  final String message;

  TvSeriesListState({
    required this.nowPlayingState,
    required this.popularState,
    required this.topRatedState,
    required this.nowPlayingList,
    required this.popularList,
    required this.topRatedList,
    required this.message,
  });

  TvSeriesListState copyWith({
    RequestState? nowPlayingState,
    RequestState? popularState,
    RequestState? topRatedState,
    List<TvSeries>? nowPlayingList,
    List<TvSeries>? popularList,
    List<TvSeries>? topRatedList,
    String? message,
  }) {
    return TvSeriesListState(
        nowPlayingState: nowPlayingState ?? this.nowPlayingState,
        popularState: popularState ?? this.popularState,
        topRatedState: topRatedState ?? this.topRatedState,
        nowPlayingList: nowPlayingList ?? this.nowPlayingList,
        popularList: popularList ?? this.popularList,
        topRatedList: topRatedList ?? this.topRatedList,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        nowPlayingState,
        popularState,
        topRatedState,
        nowPlayingList,
        popularList,
        topRatedList,
        message,
      ];
}
