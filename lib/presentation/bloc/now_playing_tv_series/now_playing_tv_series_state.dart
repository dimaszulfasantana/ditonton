import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class NowPlayingTvSeriesState extends Equatable {
  final RequestState stateNowPlaying;
  final List<TvSeries> allNowPlayingList;
  final String message;

  NowPlayingTvSeriesState({
    required this.stateNowPlaying,
    required this.allNowPlayingList,
    required this.message,
  });

  NowPlayingTvSeriesState copyWith({
    RequestState? stateNowPlaying,
    List<TvSeries>? allNowPlayingList,
    String? message,
  }) {
    return NowPlayingTvSeriesState(
      stateNowPlaying: stateNowPlaying ?? this.stateNowPlaying,
      allNowPlayingList: allNowPlayingList ?? this.allNowPlayingList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateNowPlaying,
        allNowPlayingList,
        message,
      ];
}
