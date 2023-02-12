import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class NowPlayingTvSeriesState extends Equatable {
  final RequestState nowPlayingState;
  final List<TvSeries> nowPlayingList;
  final String message;

  NowPlayingTvSeriesState({
    required this.nowPlayingState,
    required this.nowPlayingList,
    required this.message,
  });

  NowPlayingTvSeriesState copyWith({
    RequestState? nowPlayingState,
    List<TvSeries>? nowPlayingList,
    String? message,
  }) {
    return NowPlayingTvSeriesState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingList: nowPlayingList ?? this.nowPlayingList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingState,
        nowPlayingList,
        message,
      ];
}
