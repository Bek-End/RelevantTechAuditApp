import 'package:flutter/material.dart';

class LocationPinModel {
  int id;
  String uid;
  int typ;
  List<double> loc;
  Color c;
  int tou;
  bool deleted;

  LocationPinModel(
      {this.id, this.uid, this.typ, this.loc, this.c, this.tou, this.deleted});

  LocationPinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    typ = json['typ'];
    loc = json['loc'].cast<double>();
    c = Color(int.parse(json['c'], radix: 16));
    tou = json['tou'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['typ'] = this.typ;
    data['loc'] = this.loc;
    data['c'] = this.c;
    data['tou'] = this.tou;
    data['deleted'] = this.deleted;
    return data;
  }
}