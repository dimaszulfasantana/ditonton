import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tvseries/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'tvSeriesTitle',
  posterPath: 'posterPath',
  overview: 'tvOverview',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'tvSeriesTitle',
  'posterPath': 'posterPath',
  'overview': 'tvOverview',
};

final testTvSeriesDetail = TvDetails(
  adult: false,
  backdropPath: 'backdropPath',
  createdBy: ['createdBy'],
  episodeRunTime: [1],
  genres: [
    TvGenre(id: 1, name: 'Drama'),
  ],
  homepage: 'homePage',
  id: 1,
  name: 'tvSeriesTitle',
  posterPath: 'posterPath',
  overview: 'tvOverview',
  inProduction: false,
  languages: ['en'],
  numberOfEpisodes: 12,
  numberOfSeasons: 3,
  originCountry: ['den'],
  originalLanguage: 'id',
  originalName: 'originalName',
  popularity: 1,
  productionCountries: [],
  seasons: [
    TvSeason(
        airDate: DateTime(0),
        episodeCount: 0,
        id: 1,
        name: "season",
        overview: "overview",
        posterPath: "path",
        seasonNumber: 1),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1);

final testTvSeriesList = [testTvSeries];

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'tvSeriesTitle',
  posterPath: 'posterPath',
  overview: 'tvOverview',
);
