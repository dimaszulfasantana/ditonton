import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularMoviesCubit>().fetchPopularMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
            if (state.popularMoviesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.popularMoviesState == RequestState.Loaded) {
              return ListView.builder(
                  itemCount: state.popularMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.popularMovies[index];
                    return MovieCard(movie);
                  });
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}
