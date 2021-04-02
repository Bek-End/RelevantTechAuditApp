import 'package:rxdart/rxdart.dart';

//a bloc to switch between bottom navbar items

enum SwitchTabEvents {
  MAP,
  MY_OFFICES,
  ADD_OFFICE,
  SETTINGS,
}
enum SwitchTabStates {
  MAP,
  MY_OFFICES,
  ADD_OFFICE,
  SETTINGS,
}

class SwitchTabsBloc {
  final BehaviorSubject<SwitchTabStates> _subject =
      BehaviorSubject<SwitchTabStates>();
  BehaviorSubject<SwitchTabStates> get subject => _subject;

  final defaultState = SwitchTabStates.MAP;
  SwitchTabStates currentState = SwitchTabStates.MAP;

  void mapEventToState(SwitchTabEvents event) {
    switch (event) {
      case SwitchTabEvents.MAP:
        _subject.sink.add(SwitchTabStates.MAP);
        currentState = SwitchTabStates.MAP;
        break;
      case SwitchTabEvents.MY_OFFICES:
        _subject.sink.add(SwitchTabStates.MY_OFFICES);
        currentState = SwitchTabStates.MY_OFFICES;
        break;
      case SwitchTabEvents.ADD_OFFICE:
        _subject.sink.add(SwitchTabStates.ADD_OFFICE);
        currentState = SwitchTabStates.ADD_OFFICE;
        break;
      case SwitchTabEvents.SETTINGS:
        _subject.sink.add(SwitchTabStates.SETTINGS);
        currentState = SwitchTabStates.SETTINGS;
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final switchTabsBloc = SwitchTabsBloc();
