import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchlist getAllTvSeriesWatchlist;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getAllTvSeriesWatchlist =
        GetTvSeriesWatchlist(tvSeriesRepository: mockTvSeriesRepository);
  });

  test('should return tv series watchlist from repository', () async {
    // arrange
    when(mockTvSeriesRepository.fetchWatchListTvDataSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await getAllTvSeriesWatchlist.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}
