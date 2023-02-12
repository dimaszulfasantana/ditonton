import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SearchTvSeriesState extends Equatable {
  final RequestState searchTvSeriesState;
  final List<TvSeries> tvSeriesList;
  final String message;

  SearchTvSeriesState({
    required this.searchTvSeriesState,
    required this.tvSeriesList,
    required this.message,
  });

  SearchTvSeriesState copyWith({
    RequestState? searchTvSeriesState,
    List<TvSeries>? tvSeriesList,
    String? message,
  }) {
    return SearchTvSeriesState(
      searchTvSeriesState: searchTvSeriesState ?? this.searchTvSeriesState,
      tvSeriesList: tvSeriesList ?? this.tvSeriesList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        searchTvSeriesState,
        tvSeriesList,
        message,
      ];
}
