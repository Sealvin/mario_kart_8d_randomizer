import 'package:mario_kart_8d_randomizer/models/character.dart';
import 'package:mario_kart_8d_randomizer/models/glider.dart';
import 'package:mario_kart_8d_randomizer/models/tire.dart';
import 'package:mario_kart_8d_randomizer/models/vehicule.dart';

class Build {
  final Character character;
  final Vehicule vehicule;
  final Glider glider;
  final Tire tire;

  Build({this.character, this.vehicule, this.glider, this.tire});

  Map<String, dynamic> toMap() {
    return {
      'character': character,
      'vehicule': vehicule,
      'glider': glider,
      'tire': tire
    };
  }
}
