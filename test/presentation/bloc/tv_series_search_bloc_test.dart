import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([
  SearchTvSeries,
])
void main() {
  late SearchTvSeriesBloc bloc;
  late MockSearchTvSeries mockSearchTvSeries;
  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    bloc = SearchTvSeriesBloc(searchTvSeries: mockSearchTvSeries);
  });

  final id = 1;

  final tvSeries = TvSeries(
      backdropPath: "/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
      firstAirDate: "2022-01-28",
      genreIds: [1, 2, 3],
      id: id,
      name: "All of Us Are Dead",
      originCountry: ["KR"],
      originalLanguage: "ko",
      originalName: "test",
      overview: "overview",
      popularity: 1,
      posterPath: "/6zUUtzj7aJzOdoxhpiGzEKYtj1o.jpg",
      voteAverage: 1,
      voteCount: 1);

  final tvSeriesList = <TvSeries>[tvSeries];
  final query = "All of Us Are Dead";

  group('Search Tv Series', () {
    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should change state to loading then loaded when usecase is called',
      build: () {
        when(mockSearchTvSeries.execute(query))
            .thenAnswer((_) async => Right(tvSeriesList));
        return bloc;
      },
      act: (cubit) => cubit.add(SearchTvSeriesFetchEvent(query: query)),
      expect: () => [
        bloc.state.copyWith(
          searchTvSeriesState: RequestState.Loading,
          tvSeriesList: [],
        ),
        bloc.state.copyWith(
          searchTvSeriesState: RequestState.Loaded,
          tvSeriesList: tvSeriesList,
        ),
      ],
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'should return server failure when data is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(query))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (cubit) => cubit.add(SearchTvSeriesFetchEvent(query: query)),
      expect: () => [
        bloc.state.copyWith(
          searchTvSeriesState: RequestState.Loading,
          message: '',
        ),
        bloc.state.copyWith(
          searchTvSeriesState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );
  });
}
