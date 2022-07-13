import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Material graff1(double mininum, double maximum, double interval,
    double starvalue, double endValue, Color color, double value) {
  return Material(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        SfRadialGauge(
            title: const GaugeTitle(
                text: 'Speedometer',
                textStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: mininum,
                  maximum: maximum,
                  interval: interval,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: starvalue,
                      endValue: endValue,
                      color: color,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(value: endValue)
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        // ignore: avoid_unnecessary_containers
                        widget: Container(
                            child: Text(endValue.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
            ])
      ]));
}

Material graff2(double mininum, double maxinum, double interval,
    double starvalue, double endvalue, LinearGaugeOrientation orientation) {
  return Material(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          child: SfLinearGauge(
              minimum: mininum,
              maximum: maxinum,
              interval: interval,
              orientation: orientation,
              ranges: <LinearGaugeRange>[
                LinearGaugeRange(
                    startValue: starvalue,
                    endValue: 100,
                    color: Colors.yellow,
                    endWidth: 25)
              ],
              markerPointers: [LinearShapePointer(value: endvalue)],
              majorTickStyle: const LinearTickStyle(length: 20),
              axisLabelStyle:
                  const TextStyle(fontSize: 12.0, color: Colors.black),
              axisTrackStyle: const LinearAxisTrackStyle(
                  color: Colors.cyan,
                  edgeStyle: LinearEdgeStyle.bothFlat,
                  thickness: 15.0,
                  borderColor: Colors.grey)),
        ),
      ],
    ),
  );
}

Material graff3(double minimum, double maximum, double interval, double point,
    String medida) {
  return Material(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(10),
            child: SfRadialGauge(
              animationDuration: 3500,
              enableLoadingAnimation: true,
              axes: <RadialAxis>[
                RadialAxis(
                    minimum: minimum,
                    maximum: maximum,
                    interval: interval,
                    minorTicksPerInterval: 9,
                    showAxisLine: false,
                    radiusFactor: 0.8,
                    labelOffset: 8,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: minimum,
                          endValue: maximum / 4,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: const Color.fromRGBO(123, 199, 34, 0.75)),
                      GaugeRange(
                          startValue: maximum / 4,
                          endValue: maximum / 2,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: const Color.fromRGBO(238, 193, 34, 0.75)),
                      GaugeRange(
                          startValue: maximum / 2,
                          endValue: maximum,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: const Color.fromRGBO(238, 79, 34, 0.65)),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0.35,
                          widget: Text(medida,
                              style: TextStyle(
                                  color: Color(0xFFF8B195), fontSize: 16))),
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.8,
                        widget: Text(
                          point.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: point,
                        needleStartWidth: 0,
                        needleEndWidth: 5,
                        animationType: AnimationType.easeOutBack,
                        enableAnimation: true,
                        animationDuration: 1200,
                        knobStyle: KnobStyle(
                            knobRadius: 0.06,
                            borderColor: const Color(0xFFF8B195),
                            color: Colors.white,
                            borderWidth: 0.035),
                        tailStyle: TailStyle(
                            color: const Color(0xFFF8B195),
                            width: 4,
                            length: 8),
                        needleColor: const Color(0xFFF8B195),
                      )
                    ],
                    axisLabelStyle: GaugeTextStyle(fontSize: 10),
                    majorTickStyle: const MajorTickStyle(
                        length: 0.25, lengthUnit: GaugeSizeUnit.factor),
                    minorTickStyle: const MinorTickStyle(
                        length: 0.13,
                        lengthUnit: GaugeSizeUnit.factor,
                        thickness: 1))
              ],
            )),
      ],
    ),
  );
}

Material graff4(double minimum, double maximum, double punto, String medida) {
  return Material(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(10),
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              axes: <RadialAxis>[
                RadialAxis(
                    showLabels: false,
                    showTicks: false,
                    radiusFactor: 0.8,
                    minimum: minimum,
                    maximum: maximum,
                    axisLineStyle: const AxisLineStyle(
                        cornerStyle: CornerStyle.startCurve, thickness: 5),
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          angle: 90,
                          widget: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(punto.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Text(
                                  medida,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                      GaugeAnnotation(
                        angle: 124,
                        positionFactor: 1.1,
                        widget: Text(minimum.toString(),
                            style: TextStyle(fontSize: 14)),
                      ),
                      GaugeAnnotation(
                        angle: 54,
                        positionFactor: 1.1,
                        widget: Text(maximum.toString(),
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: punto,
                        width: 18,
                        pointerOffset: -6,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Color.fromARGB(255, 1, 87, 11),
                        gradient: SweepGradient(colors: <Color>[
                          Color.fromARGB(255, 1, 57, 14),
                          Color.fromARGB(255, 0, 250, 29)
                        ], stops: <double>[
                          0.25,
                          0.75
                        ]),
                      ),
                      MarkerPointer(
                        value: punto,
                        color: Colors.white,
                        markerType: MarkerType.circle,
                      ),
                    ]),
              ],
            )),
      ],
    ),
  );
}
