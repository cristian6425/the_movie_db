import 'package:equatable/equatable.dart';

abstract class ResponseEntity extends Equatable {
  final int page;
  final List<dynamic> results;
  final int totalPages;
  final int totalResults;

  const ResponseEntity({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object> get props => [page, results, totalPages, totalResults];
}
