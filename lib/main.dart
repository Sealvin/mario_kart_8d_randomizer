import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mario_kart_8d_randomizer/models/build.dart';
import 'package:mario_kart_8d_randomizer/models/stat.dart';
import 'package:strings/strings.dart';
import './services/database.dart';

void main() => runApp(MarioKart8DrandomiserMain());

class MarioKart8DrandomiserMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarioKart8DrandomiserState();
  }
}

Build _build;
Stat _stat;
AudioCache _player = AudioCache(prefix: 'sounds/');
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MarioKart8DrandomiserState extends State<MarioKart8DrandomiserMain> {
  Future<void> _refresh() {
    return DBProvider.db.getRandomBuild().then((build) {
      setState(() {
        _build = build;
        _stat = Stat.getStatFromGeneratedBuild(build);
        _player.play(build.character.sound + '.wav');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mario Kart 8D Randomizer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _build == null
            ? Scaffold(
                backgroundColor: Colors.transparent,
              )
            : Scaffold(
                key: _scaffoldKey,
                // drawer: getDrawer(),
                backgroundColor: Colors.transparent,
                body: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['character', 'vehicule']
                            .map((buildPart) => _generateBuildPart(
                                _build.toMap()[buildPart], buildPart))
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['glider', 'tire']
                            .map((buildPart) => _generateBuildPart(
                                _build.toMap()[buildPart], buildPart))
                            .toList(),
                      ),
                      // Old container pour old progress bar
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: Column(
                          children: _stat
                              .toMap()
                              .keys
                              .map((key) => getStats(key))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Column _generateBuildPart(dynamic buildPart, String buildPartType) {
    return Column(
      children: [
        Image.asset(
          'images/' + buildPartType + '/' + buildPart.name + '.png',
          width: 170,
          height: 170,
        ),
        Text(
          buildPart.longName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  List<Container> getProgressBars(String statName) {
    List<Container> progressBars = [];
    if (statName != 'speed' && statName != 'handling') {
      progressBars.add(getProgressBarToast(statName, _stat.toMap()[statName]));
    } else {
      _stat.toMap()[statName][0].forEach(
            (entry, value) => progressBars.add(
              getProgressBarToast(entry, value),
            ),
          );
    }
    return progressBars;
  }

  Container getProgressBarToast(String stat, num value) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        child: LinearProgressIndicator(
          value: value / 6,
          valueColor:
              new AlwaysStoppedAnimation<Color>(getColorForProgressBar(stat)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Color getColorForProgressBar(String stat) {
    if (stat.contains('Gliding')) {
      return Colors.brown;
    } else if (stat.contains('AntiG')) {
      return Colors.pink;
    } else if (stat.contains('Water')) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  String getStatAverage(String statName) {
    double average = 0;
    _stat.toMap()[statName][0].forEach((entry, value) => average += value);
    average = average / 4;
    return average.toStringAsFixed(2);
  }

  Container getStats(String statName) {
    return Container(
      width: 380,
      padding: EdgeInsets.only(bottom: 15, left: 12, right: 12),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (statName == 'speed' || statName == 'handling')
                RichText(
                  text: new TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: capitalize(statName) + ' ('),
                      new TextSpan(
                        text: 'landing,',
                        style: new TextStyle(color: Colors.green),
                      ),
                      new TextSpan(
                        text: ' antiG,',
                        style: new TextStyle(color: Colors.pink),
                      ),
                      new TextSpan(
                        text: ' water,',
                        style: new TextStyle(color: Colors.blue),
                      ),
                      new TextSpan(
                        text: ' gliding',
                        style: new TextStyle(color: Colors.brown),
                      ),
                      new TextSpan(
                        text: ')',
                      ),
                    ],
                  ),
                )
              else
                Text(
                  capitalize(statName),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              Text(
                statName != 'speed' && statName != 'handling'
                    ? _stat.toMap()[statName].toString()
                    : getStatAverage(statName),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: getProgressBars(statName),
          ),
        ],
      ),
    );
  }
}
