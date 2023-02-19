import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';
  const TopRatedTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<TopRatedTvSeriesCubit>().fetchTopRatedTvSeries(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
            builder: (context, state) {
          if (state.stateTopRatedTvSeries == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.stateTopRatedTvSeries == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.allTopRatedList[index];
                return TvSeriesCardList(tvSeries: tvSeries);
              },
              itemCount: state.allTopRatedList.length,
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          }
        }),
      ),
    );
  }
}
