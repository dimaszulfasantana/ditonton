import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesCubit])
void main() {
  late MockTopRatedMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TopRatedMoviesCubit>(create: (_) => mockCubit)
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(TopRatedMoviesState(
          stateTopRatedAllMovies: RequestState.Loading,
          allTopRatedMovie: [],
          message: '',
        )));
    when(mockCubit.state).thenReturn(TopRatedMoviesState(
      stateTopRatedAllMovies: RequestState.Loading,
      allTopRatedMovie: [],
      message: '',
    ));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(TopRatedMoviesState(
          stateTopRatedAllMovies: RequestState.Loaded,
          allTopRatedMovie: [],
          message: '',
        )));
    when(mockCubit.state).thenReturn(TopRatedMoviesState(
      stateTopRatedAllMovies: RequestState.Loaded,
      allTopRatedMovie: [],
      message: '',
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(TopRatedMoviesState(
          stateTopRatedAllMovies: RequestState.Error,
          allTopRatedMovie: [],
          message: 'Error message',
        )));
    when(mockCubit.state).thenReturn(TopRatedMoviesState(
      stateTopRatedAllMovies: RequestState.Error,
      allTopRatedMovie: [],
      message: 'Error message',
    ));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
