import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    saveTvSeriesWatchlist =
        SaveTvSeriesWatchlist(tvSeriesRepository: mockTvSeriesRepository);
  });

  test('should remove tv series watchlist from repository', () async {
    // arrange
    when(mockTvSeriesRepository.addToWatchList(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await saveTvSeriesWatchlist.execute(testTvSeriesDetail);
    // assert
    expect(result, Right('Added to Watchlist'));
  });
}
