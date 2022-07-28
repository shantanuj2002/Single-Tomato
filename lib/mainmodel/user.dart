
class User11 {
  String name;
  String activity;
  String urlImage;
  double latitude;
  double longitude;
  int rate;
  int likes;
  int rating;
  User11({
    required this.name,
    required this.activity,
    required this.urlImage,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.likes,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'activity': activity,
        'urlImage': urlImage,
        'latitude': latitude,
        'longitude': longitude,
        'rate':rate,
        'likes':likes,
        'rating':rating
      };

  static User11 fromJson(Map<String, dynamic> json) => User11(
        name: json['name'],
        activity: json['activity'],
        urlImage: json['urlImage'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        rate: json['rate'],
        likes: json['likes'],
        rating: json['rating']
      );
}
