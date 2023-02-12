import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail getTvSeriesDetail;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvSeriesDetail =
        GetTvSeriesDetail(tvSeriesRepository: mockTvSeriesRepository);
  });

  final id = 1;

  test('should get tv series details from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.fetchTvSeriesDataDetails(id))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await getTvSeriesDetail.execute(id);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
