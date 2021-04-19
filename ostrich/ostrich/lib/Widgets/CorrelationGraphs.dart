/// Dart imports
import 'dart:math';
import 'dart:ui';

/// Package imports
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local import

/// Renders customized line chart
class CustomizedLine extends StatefulWidget {
  /// Creates customized line chart sample
  const CustomizedLine(Key key) : super(key: key);

  @override
  _LineDefaultState createState() => _LineDefaultState();
}

late List<num> _xValues;
late List<num> _yValues;
List<double> _xPointValues = <double>[];
List<double> _yPointValues = <double>[];

class _LineDefaultState extends State<StatefulWidget> {
  _LineDefaultState();

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomizedLineChart();
  }

  ///Get the cartesian chart
  SfCartesianChart _buildCustomizedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          textStyle: TextStyle(color: Colors.white),
          text: 'Club Value Over Time'),
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        dateFormat: DateFormat.yMMM(),
        labelStyle: TextStyle(color:Colors.white),
        intervalType: DateTimeIntervalType.months,
        interval: 1,
      ),
      primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.currency(locale: 'en-US', symbol: '\$'),
          labelFormat: '{value}',
          labelStyle: TextStyle(color:Colors.white),
          minimum: 1000,
          maximum: 48000,
          interval: 10000,
          majorGridLines: MajorGridLines(color: Colors.transparent)),
      series: <ChartSeries<_ChartData, DateTime>>[
        LineSeries<_ChartData, DateTime>(
            onCreateRenderer: (ChartSeries<dynamic, dynamic> series) {
              return _CustomLineSeriesRenderer(series as LineSeries);
            },
            animationDuration: 2500,
            dataSource: <_ChartData>[
              _ChartData(DateTime(2021, 3, 31).subtract(Duration(days:7*4)), 1000),
              _ChartData(DateTime(2021, 4, 7).subtract(Duration(days:7*4)), 1050),
              _ChartData(DateTime(2021, 4, 14).subtract(Duration(days:7*4)), 1250),
              _ChartData(DateTime(2021, 4, 21).subtract(Duration(days:7*4)), 1400),
              _ChartData(DateTime(2021, 4, 28).subtract(Duration(days:7*4)), 11550),
              _ChartData(DateTime(2021, 5, 5).subtract(Duration(days:7*4)), 17240),
              _ChartData(DateTime(2021, 5, 12).subtract(Duration(days:7*4)), 38861),
              _ChartData(DateTime(2021, 5, 12).subtract(Duration(days:7*4)), 41861),
            ],
            xValueMapper: (_ChartData sales, _) => sales.x,
            yValueMapper: (_ChartData sales, _) => sales.y,
            width: 2,
            markerSettings: MarkerSettings(isVisible: true)),
      ],
      tooltipBehavior: _tooltipBehavior,
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}

class _CustomLineSeriesRenderer extends LineSeriesRenderer {
  _CustomLineSeriesRenderer(this.series);

  final LineSeries<dynamic, dynamic> series;
  static Random randomNumber = Random();

  @override
  LineSegment createSegment() {
    return _LineCustomPainter(randomNumber.nextInt(4), series);
  }
}

class _LineCustomPainter extends LineSegment {
  _LineCustomPainter(int value, this.series) {
    //ignore: prefer_initializing_formals
    index = value;
    _xValues = <num>[];
    _yValues = <num>[];
  }

  final LineSeries<dynamic, dynamic> series;
  late double maximum, minimum;
  late int index;
  List<Color> colors = <Color>[
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyan
  ];

  @override
  Paint getStrokePaint() {
    final Paint customerStrokePaint = Paint();
    customerStrokePaint.color = const Color.fromRGBO(53, 92, 125, 1);
    customerStrokePaint.strokeWidth = 2;
    customerStrokePaint.style = PaintingStyle.stroke;
    return customerStrokePaint;
  }

  void _storeValues() {
    _xPointValues.add(points[0].dx);
    _xPointValues.add(points[1].dx);
    _yPointValues.add(points[0].dy);
    _yPointValues.add(points[1].dy);
    _xValues.add(points[0].dx);
    _xValues.add(points[1].dx);
    _yValues.add(points[0].dy);
    _yValues.add(points[1].dy);
  }

  @override
  void onPaint(Canvas canvas) {
    final double x1 = points[0].dx,
        y1 = points[0].dy,
        x2 = points[1].dx,
        y2 = points[1].dy;
    _storeValues();
    final Path path = Path();
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    canvas.drawPath(path, getStrokePaint());

    if (currentSegmentIndex == series.dataSource.length - 2) {
      const double labelPadding = 10;
      final Paint topLinePaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final Paint bottomLinePaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      maximum = _yPointValues.reduce(max);
      minimum = _yPointValues.reduce(min);
      final Path bottomLinePath = Path();
      final Path topLinePath = Path();
      bottomLinePath.moveTo(_xPointValues[0], maximum);
      bottomLinePath.lineTo(_xPointValues[_xPointValues.length - 1], maximum);

      topLinePath.moveTo(_xPointValues[0], minimum);
      topLinePath.lineTo(_xPointValues[_xPointValues.length - 1], minimum);
      canvas.drawPath(
          _dashPath(
            bottomLinePath,
            dashArray: _CircularIntervalList<double>(<double>[15, 3, 3, 3]),
          )!,
          bottomLinePaint);

      canvas.drawPath(
          _dashPath(
            topLinePath,
            dashArray: _CircularIntervalList<double>(<double>[15, 3, 3, 3]),
          )!,
          topLinePaint);

      final TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.red[800], fontSize: 12.0, fontFamily: 'Roboto'),
        text: 'Low point',
      );
      final TextPainter tp =
          TextPainter(text: span, textDirection: prefix0.TextDirection.ltr);
      tp.layout();
      tp.paint(
          canvas,
          Offset(
              _xPointValues[_xPointValues.length - 4], maximum + labelPadding));
      final TextSpan span1 = TextSpan(
        style: TextStyle(
            color: Colors.green[800], fontSize: 12.0, fontFamily: 'Roboto'),
        text: 'High point',
      );
      final TextPainter tp1 =
          TextPainter(text: span1, textDirection: prefix0.TextDirection.ltr);
      tp1.layout();
      tp1.paint(
          canvas,
          Offset(_xPointValues[0] + labelPadding / 2,
              minimum - labelPadding - tp1.size.height));
      _yValues.clear();
      _yPointValues.clear();
    }
  }
}

Path? _dashPath(
  Path source, {
  required _CircularIntervalList<double> dashArray,
}) {
  if (source == null) {
    return null;
  }
  const double intialValue = 0.0;
  final Path path = Path();
  for (final PathMetric measurePath in source.computeMetrics()) {
    double distance = intialValue;
    bool draw = true;
    while (distance < measurePath.length) {
      final double length = dashArray.next;
      if (draw) {
        path.addPath(
            measurePath.extractPath(distance, distance + length), Offset.zero);
      }
      distance += length;
      draw = !draw;
    }
  }
  return path;
}

class _CircularIntervalList<T> {
  _CircularIntervalList(this._values);

  final List<T> _values;
  int _index = 0;

  T get next {
    if (_index >= _values.length) {
      _index = 0;
    }
    return _values[_index++];
  }
}
