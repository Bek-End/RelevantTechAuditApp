import 'dart:core';
import 'package:tech_audit_app/data_structure/point.dart';
import 'package:tech_audit_app/data_structure/region.dart';

class QuadTree {
  static const int MAX_POINTS = 5;
  Region area;
  List<Point> points = [];
  List<QuadTree> quadTrees = [];

  QuadTree(Region area) {
    this.area = area;
  }

  bool addPoint(Point point) {
    if (this.area.containsPoint(point)) {
      if (this.points.length < MAX_POINTS) {
        this.points.add(point);
        return true;
      } else {
        if (this.quadTrees.length == 0) {
          createQuadrants();
        }
        return addPointToOneQuadrant(point);
      }
    }
    return false;
  }

  bool addPointToOneQuadrant(Point point) {
    bool isPointAdded;
    for (int i = 0; i < 4; i++) {
      isPointAdded = this.quadTrees[i].addPoint(point);
      if (isPointAdded) return true;
    }
    return false;
  }

  void createQuadrants() {// we create four children for the given parent quad
    Region region;
    for (int i = 0; i < 4; i++) {
      region = this.area.getQuadrant(MapSides.values[i]);
      quadTrees.add(new QuadTree(region));
    }
  }

  List<Point> search(Region searchRegion, List<Point> matches) {
    if (matches == null) {
      matches = [];
    }
    if (!this.area.doesOverlap(searchRegion)) {
      return matches;
    } else {
      for (Point point in this.points) {
        if (searchRegion.containsPoint(point)) {
          matches.add(point);
        }
      }
      if (this.quadTrees.length > 0) {
        for (int i = 0; i < 4; i++) {
          quadTrees[i].search(searchRegion, matches);
        }
      }
    }
    return matches;
  }
}
