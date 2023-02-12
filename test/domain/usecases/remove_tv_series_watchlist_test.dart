import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    removeTvSeriesWatchlist =
        RemoveTvSeriesWatchlist(tvSeriesRepository: mockTvSeriesRepository);
  });

  test('should remove tv series watchlist from repository', () async {
    // arrange
    when(mockTvSeriesRepository.deleteFromWatchList(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await removeTvSeriesWatchlist.execute(testTvSeriesDetail);
    // assert
    expect(result, Right('Removed from watchlist'));
  });
}
