import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TopRatedTvSeriesState extends Equatable {
  final RequestState stateTopRatedTvSeries;
  final List<TvSeries> allTopRatedList;
  final String message;

  TopRatedTvSeriesState({
    required this.stateTopRatedTvSeries,
    required this.allTopRatedList,
    required this.message,
  });

  TopRatedTvSeriesState copyWith({
    RequestState? stateTopRatedTvSeries,
    List<TvSeries>? allTopRatedList,
    String? message,
  }) {
    return TopRatedTvSeriesState(
      stateTopRatedTvSeries:
          stateTopRatedTvSeries ?? this.stateTopRatedTvSeries,
      allTopRatedList: allTopRatedList ?? this.allTopRatedList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateTopRatedTvSeries,
        allTopRatedList,
        message,
      ];
}
