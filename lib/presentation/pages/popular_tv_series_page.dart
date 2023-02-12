import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';
  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<PopularTvSeriesCubit>().fetchPopularTvSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
            builder: (context, state) {
          if (state.popularState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.popularState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.popularList[index];
                return TvSeriesCardList(tvSeries: tvSeries);
              },
              itemCount: state.popularList.length,
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
