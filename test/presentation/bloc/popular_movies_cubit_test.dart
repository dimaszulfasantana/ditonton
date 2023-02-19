import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesCubit bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMoviesCubit(fetchPopularAllMovie: mockGetPopularMovies);
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

  blocTest<PopularMoviesCubit, PopularMoviesState>(
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
              statePopularAllMoviesData: RequestState.Loading,
              allPopularMoviesData: [],
            ),
            bloc.state.copyWith(
              statePopularAllMoviesData: RequestState.Loaded,
              allPopularMoviesData: tMovieList,
            ),
          ]);

  blocTest<PopularMoviesCubit, PopularMoviesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async =>
            Left(FailureServerException('Server FailureException')));
        return bloc;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      wait: Duration(milliseconds: 100),
      expect: () => [
            bloc.state.copyWith(
              statePopularAllMoviesData: RequestState.Loading,
              allPopularMoviesData: [],
              message: '',
            ),
            bloc.state.copyWith(
              statePopularAllMoviesData: RequestState.Error,
              allPopularMoviesData: [],
              message: 'Server FailureException',
            ),
          ]);
}
