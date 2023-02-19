import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository tvSeriesRepository;
  SearchTvSeries({
    required this.tvSeriesRepository,
  });

  Future<Either<FailureException, List<TvSeries>>> execute(String query) {
    return tvSeriesRepository.fetchSearchTvSeriesData(query);
  }
}
