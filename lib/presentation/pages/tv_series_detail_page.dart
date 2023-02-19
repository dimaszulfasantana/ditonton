import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_detail';
  final int id;
  const TvSeriesDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvSeriesDetailCubit>()
      ..fetchTvSeriesDetail(widget.id)
      ..loadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
        builder: (context, state) {
          if (state.stateAllTvSeriesDetail == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.stateAllTvSeriesDetail == RequestState.Loaded) {
            final tvSeries = state.allTvSeriesDetail;
            return SafeArea(
                child: DetailContent(
              tvDetails: tvSeries,
              isAddedToWatchListorNot: state.isAddedToWatchListorNot,
              recommendations: state.allTvSeriesRecommendations,
            ));
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetails? tvDetails;
  final bool isAddedToWatchListorNot;
  final List<TvSeries> recommendations;
  const DetailContent({
    Key? key,
    required this.tvDetails,
    required this.isAddedToWatchListorNot,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetails?.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: colourNavy,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      height: 4,
                      width: 48,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvDetails?.name ?? "",
                            style: headlineBig,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!isAddedToWatchListorNot) {
                                await context
                                    .read<TvSeriesDetailCubit>()
                                    .addWatchlist(tvDetails!);
                              } else {
                                await context
                                    .read<TvSeriesDetailCubit>()
                                    .removeFromWatchlist(tvDetails!);
                              }

                              final message = context
                                  .read<TvSeriesDetailCubit>()
                                  .state
                                  .allWatchedListMessage;
                              if (message ==
                                      TvSeriesDetailCubit
                                          .watchlistAddSuccessMessage ||
                                  message ==
                                      TvSeriesDetailCubit
                                          .watchlistRemoveSuccessMessage) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(message),
                                    );
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isAddedToWatchListorNot
                                    ? Icon(Icons.check)
                                    : Icon(Icons.add),
                                Text('Watchlist'),
                              ],
                            ),
                          ),
                          Text(
                            _showGenres(
                              tvDetails?.genres ?? [],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Seasons: ${tvDetails?.numberOfSeasons ?? 0}'),
                          Text("Episodes: ${tvDetails?.numberOfEpisodes ?? 0}"),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: (tvDetails?.voteAverage ?? 0) / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    color: colourDarkYellow,
                                  );
                                },
                                itemSize: 24,
                              ),
                              Text(
                                '${tvDetails?.voteAverage ?? 0}',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Overview',
                            style: headlineBig,
                          ),
                          Text(
                            tvDetails?.overview ?? "",
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Recommendations',
                            style: headLineBigger,
                          ),
                          BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
                              builder: (context, state) {
                            if (state.stateAllRecommendationTvSeries ==
                                RequestState.Loading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state.stateAllRecommendationTvSeries ==
                                RequestState.Loaded) {
                              return Container(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final tvSeries = recommendations[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            TvSeriesDetailPage.ROUTE_NAME,
                                            arguments: tvSeries.id,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                            placeholder: (context, url) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: recommendations.length,
                                ),
                              );
                            } else if (state.stateAllRecommendationTvSeries ==
                                RequestState.Error) {
                              return Text(state.message);
                            } else {
                              return Container();
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: colourNavy,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<TvGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += (genre.name) + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
