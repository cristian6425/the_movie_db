import 'package:the_movie_db/core/domain/entities/response_entity.dart';
import 'package:the_movie_db/features/movie/data/models/movie_model.dart';

class MovieResponseModel extends ResponseEntity {
  const MovieResponseModel({
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults});

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) => MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  MovieResponseModel copyWith({List<MovieModel>? movies})=> MovieResponseModel(
    page: page,
    results: movies ?? results,
    totalPages: totalPages,
    totalResults: totalResults
  );
}
