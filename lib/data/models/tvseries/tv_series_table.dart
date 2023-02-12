import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvSeriesTable.fromEntity(TvDetails tvSeries) => TvSeriesTable(
      id: tvSeries.id,
      name: tvSeries.name,
      posterPath: tvSeries.posterPath,
      overview: tvSeries.overview);

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
