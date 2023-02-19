import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchlistStatus getTvSeriesWatchlistStatus;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvSeriesWatchlistStatus =
        GetTvSeriesWatchlistStatus(tvSeriesRepository: mockTvSeriesRepository);
  });

  int id = 1;

  test('should return tv series watchlist status by id', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchListorNot(id))
        .thenAnswer((_) async => true);
    // act
    final result = await getTvSeriesWatchlistStatus.execute(id);
    // assert
    expect(result, true);
  });
}
