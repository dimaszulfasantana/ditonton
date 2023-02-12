import 'dart:convert';

import 'package:ditonton/data/models/tvseries/tv_series_response.dart';
import 'package:ditonton/data/models/tvseries/tv_series_results.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvSeriesResults = TvSeriesResults(
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

  final tTvSeriesResponseModel = TvSeriesResponse(
      page: 1,
      results: <TvSeriesResults>[tTvSeriesResults],
      totalPages: 1,
      totalResults: 1);

  group('fromJson', () {
    test('should return a valid model from Json', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson("dummy_data/tvseries/now_playing.json"));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a Json map containing proper data', () async {
      // arrange
      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "backdrop_path": "path.jpg",
            "first_air_date": "2022-05-05",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "Original Title",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
        "total_pages": 1,
        "total_results": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
