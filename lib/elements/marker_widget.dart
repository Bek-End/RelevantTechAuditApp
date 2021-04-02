import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tech_audit_app/bloc/map_bloc.dart';
import 'package:tech_audit_app/constants/constants.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';
import 'package:tech_audit_app/elements/triangle_clipper.dart';

enum Shapes { CIRCLE, TRIANGLE, SQUARE }

Widget icon(IconData ic, Color color, Shapes shape) {
  return StreamBuilder(
      stream: mapBloc.subject.stream,
      builder: (context, AsyncSnapshot<MapStates> snapshot) {
        if (snapshot.hasData && snapshot.data is MapOnChangeState) {
          MapOnChangeState changeState = snapshot.data;
          return Container(
            height: 10,
            width: 10,
          );
        }
      });
}

class MarkerWidget {
  static Marker getMarker(
      {final Color color,
      final double lat,
      final double lon,
      final PointInfo pointInfo,
      final int type}) {
    Widget icon;
    switch (type) {
      case 0:
        icon = ClipPath(
          clipper: TriangleClipper(),
          child: Container(
            height: 10,
            width: 10,
            color: color,
          ),
        );
        break;
      case 1:
        icon = Container(
          color: color,
          height: 10,
          width: 10,
        );
        break;
      case 2:
        icon = Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          height: 10,
          width: 10,
        );
        break;
    }
    return Marker(
      point: LatLng(lat, lon),
      builder: (ctx) => GestureDetector(
          onTap: () {
            print("tapped");
            mapBloc.mapEventToState(MapOnMarkerTapEvent(pointInfo: pointInfo));
          },
          child: icon),
    );
  }

  static Marker getCluster(
      {int size,
      double lat,
      double lon,
      int greenCount,
      int blueCount,
      int redCount}) {
    Map<String, double> map = {
      "red": redCount.toDouble(),
      "blue": blueCount.toDouble(),
      "green": greenCount.toDouble()
    };
    return Marker(
      point: LatLng(lat, lon),
      builder: (ctx) => InkWell(
        onTap: () {
          print("tapped cluster");
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              child: PieChart(
                animationDuration: Duration(seconds: 0),
                legendOptions: LegendOptions(showLegends: false),
                chartValuesOptions: ChartValuesOptions(showChartValues: false),
                dataMap: map,
                chartRadius: 80,
                chartType: ChartType.ring,
                colorList: [Colors.red, Colors.blue, Colors.green],
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  size.toString(),
                  style: TextStyle(color: ProjectColor.white),
                )),
          ],
        ),
      ),
    );
  }
}
