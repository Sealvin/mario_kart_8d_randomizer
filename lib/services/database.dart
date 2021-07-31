import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mario_kart_8d_randomizer/models/build.dart';
import 'package:mario_kart_8d_randomizer/models/glider.dart';
import 'package:mario_kart_8d_randomizer/models/tire.dart';
import 'package:mario_kart_8d_randomizer/models/vehicule.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/character.dart';

class DBProvider {
  // Create a singleton
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "asset_database.db");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data =
          await rootBundle.load(join('assets', 'mk8drandomizer.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
    return await openDatabase(path, version: 1, onOpen: (db) async {});
  }

  Future<Vehicule> getRandomVehiculeForCharacter(int characterId) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * from vehicule join stat on stat.id = vehicule.statId join characterVehiculeGroup on characterVehiculeGroup.vehiculeId = vehicule.id where characterVehiculeGroup.characterId=$characterId ORDER BY RANDOM() LIMIT 1');

    return res.isNotEmpty ? Vehicule.fromMap(res.first) : null;
  }

  Future<Glider> getRandomGliderForCharacter(int characterId) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * from glider join stat on stat.id = glider.statId join characterGliderGroup on characterGliderGroup.gliderId = glider.id where characterGliderGroup.characterId=$characterId ORDER BY RANDOM() LIMIT 1');

    return res.isNotEmpty ? Glider.fromJson(res.first) : null;
  }

  Future<Tire> getRandomTire() async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * from tire join stat on tire.statId = stat.id ORDER BY RANDOM() LIMIT 1');

    return res.isNotEmpty ? Tire.fromJson(res.first) : null;
  }

  Future<Character> getRandomCharacter() async {
    final db = await database;
    final response = await db.rawQuery(
        'SELECT * FROM (select * from character order by random()) as character join stat on character.statId = stat.id group by statId order by RANDOM() LIMIT 1');
    return Character.fromJson(response.first);
  }

  Future<Build> getRandomBuild() async {
    Character randomCharacter = await DBProvider.db.getRandomCharacter();
    Vehicule randomVehicule =
        await DBProvider.db.getRandomVehiculeForCharacter(randomCharacter.id);
    Tire randomTire = await DBProvider.db.getRandomTire();
    Glider randomGlirer =
        await DBProvider.db.getRandomGliderForCharacter(randomCharacter.id);
    return new Build(
        character: randomCharacter,
        vehicule: randomVehicule,
        glider: randomGlirer,
        tire: randomTire);
  }
}
