import 'package:mario_kart_8d_randomizer/models/stat.dart';

class Tire {
  final num id;
  final String longName;
  final String longNameFr;
  final String name;
  final String img;
  final Stat stat;

  Tire(
      {this.id,
      this.longName,
      this.longNameFr,
      this.name,
      this.img,
      this.stat});

  // Create object from JSON
  factory Tire.fromJson(Map<String, dynamic> json) => new Tire(
        id: json["id"],
        longName: json["longName"],
        longNameFr: json["longNameFr"],
        name: json["name"],
        img: json["img"],
        stat: Stat.fromJson(json),
      );
}
