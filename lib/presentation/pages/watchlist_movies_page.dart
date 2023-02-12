import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistCubit>()
      ..fetchMoviesWatchlist()
      ..fetchTvSeriesWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistCubit>()
      ..fetchMoviesWatchlist()
      ..fetchTvSeriesWatchlist();
  }

  final List<Map> dropDownList = [
    {'id': 0, 'kategori': 'Movies'},
    {'id': 1, 'kategori': 'TV Series'},
  ];
  int dropDownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            dropDownKategori(),
            SizedBox(
              height: 8.0,
            ),
            BlocBuilder<WatchlistCubit, WatchlistState>(
              builder: (context, state) {
                if (state.watchlistMovieState == RequestState.Loading ||
                    state.watchlistTvSeriesState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.watchlistMovieState == RequestState.Loaded ||
                    state.watchlistTvSeriesState == RequestState.Loaded) {
                  return Expanded(
                    child: dropDownValue == 0
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = state.movieList[index];
                              return MovieCard(movie);
                            },
                            itemCount: state.movieList.length,
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final tvSeries = state.tvSeriesList[index];
                              return TvSeriesCardList(
                                tvSeries: tvSeries,
                              );
                            },
                            itemCount: state.tvSeriesList.length,
                          ),
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  StatefulBuilder dropDownKategori() {
    return StatefulBuilder(
      builder: (context, dropDownState) {
        return InputDecorator(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                isExpanded: true,
                isDense: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                value: dropDownValue,
                items: dropDownList
                    .map(
                      (data) => DropdownMenuItem(
                        value: data["id"],
                        child: Text(
                          data["kategori"],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  dropDownState(() {
                    dropDownValue = newValue as int;
                  });
                }),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
