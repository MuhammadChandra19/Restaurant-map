class Rating {
  final String text;
  final String average;
  final String votes;

  Rating.fromJson(Map json)
      : text = json['rating_text'].toString(),
        average = json['aggregate_rating'].toString(),
        votes = json['votes'] is int ? json['votes'].toString() : json['votes'];
}
