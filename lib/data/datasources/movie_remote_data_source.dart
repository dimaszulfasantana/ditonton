import 'dart:convert';
import 'dart:io';

import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchNowPlayingAllMovie();
  Future<List<MovieModel>> fetchPopularAllMovie();
  Future<List<MovieModel>> fetchTopRatedAllMovie();
  Future<MovieDetailResponse> fetchMovieDataDetail(int id);
  Future<List<MovieModel>> fetchMovieDataRecommendations(int id);
  Future<List<MovieModel>> findAllMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=f2b6532a9eb023856af46693bf6a6478';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> fetchNowPlayingAllMovie() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).allMovie;
    } else {
      throw ErrorServerFoundException();
    }
  }

  @override
  Future<MovieDetailResponse> fetchMovieDataDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ErrorServerFoundException();
    }
  }

  @override
  Future<List<MovieModel>> fetchMovieDataRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).allMovie;
    } else {
      throw ErrorServerFoundException();
    }
  }

  @override
  Future<List<MovieModel>> fetchPopularAllMovie() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).allMovie;
    } else {
      throw ErrorServerFoundException();
    }
  }

  @override
  Future<List<MovieModel>> fetchTopRatedAllMovie() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).allMovie;
    } else {
      throw ErrorServerFoundException();
    }
  }

  @override
  Future<List<MovieModel>> findAllMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).allMovie;
    } else {
      throw ErrorServerFoundException();
    }
  }
}
