import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository tvSeriesRepository;

  GetTvSeriesRecommendations({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, List<TvSeries>>> execute(int seriesId) async {
    return await tvSeriesRepository.fetchTvSeriesRecommendationsData(seriesId);
  }
}
