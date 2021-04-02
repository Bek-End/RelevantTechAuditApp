import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:tech_audit_app/data_structure/cluster.dart';
import 'package:tech_audit_app/data_structure/point.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';
import 'package:tech_audit_app/data_structure/point_map.dart';
import 'package:tech_audit_app/data_structure/quad_tree.dart';
import 'package:tech_audit_app/data_structure/region.dart';
import 'package:tech_audit_app/elements/marker_widget.dart';
import 'package:tech_audit_app/elements/random_value.dart';
import 'package:tech_audit_app/models/location_pin_model.dart';

const double addToY = 0.000242544;
const double coefficient = 0.0002425452;
const double radian = 0.0174444444;
double xCoefficient = 0.0002977344;
double yCoefficient = 0.0004997461;
//kazan coordinates
const double topLeftLongitue = 55.669700;
const double topLeftLatitude = 48.844792;
const double bottomRightLongitude = 55.822140;
const double bottomRightLatitude = 49.100662;

int sum = 0;

List<List<LocationPinModel>> listOfLists;

class Repo {
  final String mainURL = "here we add main url";
  Dio _dio;

  Repo() {
    this._dio = Dio(BaseOptions(baseUrl: mainURL));
  }

  Future<List<QuadTree>> getPoints() async {
    List<QuadTree> quadList = []; //we have markers under index 0
    quadList.add(QuadTree(Region(-180, -90, 180, 90)));
    for (double j = topLeftLongitue; j < bottomRightLongitude; j += addToY) {
      for (double k = topLeftLatitude;
          k < bottomRightLatitude;
          k += (coefficient / cos(radian * j))) {
        LocationPinModel pinModel = LocationPinModel(
            id: DateTime.now().microsecondsSinceEpoch,
            uid: randValue.getRandomString(5),
            typ: randValue.getRandomInt(),
            c: randValue.getRandColor(),
            tou: j.toInt() % 10,
            deleted: false,
            loc: [j, k]);
        sum++;
        PointInfo pointInfo = PointInfo(
            uid: pinModel.uid,
            typ: pinModel.typ,
            c: pinModel.c,
            tou: pinModel.tou,
            deleted: pinModel.deleted);
        Marker marker = MarkerWidget.getMarker(
            color: pointInfo.c,
            lat: pinModel.loc[0],
            lon: pinModel.loc[1],
            type: pointInfo.typ,
            pointInfo: pointInfo);
        Point point = Point(
            x: pinModel.loc[0],
            y: pinModel.loc[1],
            id: pinModel.id,
            marker: marker);
        pointMap.addItem(point: point, pointInfo: pointInfo);
        quadList[0].addPoint(point);
      }
    }
    List clusters;
    int blueSum = 0, greenSum = 0, redSum = 0;
    for (int i = 1; i < 8; i++) {
      double averageX, averageY, tempXSum = 0, tempYSum = 0;
      int sum = 0;
      QuadTree quadTree = QuadTree(Region(-180, -90, 180, 90));
      quadList.add(quadTree);
      for (double j = topLeftLongitue;
          j < bottomRightLongitude;
          j += xCoefficient) {
        for (double k = topLeftLatitude;
            k < bottomRightLatitude;
            k += yCoefficient) {
          Region region = Region(j, k, j + xCoefficient, k + yCoefficient);
          clusters = quadList[i - 1].search(region, []);
          if (clusters.length > 0) {
            if (i == 1) {
              clusters.forEach((element) {
                tempXSum += element.x;
                tempYSum += element.y;
                if (pointMap.searchByPoint(element.id).c == Colors.blue) {
                  blueSum++;
                }
                if (pointMap.searchByPoint(element.id).c == Colors.green) {
                  greenSum++;
                }
                if (pointMap.searchByPoint(element.id).c == Colors.red) {
                  redSum++;
                }
              });
              sum = clusters.length;
            } else {
              clusters.forEach((element) {
                tempXSum += element.x;
                tempYSum += element.y;
                sum += element.count;
                blueSum += element.blueCount;
                redSum += element.redCount;
                greenSum += element.greenCount;
              });
            }
            averageX = tempXSum / (clusters.length);
            averageY = tempYSum / (clusters.length);
            Marker marker = MarkerWidget.getCluster(
                size: sum,
                lat: averageX,
                lon: averageY,
                greenCount: greenSum,
                blueCount: blueSum,
                redCount: redSum);
            Cluster point = Cluster(
                count: sum,
                x: averageX,
                y: averageY,
                marker: marker,
                blueCount: blueSum,
                redCount: redSum,
                greenCount: greenSum);
            quadList[i].addPoint(point);
            clusters.clear();
            blueSum = 0;
            greenSum = 0;
            redSum = 0;
            tempXSum = 0;
            tempYSum = 0;
            sum = 0;
          }
        }
      }
      xCoefficient *= 2;
      yCoefficient *= 2;
    }
    return quadList;
  }
}

final repo = Repo();
