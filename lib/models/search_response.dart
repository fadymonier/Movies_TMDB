class SearchResponse {
  int? page;
  List<dynamic>? results;
  int? totalPages;
  int? totalResults;

  SearchResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<dynamic>.from(json["results"].map((x) => x)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
