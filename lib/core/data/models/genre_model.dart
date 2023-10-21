import 'dart:convert';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable{
  final int id;
  final String name;

  const GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  static List<GenreModel> genreModelListFromListMap(dynamic genres) => List<GenreModel>.from(genres.map((x) => GenreModel.fromJson(x)));

  static String genreModelListToJson(List<GenreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  @override

  List<Object> get props => [id,name];

}
