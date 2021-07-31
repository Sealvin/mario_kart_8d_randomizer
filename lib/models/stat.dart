import 'build.dart';

class Stat {
  final num speedLand;
  final num speedAntiG;
  final num speedWater;
  final num speedGliding;
  final num acceleration;
  final num weight;
  final num handlingLand;
  final num handlingAntiG;
  final num handlingWater;
  final num handlingGliding;
  final num traction;
  final num miniTurbo;

  Stat(
      {this.speedLand,
      this.speedAntiG,
      this.speedWater,
      this.speedGliding,
      this.acceleration,
      this.weight,
      this.handlingLand,
      this.handlingAntiG,
      this.handlingWater,
      this.handlingGliding,
      this.traction,
      this.miniTurbo});

  factory Stat.fromJson(Map<String, dynamic> json) => new Stat(
      speedLand: json["speedLand"],
      speedAntiG: json["speedAntiG"],
      speedWater: json["speedWater"],
      speedGliding: json["speedGliding"],
      acceleration: json["acceleration"],
      weight: json["weight"],
      handlingLand: json["handlingLand"],
      handlingAntiG: json["handlingAntiG"],
      handlingWater: json["handlingWater"],
      handlingGliding: json["handlingGliding"],
      traction: json["traction"],
      miniTurbo: json["miniTurbo"]);

  Map<String, dynamic> toMap() {
    return {
      'speed': [
        {
          'speedLand': speedLand,
          'speedAntiG': speedAntiG,
          'speedWater': speedWater,
          'speedGliding': speedGliding,
        }
      ],
      'handling': [
        {
          'handlingLand': handlingLand,
          'handlingAntiG': handlingAntiG,
          'handlingWater': handlingWater,
          'handlingGliding': handlingGliding,
        }
      ],
      'acceleration': acceleration,
      'weight': weight,
      'traction': traction,
      'miniTurbo': miniTurbo,
    };
  }

  factory Stat.getStatFromGeneratedBuild(Build build) {
    Stat characterStat = build.character.stat;
    Stat vehiculeStat = build.vehicule.stat;
    Stat gliderStat = build.glider.stat;
    Stat tireStat = build.tire.stat;
    return new Stat(
      speedLand: characterStat.speedLand +
          vehiculeStat.speedLand +
          gliderStat.speedLand +
          tireStat.speedLand,
      speedAntiG: characterStat.speedAntiG +
          vehiculeStat.speedAntiG +
          gliderStat.speedAntiG +
          tireStat.speedAntiG,
      speedWater: characterStat.speedWater +
          vehiculeStat.speedWater +
          gliderStat.speedWater +
          tireStat.speedWater,
      speedGliding: characterStat.speedGliding +
          vehiculeStat.speedGliding +
          gliderStat.speedGliding +
          tireStat.speedGliding,
      acceleration: characterStat.acceleration +
          vehiculeStat.acceleration +
          gliderStat.acceleration +
          tireStat.acceleration,
      weight: characterStat.weight +
          vehiculeStat.weight +
          gliderStat.weight +
          tireStat.weight,
      handlingLand: characterStat.handlingLand +
          vehiculeStat.handlingLand +
          gliderStat.handlingLand +
          tireStat.handlingLand,
      handlingAntiG: characterStat.handlingAntiG +
          vehiculeStat.handlingAntiG +
          gliderStat.handlingAntiG +
          tireStat.handlingAntiG,
      handlingWater: characterStat.handlingWater +
          vehiculeStat.handlingWater +
          gliderStat.handlingWater +
          tireStat.handlingWater,
      handlingGliding: characterStat.handlingGliding +
          vehiculeStat.handlingGliding +
          gliderStat.handlingGliding +
          tireStat.handlingGliding,
      traction: characterStat.traction +
          vehiculeStat.traction +
          gliderStat.traction +
          tireStat.traction,
      miniTurbo: characterStat.miniTurbo +
          vehiculeStat.miniTurbo +
          gliderStat.miniTurbo +
          tireStat.miniTurbo,
    );
  }
}
