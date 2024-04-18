class Constants {
  static String baseURL = "https://api.themoviedb.org";
  static String apiKeyURL = "458af48ac7026cc7c22b8a04b3cddd30";
  static String apiKey = "?api_key=";
  static String imageURL = "https://image.tmdb.org/t/p/w500";
  static String popularURL = "$baseURL/3/movie/popular?api_key=$apiKeyURL";
  static String upcomingURL = "$baseURL/3/movie/upcoming?api_key=$apiKeyURL";
  static String categoriesURL = "/3/genre/movie/list";
  static String searchURL = "$baseURL/3/search/movie?api_key=$apiKeyURL=";
  static String detailsURL = "$baseURL/3/movie/{movie_id}?api_key=$apiKeyURL}=";
}
