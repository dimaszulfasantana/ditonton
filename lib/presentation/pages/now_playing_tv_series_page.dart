import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = "/now-playing-tv-series";
  const NowPlayingTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<NowPlayingTvSeriesCubit>().fetchNowPlayingTvSeries(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
            builder: (context, state) {
          if (state.nowPlayingState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.nowPlayingState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.nowPlayingList[index];
                return TvSeriesCardList(tvSeries: tvSeries);
              },
              itemCount: state.nowPlayingList.length,
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
