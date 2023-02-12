import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesWatchlistStatus {
  final TvSeriesRepository tvSeriesRepository;
  GetTvSeriesWatchlistStatus({
    required this.tvSeriesRepository,
  });

  Future<bool> execute(int id) async {
    return await tvSeriesRepository.isAddedToWatchlist(id);
  }
}
