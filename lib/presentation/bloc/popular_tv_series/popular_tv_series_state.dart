import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class PopularTvSeriesState extends Equatable {
  final RequestState statePopularTvSeries;
  final List<TvSeries> allPopularList;
  final String message;

  PopularTvSeriesState({
    required this.statePopularTvSeries,
    required this.allPopularList,
    required this.message,
  });

  PopularTvSeriesState copyWith({
    RequestState? statePopularTvSeries,
    List<TvSeries>? allPopularList,
    String? message,
  }) {
    return PopularTvSeriesState(
      statePopularTvSeries: statePopularTvSeries ?? this.statePopularTvSeries,
      allPopularList: allPopularList ?? this.allPopularList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        statePopularTvSeries,
        allPopularList,
        message,
      ];
}
