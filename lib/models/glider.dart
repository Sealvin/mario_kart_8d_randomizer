import 'package:mario_kart_8d_randomizer/models/stat.dart';

class Glider {
  final num id;
  final String longName;
  final String longNameFr;
  final String name;
  final String img;
  final Stat stat;

  Glider(
      {this.id,
      this.longName,
      this.longNameFr,
      this.name,
      this.img,
      this.stat});

  // Create object from JSON
  factory Glider.fromJson(Map<String, dynamic> json) => new Glider(
      id: json["id"],
      longName: json["longName"],
      longNameFr: json["longNameFr"],
      name: json["name"],
      img: json["img"],
      stat: Stat.fromJson(json));
}
