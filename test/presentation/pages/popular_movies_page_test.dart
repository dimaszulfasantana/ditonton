import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesCubit])
void main() {
  late MockPopularMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularMoviesCubit();
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

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [BlocProvider<PopularMoviesCubit>(create: (_) => mockCubit)],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(PopularMoviesState(
        statePopularAllMoviesData: RequestState.Loading,
        allPopularMoviesData: [],
        message: '')));
    when(mockCubit.state).thenReturn(PopularMoviesState(
        statePopularAllMoviesData: RequestState.Loading,
        allPopularMoviesData: [],
        message: ''));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(PopularMoviesState(
        statePopularAllMoviesData: RequestState.Loaded,
        allPopularMoviesData: tMovieList,
        message: '')));
    when(mockCubit.state).thenReturn(PopularMoviesState(
        statePopularAllMoviesData: RequestState.Loaded,
        allPopularMoviesData: tMovieList,
        message: ''));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(PopularMoviesState(
        statePopularAllMoviesData: RequestState.Error,
        allPopularMoviesData: [],
        message: 'Error message')));
    when(mockCubit.state).thenReturn(PopularMoviesState(
        statePopularAllMoviesData: RequestState.Error,
        allPopularMoviesData: [],
        message: 'Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
