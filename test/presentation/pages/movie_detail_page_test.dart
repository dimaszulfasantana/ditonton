import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit])
void main() {
  late MockMovieDetailCubit mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [BlocProvider<MovieDetailCubit>(create: (_) => mockBloc)],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: '',
        isAddedToWatchListorNot: false,
        message: '')));
    when(mockBloc.state).thenReturn(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: '',
        isAddedToWatchListorNot: false,
        message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: 'Added to Watchlist',
        isAddedToWatchListorNot: true,
        message: '')));
    when(mockBloc.state).thenReturn(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: 'Added to Watchlist',
        isAddedToWatchListorNot: true,
        message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: 'Added to Watchlist',
        isAddedToWatchListorNot: false,
        message: '')));
    when(mockBloc.state).thenReturn(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: 'Added to Watchlist',
        isAddedToWatchListorNot: false,
        message: ''));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: 'Failed',
        isAddedToWatchListorNot: false,
        message: '')));
    when(mockBloc.state).thenReturn(MovieDetailState(
        movieDetailState: RequestState.Loaded,
        stateAllRecommendationTvSeries: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        allWatchedListMessage: 'Failed',
        isAddedToWatchListorNot: false,
        message: ''));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
