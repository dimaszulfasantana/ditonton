import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository tvSeriesRepository;
  GetTvSeriesDetail({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, TvDetails>> execute(int seriesId) {
    return tvSeriesRepository.fetchTvSeriesDataDetails(seriesId);
  }
}
