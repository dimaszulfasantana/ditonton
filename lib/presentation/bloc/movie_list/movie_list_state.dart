import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieListState extends Equatable {
  final RequestState nowPlayingState;
  final RequestState popularState;
  final RequestState topRatedState;
  final List<Movie> nowPlayingList;
  final List<Movie> popularList;
  final List<Movie> topRatedList;

  const MovieListState({
    required this.nowPlayingState,
    required this.popularState,
    required this.topRatedState,
    required this.nowPlayingList,
    required this.popularList,
    required this.topRatedList,
  });

  MovieListState copyWith({
    RequestState? nowPlayingState,
    RequestState? popularState,
    RequestState? topRatedState,
    List<Movie>? nowPlayingList,
    List<Movie>? popularList,
    List<Movie>? topRatedList,
  }) {
    return MovieListState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularState: popularState ?? this.popularState,
      topRatedState: topRatedState ?? this.topRatedState,
      nowPlayingList: nowPlayingList ?? this.nowPlayingList,
      popularList: popularList ?? this.popularList,
      topRatedList: topRatedList ?? this.topRatedList,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingState,
        popularState,
        topRatedState,
        nowPlayingList,
        popularList,
        topRatedList,
      ];
}
