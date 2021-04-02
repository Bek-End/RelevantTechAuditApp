import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:tech_audit_app/bloc/map_bloc.dart';
import 'package:tech_audit_app/constants/constants.dart';
import 'package:tech_audit_app/data_structure/point.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';
import 'package:tech_audit_app/data_structure/point_map.dart';
import 'package:tech_audit_app/elements/loading_widget.dart';
import 'package:tech_audit_app/elements/marker_widget.dart';

double zoom;
LatLng center;
List<Marker> markers;
CenterOnLocationUpdate _centerOnLocationUpdate;
StreamController<double> _centerCurrentLocationStreamController;
MapController mapController = MapController();

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    mapBloc.mapEventToState(MapInitialEvent());
    _centerCurrentLocationStreamController = StreamController<double>();
    _centerOnLocationUpdate = CenterOnLocationUpdate.never;
  }

  @override
  Widget build(BuildContext ctxt) {
    Size _size = MediaQuery.of(ctxt).size;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        child: StreamBuilder(
            stream: mapBloc.subject.stream,
            builder: (context, AsyncSnapshot<MapStates> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.runtimeType) {
                  case MapInitialState:
                    MapInitialState initialState = snapshot.data;
                    zoom = initialState.zoom;
                    center = initialState.center;
                    if (zoom >= 18) {
                      markers = buildMarkers(initialState.list);
                    } else {
                      markers = initialState.list;
                    }
                    break;
                  case MapOnChangeState:
                    MapOnChangeState onChangeState = snapshot.data;
                    zoom = onChangeState.zoom;
                    if (zoom >= 18) {
                      markers = buildMarkers(onChangeState.list);
                    } else {
                      markers = onChangeState.list;
                    }
                    break;
                }
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: new MapOptions(
                        center: center,
                        zoom: zoom,
                        onPositionChanged: (position, hasGesture) {
                          mapBloc.mapEventToState(MapOnChangeEvent(
                              bounds: position.bounds, zoom: position.zoom));
                          if (hasGesture) {
                            setState(() => _centerOnLocationUpdate =
                                CenterOnLocationUpdate.never);
                          }
                        },
                        plugins: [
                          MarkerClusterPlugin(),
                          LocationMarkerPlugin(
                            centerCurrentLocationStream:
                                _centerCurrentLocationStreamController.stream,
                            centerOnLocationUpdate: _centerOnLocationUpdate,
                          )
                        ],
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        LocationMarkerLayerOptions(),
                        MarkerLayerOptions(markers: markers),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            color: ProjectColor.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                zoom.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          FloatingActionButton(
                              backgroundColor: ProjectColor.white,
                              mini: true,
                              heroTag: "button1",
                              child: Icon(
                                Icons.explore_outlined,
                                color: ProjectColor.black,
                              ),
                              onPressed: () {
                                mapController.rotate(0);
                              }),
                          FloatingActionButton(
                            heroTag: "button2",
                            mini: true,
                            onPressed: () {
                              setState(() => _centerOnLocationUpdate =
                                  CenterOnLocationUpdate.always);
                              _centerCurrentLocationStreamController.add(18);
                            },
                            child: Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: loading,
                );
              }
            }),
      ),
    );
  }
}

List<Marker> buildMarkers(List<Point> points) {
  List<Marker> markers = [];
  points.forEach((element) {
    PointInfo info = pointMap.searchByPoint(element.id);
    Marker marker = MarkerWidget.getMarker(
        color: info.c,
        pointInfo: info,
        lat: element.x,
        lon: element.y,
        type: info.typ);
    markers.add(marker);
  });
  return markers;
}
