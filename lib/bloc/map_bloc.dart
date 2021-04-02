import 'package:flutter_map/flutter_map.dart';
import 'package:rxdart/rxdart.dart';
import 'package:latlong/latlong.dart';
import 'package:tech_audit_app/bloc/navigator_bloc.dart';
import 'package:tech_audit_app/bloc/point_details_bloc.dart';
import 'package:tech_audit_app/data_structure/point.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';
import 'package:tech_audit_app/data_structure/quad_tree.dart';
import 'package:tech_audit_app/data_structure/region.dart';
import 'package:tech_audit_app/repo/repo.dart';

//events
abstract class MapEvents {}

class MapInitialEvent extends MapEvents {}

class MapOnMarkerTapEvent extends MapEvents {
  final PointInfo pointInfo;
  MapOnMarkerTapEvent({this.pointInfo});
}

class MapOnChangeEvent extends MapEvents {
  final double zoom;
  final LatLngBounds bounds;
  MapOnChangeEvent({this.zoom, this.bounds});
}

//states
abstract class MapStates {}

class MapInitialState extends MapStates {
  final double zoom = 18;
  final LatLng center = LatLng(55.79592, 49.100678);
  final LatLngBounds latLngBounds =
      LatLngBounds(LatLng(55.922140, 48.844792), LatLng(55.669700, 49.356534));
  final List<Point> list;
  MapInitialState({this.list});
}

class MapOnChangeState extends MapStates {
  final double zoom;
  final List<Point> list;
  MapOnChangeState({this.zoom, this.list});
}

//bloc
class MapBloc {
  final BehaviorSubject<MapStates> _subject = BehaviorSubject();
  BehaviorSubject<MapStates> get subject => _subject;
  List<Point> toPass;
  List<QuadTree> quadTrees;
  int count = 0;
  void mapEventToState(MapEvents event) async {
    switch (event.runtimeType) {
      case MapInitialEvent:
        toPass = [];
        quadTrees = await repo.getPoints();
        MapInitialState initialState = MapInitialState();
        Region searchRegion = Region(
          initialState.latLngBounds.southEast.latitude,
          initialState.latLngBounds.northWest.longitude,
          initialState.latLngBounds.northWest.latitude,
          initialState.latLngBounds.southEast.longitude,
        );
        toPass = quadTrees[0].search(searchRegion, []);
        _subject.sink.add(MapInitialState(list: toPass));
        break;
      case MapOnChangeEvent:
        toPass = [];
        MapOnChangeEvent changeEvent = event;
        Region searchRegion = Region(
          changeEvent.bounds.southEast.latitude,
          changeEvent.bounds.northWest.longitude,
          changeEvent.bounds.northWest.latitude,
          changeEvent.bounds.southEast.longitude,
        );
        QuadTree quad = quadTrees[18 - changeEvent.zoom.floor()];
        toPass = quad.search(searchRegion, []);
        _subject.sink
            .add(MapOnChangeState(zoom: changeEvent.zoom, list: toPass));
        break;
      case MapOnMarkerTapEvent:
        print("bloc tap");
        MapOnMarkerTapEvent tapEvent = event;
        pointDetailsBloc.mapEventToState(
            PointDetailsInitialEvent(pointInfo: tapEvent.pointInfo));
        navigatorBloc.mapEventToState(NavigatorDetailsEvent());
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final mapBloc = MapBloc();
