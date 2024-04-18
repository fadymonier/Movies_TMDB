class WatchListModel {
  String id;
  String title;
  String overview;
  String? backDropPath;

  WatchListModel(
      {this.id = "",
      required this.title,
      required this.overview,
      required this.backDropPath});

  static WatchListModel fromJson(Map<String, dynamic> json) {
    return WatchListModel(
        title: json['title'],
        overview: json['overview'],
        backDropPath: json['backDropPath'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "overview": overview,
      "backDropPath": backDropPath,
      "id": id
    };
  }
}
