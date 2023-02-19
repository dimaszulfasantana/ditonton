import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieListState extends Equatable {
  final RequestState stateNowPlaying;
  final RequestState statePopularTvSeries;
  final RequestState stateTopRatedTvSeries;
  final List<Movie> allNowPlayingList;
  final List<Movie> allPopularList;
  final List<Movie> allTopRatedList;

  const MovieListState({
    required this.stateNowPlaying,
    required this.statePopularTvSeries,
    required this.stateTopRatedTvSeries,
    required this.allNowPlayingList,
    required this.allPopularList,
    required this.allTopRatedList,
  });

  MovieListState copyWith({
    RequestState? stateNowPlaying,
    RequestState? statePopularTvSeries,
    RequestState? stateTopRatedTvSeries,
    List<Movie>? allNowPlayingList,
    List<Movie>? allPopularList,
    List<Movie>? allTopRatedList,
  }) {
    return MovieListState(
      stateNowPlaying: stateNowPlaying ?? this.stateNowPlaying,
      statePopularTvSeries: statePopularTvSeries ?? this.statePopularTvSeries,
      stateTopRatedTvSeries:
          stateTopRatedTvSeries ?? this.stateTopRatedTvSeries,
      allNowPlayingList: allNowPlayingList ?? this.allNowPlayingList,
      allPopularList: allPopularList ?? this.allPopularList,
      allTopRatedList: allTopRatedList ?? this.allTopRatedList,
    );
  }

  @override
  List<Object?> get props => [
        stateNowPlaying,
        statePopularTvSeries,
        stateTopRatedTvSeries,
        allNowPlayingList,
        allPopularList,
        allTopRatedList,
      ];
}
