import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetPopularTvSeries {
  final TvSeriesRepository tvSeriesRepository;
  GetPopularTvSeries({
    required this.tvSeriesRepository,
  });

  Future<Either<FailureException, List<TvSeries>>> execute() {
    return tvSeriesRepository.fetchPopularTvSeriesData();
  }
}
