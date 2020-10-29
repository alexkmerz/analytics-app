import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import '../services/db.dart';
import '../services/file.dart';

import 'package:http/http.dart' as http;
import '../services/globals.dart' as globals;

class Analyse extends StatefulWidget {
  Analyse();

  @override
  AnalyseState createState() => AnalyseState();
}

class AnalyseState extends State<Analyse> {
  bool recording = false;

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    String buttonText = "Start";

    final List<String> accelerometer = _accelerometerValues
        ?.map((double v) => v.toStringAsFixed(10))
        ?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(10))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(10))
        ?.toList();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('$buttonText'),
                    onPressed: () async {
                      // Testing database functionality
                      debugPrint("Commence database testing");

                      DB db = new DB();
                      db.init('analytics.db');

                      final directory =
                          await getApplicationDocumentsDirectory();
                      final filename = directory.path + '/test.json';

                      FF file = new FF(filename, 'PENDING');
                      db.insertFile(file);

                      // Start recording and or stop recording
                      debugPrint("Clicked button");

                      if (recording) {
                        buttonText = "Stop";

                        final directory =
                            await getApplicationDocumentsDirectory();
                        debugPrint(directory.path);
                        final filename = directory.path + '/test.json';

                        final file = File(filename);
                        debugPrint(_accelerometerValues.toString());

                        await file
                            .writeAsString(_accelerometerValues.toString());

                        var request = new http.MultipartRequest(
                            "POST", Uri.parse("${globals.url}/file"));
                        request.headers.addAll({
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization': 'Bearer: ${globals.jwt}'
                        });

                        request.files.add(http.MultipartFile('analytics',
                            file.readAsBytes().asStream(), file.lengthSync(),
                            filename: filename.split('/').last));

                        await request.send();
                        debugPrint("File uploaded");
                      } else {
                        debugPrint('No longer debugging');
                        buttonText = 'Start';
                      }

                      recording = !recording;
                    },
                  )
                ],
              ),
              padding: const EdgeInsets.all(16.0)),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('A: $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('UA: $userAccelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('G: $gyroscope'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        if (recording) {
          _accelerometerValues = <double>[event.x, event.y, event.z];
        }
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        if (recording) {
          _gyroscopeValues = <double>[event.x, event.y, event.z];
        }
      });
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        if (recording) {
          _userAccelerometerValues = <double>[event.x, event.y, event.z];
        }
      });
    }));
  }
}
