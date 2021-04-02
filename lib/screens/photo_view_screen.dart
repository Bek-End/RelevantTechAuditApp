import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tech_audit_app/bloc/photo_view_bloc.dart';

List<File> images;

class PhotoViewScreen extends StatelessWidget {
  static final routeName = "/photo_view";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: photoViewBloc.subject.stream,
        builder: (context, AsyncSnapshot<PhotoViewStates> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.runtimeType) {
              case PhotoViewInitialState:
                PhotoViewInitialState initialState = snapshot.data;
                images = initialState.images;
                break;
            }
            return Scaffold(
              body: Container(
                  child: PhotoViewGallery.builder(
                      itemCount: images.length,
                      builder: (context, i) => PhotoViewGalleryPageOptions(
                          imageProvider: FileImage(images[i])))),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}
