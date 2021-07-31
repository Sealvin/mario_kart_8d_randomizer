import 'package:mario_kart_8d_randomizer/models/stat.dart';

class Character {
  final num id;
  final String longName;
  final String name;
  final String img;
  final String sound;
  final Stat stat;

  Character(
      {this.id, this.longName, this.name, this.img, this.sound, this.stat});

  // Create object from JSON
  factory Character.fromJson(Map<String, dynamic> json) => new Character(
      id: json["id"],
      longName: json["longName"],
      name: json["name"],
      img: json["img"],
      sound: json["sound"],
      stat: Stat.fromJson(json));
}
