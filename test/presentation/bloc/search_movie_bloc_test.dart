import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchMovieBloc(findAllMovies: mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group('search movies', () {
    blocTest<SearchMovieBloc, SearchMovieState>(
      'should change state to loading then loaded when usecase is called',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (cubit) => cubit.add(SearchMovieFetchEvent(query: tQuery)),
      expect: () => [
        bloc.state.copyWith(
          stateSearchMovieDataState: RequestState.Loading,
          allMovieList: [],
        ),
        bloc.state.copyWith(
          stateSearchMovieDataState: RequestState.Loaded,
          allMovieList: tMovieList,
        ),
      ],
    );

    blocTest<SearchMovieBloc, SearchMovieState>(
      'should return server failure when data is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(FailureServerException('Failed')));
        return bloc;
      },
      act: (cubit) => cubit.add(SearchMovieFetchEvent(query: tQuery)),
      expect: () => [
        bloc.state.copyWith(
          stateSearchMovieDataState: RequestState.Loading,
          message: '',
        ),
        bloc.state.copyWith(
          stateSearchMovieDataState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );
  });
}
