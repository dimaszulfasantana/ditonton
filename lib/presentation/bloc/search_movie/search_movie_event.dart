import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovieFetchEvent extends SearchMovieEvent {
  final String query;
  SearchMovieFetchEvent({
    required this.query,
  });

  @override
  List<Object?> get props => [
        query,
      ];
}
