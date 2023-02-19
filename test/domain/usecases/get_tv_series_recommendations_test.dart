import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations fetchTvSeriesRecommendationsData;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    fetchTvSeriesRecommendationsData =
        GetTvSeriesRecommendations(tvSeriesRepository: mockTvSeriesRepository);
  });

  int id = 1;
  final allTvSeriesList = <TvSeries>[];

  test('should return tv series recommendations list from repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.fetchTvSeriesRecommendationsData(id))
        .thenAnswer((_) async => Right(allTvSeriesList));
    // act
    final result = await fetchTvSeriesRecommendationsData.execute(id);
    // assert
    expect(result, Right(allTvSeriesList));
  });
}
