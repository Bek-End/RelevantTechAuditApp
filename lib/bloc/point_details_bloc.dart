import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_audit_app/bloc/navigator_bloc.dart';
import 'package:tech_audit_app/bloc/photo_view_bloc.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';
import 'package:video_player/video_player.dart';
import 'video_view_bloc.dart';
export '';

//events
abstract class PointDetailsEvents {}

class PointDetailsInitialEvent extends PointDetailsEvents {
  final PointInfo pointInfo;
  PointDetailsInitialEvent({this.pointInfo});
}

class PointDetailsOnCountTap extends PointDetailsEvents {}

class PointDetailsGalleryTapEvent extends PointDetailsEvents {
  final PickedFile file;
  PointDetailsGalleryTapEvent({this.file});
}

class PointDetailsCameraTapEvent extends PointDetailsEvents {
  final File file;
  PointDetailsCameraTapEvent({this.file});
}

class PointDetailsVideoTapEvent extends PointDetailsEvents {
  final PickedFile file;
  PointDetailsVideoTapEvent({this.file});
}

class PointDetailsOnVideoShowEvent extends PointDetailsEvents {}

//states
abstract class PointDetailsStates {}

class PointDetailsInitialState extends PointDetailsStates {
  final PointInfo pointInfo;
  final int count;
  PointDetailsInitialState({this.pointInfo, this.count});
}

class PointDetailsCameraState extends PointDetailsStates {
  final int imageCount;
  PointDetailsCameraState({this.imageCount});
}

class PointDetailsBloc {
  final BehaviorSubject<PointDetailsStates> _subject = BehaviorSubject();
  BehaviorSubject<PointDetailsStates> get subject => _subject;
  int imageCount = 0;
  List<File> images = [];
  Chewie video;
  ChewieController controller;
  VideoPlayerController videoPlayer;

  void mapEventToState(PointDetailsEvents event) async {
    switch (event.runtimeType) {
      case PointDetailsInitialEvent:
        PointDetailsInitialEvent initialEvent = event;
        _subject.sink.add(PointDetailsInitialState(
            pointInfo: initialEvent.pointInfo, count: imageCount));
        break;
      case PointDetailsGalleryTapEvent:
        PointDetailsGalleryTapEvent tapEvent = event;
        images.add(File(tapEvent.file.path));
        imageCount++;
        _subject.sink.add(PointDetailsCameraState(imageCount: imageCount));
        break;
      case PointDetailsCameraTapEvent:
        PointDetailsCameraTapEvent tapEvent = event;
        images.add(tapEvent.file);
        imageCount++;
        _subject.sink.add(PointDetailsCameraState(imageCount: imageCount));
        break;
      case PointDetailsVideoTapEvent:
        PointDetailsVideoTapEvent tapEvent = event;
        videoPlayer = VideoPlayerController.file(File(tapEvent.file.path));
        await videoPlayer.initialize();
        controller = ChewieController(
          videoPlayerController: videoPlayer,
        );
        video = Chewie(
          controller: controller,
        );
        break;
      case PointDetailsOnVideoShowEvent:
        videoViewBloc
            .mapEventToState(VideoViewInitialEvent(videoWidget: video));
        navigatorBloc.mapEventToState(NavigatorVideoViewEvent());
        break;
      case PointDetailsOnCountTap:
        photoViewBloc.mapEventToState(PhotoViewInitialEvent(images: images));
        navigatorBloc.mapEventToState(NavigatorPhotoViewEvent());
        break;
    }
  }

  void dispose() => _subject?.close();
}

final pointDetailsBloc = PointDetailsBloc();
