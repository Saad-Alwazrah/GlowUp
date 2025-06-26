class Provider {
  Provider({
    required this.name,
    this.address,
    this.phone,
    required this.createdAt,
    required this.id,
    required this.avgRating,
    required this.ratingCount,
    this.latitude,
    this.longitude,
    this.mapsUrl,
  });
  late String name;
  late String? address;
  late String? phone;
  late final String createdAt;
  late final String id;
  late double? avgRating;
  late int? ratingCount;
  late double? latitude;
  late double? longitude;
  late String? mapsUrl;
  String? distanceFromUser;

  Provider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'] as String?;
    phone = json['phone'] as String?;
    createdAt = json['created_at'];
    id = json['id'];
    avgRating = json['avg_rating'] as double?;
    ratingCount = json['rating_count'] as int?;
    latitude = json['latitude'] as double?;
    longitude = json['longitude'] as double?;
    mapsUrl = json['maps_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    _data['avg_rating'] = avgRating;
    _data['rating_count'] = ratingCount;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['maps_url'] = mapsUrl;
    return _data;
  }
}
