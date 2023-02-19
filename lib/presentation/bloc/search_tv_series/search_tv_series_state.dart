import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SearchTvSeriesState extends Equatable {
  final RequestState stateSearchTvSeries;
  final List<TvSeries> allTvSeriesList;
  final String message;

  SearchTvSeriesState({
    required this.stateSearchTvSeries,
    required this.allTvSeriesList,
    required this.message,
  });

  SearchTvSeriesState copyWith({
    RequestState? stateSearchTvSeries,
    List<TvSeries>? allTvSeriesList,
    String? message,
  }) {
    return SearchTvSeriesState(
      stateSearchTvSeries: stateSearchTvSeries ?? this.stateSearchTvSeries,
      allTvSeriesList: allTvSeriesList ?? this.allTvSeriesList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateSearchTvSeries,
        allTvSeriesList,
        message,
      ];
}
