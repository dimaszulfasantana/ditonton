import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TopRatedTvSeriesState extends Equatable {
  final RequestState topRatedState;
  final List<TvSeries> topRatedList;
  final String message;

  TopRatedTvSeriesState({
    required this.topRatedState,
    required this.topRatedList,
    required this.message,
  });

  TopRatedTvSeriesState copyWith({
    RequestState? topRatedState,
    List<TvSeries>? topRatedList,
    String? message,
  }) {
    return TopRatedTvSeriesState(
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedList: topRatedList ?? this.topRatedList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        topRatedState,
        topRatedList,
        message,
      ];
}
