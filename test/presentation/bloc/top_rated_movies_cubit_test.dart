import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesCubit bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMoviesCubit(fetchTopRatedAllMovie: mockGetTopRatedMovies);
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

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
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
              stateTopRatedAllMovies: RequestState.Loading,
              allTopRatedMovie: [],
            ),
            bloc.state.copyWith(
              stateTopRatedAllMovies: RequestState.Loaded,
              allTopRatedMovie: tMovieList,
            ),
          ]);

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async =>
            Left(FailureServerException('Server FailureException')));
        return bloc;
      },
      act: (cubit) => cubit.fetchTopRatedMovies(),
      wait: Duration(milliseconds: 100),
      expect: () => [
            bloc.state.copyWith(
              stateTopRatedAllMovies: RequestState.Loading,
              allTopRatedMovie: [],
              message: '',
            ),
            bloc.state.copyWith(
              stateTopRatedAllMovies: RequestState.Error,
              allTopRatedMovie: [],
              message: 'Server FailureException',
            ),
          ]);
}
