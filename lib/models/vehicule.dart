import 'package:mario_kart_8d_randomizer/models/stat.dart';

class Vehicule {
  final num id;
  final String longName;
  final String longNameFr;
  final String name;
  final String img;
  final Stat stat;

  Vehicule(
      {this.id,
      this.longName,
      this.longNameFr,
      this.name,
      this.img,
      this.stat});

  factory Vehicule.fromMap(Map<String, dynamic> json) => new Vehicule(
      id: json["id"],
      longName: json["longName"],
      longNameFr: json["longNameFr"],
      name: json["name"],
      img: json["img"],
      stat: Stat.fromJson(json));
}
