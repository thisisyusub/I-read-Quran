import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../.././../data/services/hive_service.dart';

class DiagramPage extends StatefulWidget {
  DiagramPage({Key key}) : super(key: key);

  @override
  _DiagramPageState createState() => _DiagramPageState();
}

class _DiagramPageState extends State<DiagramPage> {
  @override
  Widget build(BuildContext context) {
    final readSurahCount = HiveService().readSurahCount;
    final readAyahCount = HiveService().readAyahCount;

    final surahProgress = double.tryParse(readSurahCount.toString());
    final ayahProgress = double.tryParse(readAyahCount.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Nəticələrim'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box('appBox').listenable(keys: ['readSurahCount']),
                  builder: (_, __, ___) {
                    return Expanded(
                      child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        axes: <RadialAxis>[
                          RadialAxis(
                            radiusFactor: 0.6,
                            minimum: 0,
                            maximum: 114,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            canScaleToFit: true,
                            showFirstLabel: true,
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                angle: 90,
                                widget: Text(
                                  '$readSurahCount/114\n Surə',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: surahProgress,
                                color: Theme.of(context).primaryColor,
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box('appBox').listenable(keys: ['readAyahCount']),
                  builder: (_, __, ___) {
                    return Expanded(
                      child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        axes: <RadialAxis>[
                          RadialAxis(
                            radiusFactor: 0.6,
                            minimum: 0,
                            maximum: 6236,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            canScaleToFit: true,
                            showFirstLabel: true,
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                angle: 90,
                                widget: Text(
                                  '$readAyahCount/6236\n Ayə',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: ayahProgress,
                                color: Theme.of(context).primaryColor,
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          'Sıfırla',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        content: Text(
                          'Sıfırlamaq istədiyinizə əminsinizmi?',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              HiveService().resetProgress().then((_) {
                                setState(() {});
                              });
                            },
                            child: Text(
                              'Bəli',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          FlatButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text(
                              'Xeyr',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.restore,
                color: Colors.white,
              ),
              label: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Sıfırla',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
