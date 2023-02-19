import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class RemoveTvSeriesWatchlist {
  final TvSeriesRepository tvSeriesRepository;
  RemoveTvSeriesWatchlist({
    required this.tvSeriesRepository,
  });

  Future<Either<FailureException, String>> execute(TvDetails tvSeries) async {
    return await tvSeriesRepository.deleteFromWatchList(tvSeries);
  }
}
