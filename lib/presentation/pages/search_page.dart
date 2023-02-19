import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/type_helper.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_state.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final typeHelper = ModalRoute.of(context)!.settings.arguments as TypeHelper;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          typeHelper == TypeHelper.Movies
              ? 'Search Movies'
              : 'Search TV Series',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                typeHelper == TypeHelper.Movies
                    ? context.read<SearchMovieBloc>().add(
                          SearchMovieFetchEvent(query: query),
                        )
                    : context.read<SearchTvSeriesBloc>().add(
                          SearchTvSeriesFetchEvent(query: query),
                        );
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: headLineBigger,
            ),
            typeHelper == TypeHelper.Movies
                ? BlocBuilder<SearchMovieBloc, SearchMovieState>(
                    builder: (context, state) {
                      if (state.stateSearchMovieDataState ==
                          RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.stateSearchMovieDataState ==
                          RequestState.Loaded) {
                        final result = state.allMovieList;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = state.allMovieList[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                    builder: (context, state) {
                    if (state.stateSearchTvSeries == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.stateSearchTvSeries ==
                        RequestState.Loaded) {
                      final result = state.allTvSeriesList;
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tvSeries = state.allTvSeriesList[index];
                            return TvSeriesCardList(tvSeries: tvSeries);
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  }),
          ],
        ),
      ),
    );
  }
}
