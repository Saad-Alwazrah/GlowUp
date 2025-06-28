import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Repositories/models/stylist.dart';

class Services {
  Services({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.price,
    required this.providerId,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int durationMinutes;
  late final double price;
  late final String providerId;
  List<Stylist> stylists = [];
  Provider? provider;

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    durationMinutes = json['duration_minutes'];
    price = json['price'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['duration_minutes'] = durationMinutes;
    _data['price'] = price;
    _data['provider_id'] = providerId;
    return _data;
  }
}
