import 'package:ditonton/data/models/tvseries/tv_series_results.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvResultsModel = TvSeriesResults(
      backdropPath: "path.jpg",
      firstAirDate: "2022-05-05",
      genreIds: [1, 2, 3, 4],
      id: 1,
      name: "Original Title",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Original Name",
      overview: "Overview",
      popularity: 1.0,
      posterPath: "/path.jpg",
      voteAverage: 1.0,
      voteCount: 1);

  final tTvSeries = TvSeries(
      backdropPath: "path.jpg",
      firstAirDate: "2022-05-05",
      genreIds: [1, 2, 3, 4],
      id: 1,
      name: "Original Title",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Original Name",
      overview: "Overview",
      popularity: 1.0,
      posterPath: "/path.jpg",
      voteAverage: 1.0,
      voteCount: 1);

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvResultsModel.toEntity();
    expect(result, tTvSeries);
  });
}