import 'package:flutter/material.dart';
import 'package:tech_audit_app/bloc/video_view_bloc.dart';
import 'package:tech_audit_app/constants/constants.dart';

class VideoViewScreen extends StatelessWidget {
  static final routeName = "/video_view";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColor.black,
      body: StreamBuilder(
          stream: videoViewBloc.subject.stream,
          builder: (context, AsyncSnapshot<VideoViewStates> snapshot) {
            if (snapshot.hasData) {
              VideoViewInitialState initialState = snapshot.data;
              return Center(
                child: initialState.videoWidget,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
