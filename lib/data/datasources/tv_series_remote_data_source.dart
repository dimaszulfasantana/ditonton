import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tvseries/tv_series_details.dart';
import 'package:ditonton/data/models/tvseries/tv_series_response.dart';
import 'package:ditonton/data/models/tvseries/tv_series_results.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesResults>> fetchNowPlayingTvSeriesData();
  Future<List<TvSeriesResults>> fetchPopularTvSeriesData();
  Future<List<TvSeriesResults>> fetchTopRatedTvSeriesData();
  Future<TvSeriesDetails> fetchTvSeriesDataDetails(int seriesId);
  Future<List<TvSeriesResults>> fetchSearchTvSeriesData(String query);
  Future<List<TvSeriesResults>> fetchTvSeriesRecommendationsData(int seriesId);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3/';

  final IOClient client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesResults>> fetchNowPlayingTvSeriesData() async {
    final response = await client
        .get(Uri.parse('${BASE_URL}tv/on_the_air?$API_KEY&language=en-US'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesResults>> fetchPopularTvSeriesData() async {
    final response = await client
        .get(Uri.parse('${BASE_URL}tv/popular?$API_KEY&language=en-US'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesResults>> fetchSearchTvSeriesData(String query) async {
    final response = await client.get(Uri.parse(
        '${BASE_URL}search/tv?$API_KEY&language=en-US&page=1&include_adult=false&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesResults>> fetchTopRatedTvSeriesData() async {
    final response = await client
        .get(Uri.parse('${BASE_URL}tv/top_rated?$API_KEY&language=en-US'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetails> fetchTvSeriesDataDetails(int seriesId) async {
    final response = await client
        .get(Uri.parse('${BASE_URL}tv/$seriesId?$API_KEY&language=en-US'));

    if (response.statusCode == 200) {
      return TvSeriesDetails.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesResults>> fetchTvSeriesRecommendationsData(
      int seriesId) async {
    final response = await client.get(Uri.parse(
        '${BASE_URL}tv/$seriesId/recommendations?$API_KEY&language=en-US&page=1'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
