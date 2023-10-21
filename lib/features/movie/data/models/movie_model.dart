import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final List<int> genreIds;
  final int id;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final String genres;

  const MovieModel({
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    this.genres = "",
  });

  MovieModel copyWith({
    List<int>? genreIds,
    int? id,
    String? overview,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    String? genres,
  }) =>
      MovieModel(
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        genres: genres ?? this.genres
      );

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    overview: json["overview"],
    posterPath: json["poster_path"]??"",
    releaseDate: DateTime.parse(json["release_date"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "overview": overview,
    "poster_path": posterPath,
    "release_date": releaseDate.year.toString(),
    "title": title,
  };

  @override
  List<Object?> get props => [
    genreIds,
    id,
    overview,
    posterPath,
    releaseDate,
    title,
    genres,
  ];
}
