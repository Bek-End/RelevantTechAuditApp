
import 'package:tech_audit_app/data_structure/point.dart';

enum MapSides { SW, NW, NE, SE }

class Region {
  //top-left point 
  double x1;
  double y1;
  //bottom-right point
  double x2;
  double y2;

  Region(double x1, double y1, double x2, double y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  Region getQuadrant(MapSides mapSide) {
    double quadrantWidth = (this.x2 - this.x1) / 2;
    double quadrantHeight = (this.y2 - this.y1) / 2;

    // 0=SW, 1=NW, 2=NE, 3=SE
    switch (mapSide) {
      case MapSides.SW:
        return new Region(x1, y1, x1 + quadrantWidth, y1 + quadrantHeight);
      case MapSides.NW:
        return new Region(x1, y1 + quadrantHeight, x1 + quadrantWidth, y2);
      case MapSides.NE:
        return new Region(x1 + quadrantWidth, y1 + quadrantHeight, x2, y2);
      case MapSides.SE:
        return new Region(x1 + quadrantWidth, y1, x2, y1 + quadrantHeight);
    }
    return null;
  }

  bool containsPoint(Point point) {
    // Consider left and top side to be inclusive for points on border
    return point.x >= this.x1 &&
        point.x < this.x2 &&
        point.y >= this.y1 &&
        point.y < this.y2;
  }

  bool doesOverlap(Region testRegion) {
    // Is test region completely to left of my region?
    if (testRegion.getX2() < this.getX1()) {
      return false;
    }
    // Is test region completely to right of my region?
    if (testRegion.getX1() > this.getX2()) {
      return false;
    }
    // Is test region completely above my region?
    if (testRegion.getY1() > this.getY2()) {
      return false;
    }
    // Is test region completely below my region?
    if (testRegion.getY2() < this.getY1()) {
      return false;
    }
    return true;
  }

  String toString() {
    return "[Region (x1=" +
        x1.toString() +
        ", y1=" +
        y1.toString() +
        "), (x2=" +
        x2.toString() +
        ", y2=" +
        y2.toString() +
        ")]";
  }

  double getX1() {
    return x1;
  }

  double getY1() {
    return y1;
  }

  double getX2() {
    return x2;
  }

  double getY2() {
    return y2;
  }
}
