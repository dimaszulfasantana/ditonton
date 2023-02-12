import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvDetails extends Equatable {
  bool adult;
  String backdropPath;
  List<dynamic> createdBy;
  List<int> episodeRunTime;
  List<TvGenre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  String name;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<dynamic> productionCountries;
  List<TvSeason> seasons;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  TvDetails({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCountries,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCountries,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
