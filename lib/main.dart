import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url = "http://192.168.8.1/api/device/signal";

  String responseBodySample = '''<?xml version="1.0" encoding="UTF-8"?>
<response>
<pci>144</pci>
<sc></sc>
<cell_id>136003329</cell_id>
<rsrq>-8dB</rsrq>
<rsrp>-76dBm</rsrp>
<rssi>&gt;=-51dBm</rssi>
<sinr>1dB</sinr>
<rscp></rscp>
<ecio></ecio>
<mode>7</mode>
</response>
''';
  void fetchPosts() async {
    try {
      // final response = await get(Uri.parse(url), headers: {
      //   "Cookie":
      //       "SessionID=i+PlXphIn9pI9hX2AEVr/pCP3oSbD5QeVEA2lRP0/TOk+mqSDjOMsZxFkJpywAytNUoReuzTzTRknwiywExC6zcAquyPwQ7K0nSXmfPs+K47UHkvV7kLRznJMg+18Gx1",
      // });
      // print(response.body);
      // print(responseBodySample);
      var storeDocument = xml.parse(responseBodySample);
      final abcSINR = storeDocument.findAllElements('sinr').first;
      final abcRSSI = storeDocument.findAllElements('rssi').first;
      final abcRSRP = storeDocument.findAllElements('rsrp').first;
      final abcRSRQ = storeDocument.findAllElements('rsrq').first;
      String valueSINR = abcSINR.children.first.toString();
      print(valueSINR.replaceAll("dB", ""));
      String valueRSSI = abcRSSI.children.first.toString();
      print(valueRSSI.replaceAll("dBm", ""));
      String valueRSRP = abcRSRP.children.first.toString();
      print(valueRSRP.replaceAll("dBm", ""));
      String valueRSRQ = abcRSRQ.children.first.toString();
      print(valueRSRQ.replaceAll("dB", ""));
      // print(storeDocument.findAllElements('rssi'));
      // print(storeDocument.findAllElements('rsrp'));
      // print(storeDocument.findAllElements('rsrq'));
      //final jsonData = jsonDecode(response.body) as List;
      setState(() {});
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Get Data"),
              onPressed: () {
                fetchPosts();
              },
            ),
            SfRadialGauge(
              title: GaugeTitle(
                  text: 'SINR',
                  textStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              enableLoadingAnimation: true,
              animationDuration: 4500,
              axes: <RadialAxis>[
                RadialAxis(minimum: -20, maximum: 30, pointers: <GaugePointer>[
                  NeedlePointer(value: 13, enableAnimation: true)
                ], ranges: <GaugeRange>[
                  GaugeRange(startValue: -20, endValue: 0, color: Colors.red),
                  GaugeRange(startValue: 0, endValue: 13, color: Colors.orange),
                  GaugeRange(
                      startValue: 13, endValue: 20, color: Colors.yellow),
                  GaugeRange(startValue: 20, endValue: 30, color: Colors.green)
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text(
                        '13 dB',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      positionFactor: 0.5,
                      angle: 90)
                ])
              ],
            ),
            SfRadialGauge(
              title: GaugeTitle(
                  text: 'RSSI',
                  textStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              enableLoadingAnimation: true,
              animationDuration: 4500,
              axes: <RadialAxis>[
                RadialAxis(
                    minimum: -110,
                    maximum: -50,
                    pointers: <GaugePointer>[
                      NeedlePointer(value: -60, enableAnimation: true)
                    ],
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: -50, endValue: -65, color: Colors.green),
                      GaugeRange(
                          startValue: -65, endValue: -75, color: Colors.yellow),
                      GaugeRange(
                          startValue: -75, endValue: -85, color: Colors.orange),
                      GaugeRange(
                          startValue: -85, endValue: -95, color: Colors.red),
                      GaugeRange(
                          startValue: -95,
                          endValue: -110,
                          color: Colors.red.shade900)
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text(
                            '-60 dBm',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          positionFactor: 0.5,
                          angle: 90)
                    ])
              ],
            ),
            SfRadialGauge(
              title: GaugeTitle(
                  text: 'RSRP',
                  textStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              enableLoadingAnimation: true,
              animationDuration: 4500,
              axes: <RadialAxis>[
                RadialAxis(minimum: -200, maximum: 0, pointers: <GaugePointer>[
                  NeedlePointer(value: -20, enableAnimation: true)
                ], ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: -80, color: Colors.green),
                  GaugeRange(
                      startValue: -80, endValue: -90, color: Colors.yellow),
                  GaugeRange(
                      startValue: -90, endValue: -100, color: Colors.orange),
                  GaugeRange(
                      startValue: -100, endValue: -200, color: Colors.red)
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text(
                        '-20 dBm',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      positionFactor: 0.5,
                      angle: 90)
                ])
              ],
            ),
            SfRadialGauge(
              title: GaugeTitle(
                  text: 'RSRQ',
                  textStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              enableLoadingAnimation: true,
              animationDuration: 4500,
              axes: <RadialAxis>[
                RadialAxis(minimum: -50, maximum: 0, pointers: <GaugePointer>[
                  NeedlePointer(value: -5, enableAnimation: true)
                ], ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: -10, color: Colors.green),
                  GaugeRange(
                      startValue: -10, endValue: -15, color: Colors.yellow),
                  GaugeRange(
                      startValue: -15, endValue: -20, color: Colors.orange),
                  GaugeRange(startValue: -20, endValue: -50, color: Colors.red)
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text(
                        '-5 dB',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      positionFactor: 0.5,
                      angle: 90)
                ])
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
