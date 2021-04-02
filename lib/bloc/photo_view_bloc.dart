import 'dart:io';

import 'package:rxdart/rxdart.dart';

abstract class PhotoViewEvents {}

class PhotoViewInitialEvent extends PhotoViewEvents {
  final List<File> images;
  PhotoViewInitialEvent({this.images});
}

abstract class PhotoViewStates {}

class PhotoViewInitialState extends PhotoViewStates {
  final List<File> images;
  PhotoViewInitialState({this.images});
}

class PhotoViewBloc {
  BehaviorSubject<PhotoViewStates> _subject = BehaviorSubject();
  BehaviorSubject<PhotoViewStates> get subject => _subject;

  void mapEventToState(PhotoViewEvents event) {
    switch (event.runtimeType) {
      case PhotoViewInitialEvent:
        PhotoViewInitialEvent initialEvent = event;
        _subject.sink.add(PhotoViewInitialState(images: initialEvent.images));
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final photoViewBloc = PhotoViewBloc();
