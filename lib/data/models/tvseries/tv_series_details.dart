import 'dart:convert';

import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetails extends Equatable {
  TvSeriesDetails({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.name,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<dynamic>? createdBy;
  List<int>? episodeRunTime;
  List<Genre>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  String? name;
  List<Network>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Network>? productionCompanies;
  List<dynamic>? productionCountries;
  List<Season>? seasons;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  factory TvSeriesDetails.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetails(
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        createdBy: json["created_by"] == null
            ? null
            : List<dynamic>.from(json["created_by"].map((x) => x)),
        episodeRunTime: json["episode_run_time"] == null
            ? null
            : List<int>.from(json["episode_run_time"].map((x) => x)),
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"] == null ? null : json["homepage"],
        id: json["id"] == null ? null : json["id"],
        inProduction:
            json["in_production"] == null ? null : json["in_production"],
        languages: json["languages"] == null
            ? null
            : List<String>.from(json["languages"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        networks: json["networks"] == null
            ? null
            : List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"] == null
            ? null
            : json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"] == null
            ? null
            : json["number_of_seasons"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        overview: json["overview"] == null ? null : json["overview"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        productionCompanies: json["production_companies"] == null
            ? null
            : List<Network>.from(
                json["production_companies"].map((x) => Network.fromJson(x))),
        productionCountries: json["production_countries"] == null
            ? null
            : List<dynamic>.from(json["production_countries"].map((x) => x)),
        seasons: json["seasons"] == null
            ? null
            : List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? null
            : List<SpokenLanguage>.from(json["spoken_languages"]
                .map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
        tagline: json["tagline"] == null ? null : json["tagline"],
        type: json["type"] == null ? null : json["type"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "created_by": createdBy == null
            ? null
            : List<dynamic>.from(createdBy?.map((x) => x) ?? []),
        "episode_run_time": episodeRunTime == null
            ? null
            : List<dynamic>.from(episodeRunTime?.map((x) => x) ?? []),
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres?.map((x) => x.toJson()) ?? []),
        "homepage": homepage == null ? null : homepage,
        "id": id == null ? null : id,
        "in_production": inProduction == null ? null : inProduction,
        "languages": languages == null
            ? null
            : List<dynamic>.from(languages?.map((x) => x) ?? []),
        "name": name == null ? null : name,
        "networks": networks == null
            ? null
            : List<dynamic>.from(networks?.map((x) => x.toJson()) ?? []),
        "number_of_episodes":
            numberOfEpisodes == null ? null : numberOfEpisodes,
        "number_of_seasons": numberOfSeasons == null ? null : numberOfSeasons,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry?.map((x) => x) ?? []),
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_name": originalName == null ? null : originalName,
        "overview": overview == null ? null : overview,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "production_companies": productionCompanies == null
            ? null
            : List<dynamic>.from(
                productionCompanies?.map((x) => x.toJson()) ?? []),
        "production_countries": productionCountries == null
            ? null
            : List<dynamic>.from(productionCountries?.map((x) => x) ?? []),
        "seasons": seasons == null
            ? null
            : List<dynamic>.from(seasons?.map((x) => x.toJson()) ?? []),
        "spoken_languages": spokenLanguages == null
            ? null
            : List<dynamic>.from(spokenLanguages?.map((x) => x.toJson()) ?? []),
        "status": status == null ? null : status,
        "tagline": tagline == null ? null : tagline,
        "type": type == null ? null : type,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };

  TvDetails toEntity() {
    return TvDetails(
        adult: adult ?? false,
        backdropPath: backdropPath ?? "",
        createdBy: createdBy ?? [],
        episodeRunTime: episodeRunTime ?? [],
        genres: genres?.map((genre) => genre.toEntity()).toList() ?? [],
        homepage: homepage ?? "",
        id: id ?? 0,
        inProduction: inProduction ?? false,
        languages: languages ?? [],
        name: name ?? "",
        numberOfEpisodes: numberOfEpisodes ?? 0,
        numberOfSeasons: numberOfSeasons ?? 0,
        originCountry: originCountry ?? [],
        originalLanguage: originalLanguage ?? "",
        originalName: originalName ?? "",
        overview: overview ?? "",
        popularity: popularity ?? 0,
        posterPath: posterPath ?? "",
        productionCountries: productionCountries ?? [],
        seasons: seasons?.map((season) => season.toEntity()).toList() ?? [],
        status: status ?? "",
        tagline: tagline ?? "",
        type: type ?? "",
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0);
  }

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
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };

  TvGenre toEntity() {
    return TvGenre(id: this.id ?? 0, name: this.name ?? "");
  }
}

class TEpisodeToAir {
  TEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  DateTime? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  dynamic runtime;
  int? seasonNumber;
  int? showId;
  dynamic stillPath;
  int? voteAverage;
  int? voteCount;

  factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeNumber:
            json["episode_number"] == null ? null : json["episode_number"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        overview: json["overview"] == null ? null : json["overview"],
        productionCode:
            json["production_code"] == null ? null : json["production_code"],
        runtime: json["runtime"],
        seasonNumber:
            json["season_number"] == null ? null : json["season_number"],
        showId: json["show_id"] == null ? null : json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"],
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate == null
            ? null
            : "${airDate?.year.toString().padLeft(4, '0')}-${airDate?.month.toString().padLeft(2, '0')}-${airDate?.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber == null ? null : episodeNumber,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "production_code": productionCode == null ? null : productionCode,
        "runtime": runtime,
        "season_number": seasonNumber == null ? null : seasonNumber,
        "show_id": showId == null ? null : showId,
        "still_path": stillPath,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };
}

class Network {
  Network({
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  });

  int? id;
  String? name;
  String? logoPath;
  String? originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry:
            json["origin_country"] == null ? null : json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "logo_path": logoPath == null ? null : logoPath,
        "origin_country": originCountry == null ? null : originCountry,
      };
}

class Season {
  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  DateTime? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount:
            json["episode_count"] == null ? null : json["episode_count"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        overview: json["overview"] == null ? null : json["overview"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        seasonNumber:
            json["season_number"] == null ? null : json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate == null
            ? null
            : "${airDate?.year.toString().padLeft(4, '0')}-${airDate?.month.toString().padLeft(2, '0')}-${airDate?.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount == null ? null : episodeCount,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "poster_path": posterPath == null ? null : posterPath,
        "season_number": seasonNumber == null ? null : seasonNumber,
      };

  TvSeason toEntity() {
    return TvSeason(
        airDate: this.airDate ?? DateTime(0),
        episodeCount: this.episodeCount ?? 0,
        id: this.id ?? 0,
        name: this.name ?? "",
        overview: this.overview ?? "",
        posterPath: this.posterPath ?? "",
        seasonNumber: this.seasonNumber ?? 0);
  }
}

class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  String? englishName;
  String? iso6391;
  String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"] == null ? null : json["english_name"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName == null ? null : englishName,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "name": name == null ? null : name,
      };
}
