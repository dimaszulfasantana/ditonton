import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  TvSeason({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
