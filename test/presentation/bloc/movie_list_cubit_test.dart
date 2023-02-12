import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListCubit bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieListCubit(
      fetchNowPlayingAllMovie: mockGetNowPlayingMovies,
      fetchPopularAllMovie: mockGetPopularMovies,
      fetchTopRatedAllMovie: mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    blocTest<MovieListCubit, MovieListState>(
      'should get data from the usecase',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (cubit) => cubit.fetchNowPlayingMovies(),
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        mockGetNowPlayingMovies.execute();
      },
    );

    blocTest<MovieListCubit, MovieListState>(
        'should change state to Loading and Loaded when usecase is called',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (cubit) => cubit.fetchNowPlayingMovies(),
        wait: Duration(milliseconds: 100),
        expect: () => [
              bloc.state.copyWith(
                nowPlayingState: RequestState.Loading,
                nowPlayingList: [],
              ),
              bloc.state.copyWith(
                nowPlayingState: RequestState.Loaded,
                nowPlayingList: tMovieList,
              ),
            ]);

    blocTest<MovieListCubit, MovieListState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (cubit) => cubit.fetchNowPlayingMovies(),
        wait: Duration(milliseconds: 100),
        expect: () => [
              bloc.state.copyWith(
                nowPlayingState: RequestState.Loading,
                nowPlayingList: [],
              ),
              bloc.state.copyWith(
                nowPlayingState: RequestState.Error,
                nowPlayingList: [],
              ),
            ]);
  });

  group('popular movies', () {
    blocTest<MovieListCubit, MovieListState>(
        'should change state to Loading and Loaded when usecase is called',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (cubit) => cubit.fetchPopularMovies(),
        wait: Duration(milliseconds: 100),
        expect: () => [
              bloc.state.copyWith(
                popularState: RequestState.Loading,
                popularList: [],
              ),
              bloc.state.copyWith(
                popularState: RequestState.Loaded,
                popularList: tMovieList,
              ),
            ]);

    blocTest<MovieListCubit, MovieListState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (cubit) => cubit.fetchPopularMovies(),
        wait: Duration(milliseconds: 100),
        expect: () => [
              bloc.state.copyWith(
                popularState: RequestState.Loading,
                popularList: [],
              ),
              bloc.state.copyWith(
                popularState: RequestState.Error,
                popularList: [],
              ),
            ]);
  });

  group('top rated movies', () {
    blocTest<MovieListCubit, MovieListState>(
        'should change state to Loading and Loaded when usecase is called',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (cubit) => cubit.fetchTopRatedMovies(),
        wait: Duration(milliseconds: 100),
        expect: () => [
              bloc.state.copyWith(
                topRatedState: RequestState.Loading,
                topRatedList: [],
              ),
              bloc.state.copyWith(
                topRatedState: RequestState.Loaded,
                topRatedList: tMovieList,
              ),
            ]);

    blocTest<MovieListCubit, MovieListState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (cubit) => cubit.fetchTopRatedMovies(),
        wait: Duration(milliseconds: 100),
        expect: () => [
              bloc.state.copyWith(
                topRatedState: RequestState.Loading,
                topRatedList: [],
              ),
              bloc.state.copyWith(
                topRatedState: RequestState.Error,
                topRatedList: [],
              ),
            ]);
  });
}
