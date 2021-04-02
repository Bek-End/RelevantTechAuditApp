import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class VideoViewEvents {}

class VideoViewInitialEvent extends VideoViewEvents {
  final Widget videoWidget;
  VideoViewInitialEvent({this.videoWidget});
}

abstract class VideoViewStates {}

class VideoViewInitialState extends VideoViewStates {
  final Widget videoWidget;
  VideoViewInitialState({this.videoWidget});
}

class VideoViewBloc {
  BehaviorSubject<VideoViewStates> _subject = BehaviorSubject();
  BehaviorSubject<VideoViewStates> get subject => _subject;

  void mapEventToState(VideoViewEvents event) {
    switch (event.runtimeType) {
      case VideoViewInitialEvent:
        VideoViewInitialEvent initialEvent = event;
        _subject.sink
            .add(VideoViewInitialState(videoWidget: initialEvent.videoWidget));
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final videoViewBloc = VideoViewBloc();
