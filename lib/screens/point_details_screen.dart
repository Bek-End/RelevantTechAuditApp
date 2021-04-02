import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_audit_app/bloc/navigator_bloc.dart';
import 'package:tech_audit_app/bloc/point_details_bloc.dart';
import 'package:tech_audit_app/constants/constants.dart';
import 'package:tech_audit_app/data_structure/point_info.dart';
import 'camera/camera.dart';

int imageCount;
PointInfo pinModel;
final picker = ImagePicker();

class PointDetailsScreen extends StatelessWidget {
  static final routeName = "/point_details";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        navigatorBloc.mapEventToState(NavigatorPopEvent());
      },
      child: StreamBuilder(
          stream: pointDetailsBloc.subject.stream,
          builder: (context, AsyncSnapshot<PointDetailsStates> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.runtimeType) {
                case PointDetailsInitialState:
                  PointDetailsInitialState initialState = snapshot.data;
                  pinModel = initialState.pointInfo;
                  imageCount = initialState.count;
                  break;
                case PointDetailsCameraState:
                  PointDetailsCameraState cameraState = snapshot.data;
                  imageCount = cameraState.imageCount;
                  break;
              }
              return Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                appBar: AppBar(
                  title: Text(pinModel.uid),
                  centerTitle: true,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back_sharp),
                      onPressed: () {
                        navigatorBloc.mapEventToState(NavigatorPopEvent());
                      }),
                  actions: [
                    IconButton(icon: Icon(Icons.clear), onPressed: () {})
                  ],
                ),
                body: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Характеристики",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text("Не введены"),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Фото: "),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  pointDetailsBloc.mapEventToState(
                                      PointDetailsOnCountTap());
                                },
                                child: Text(
                                  imageCount.toString(),
                                  style: TextStyle(
                                      color: ProjectColor.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 20, right: 20),
                              decoration: BoxDecoration(
                                  color: ProjectColor.lightGrey,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ProjectColor.darkGrey, width: 1)),
                              child: Text("Удалить"),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Видео: "),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  pointDetailsBloc.mapEventToState(
                                      PointDetailsOnVideoShowEvent());
                                },
                                child: Text(
                                  "2:01 (7мб), 10% ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ProjectColor.blue),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 20, right: 20),
                              decoration: BoxDecoration(
                                  color: ProjectColor.lightGrey,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ProjectColor.darkGrey, width: 1)),
                              child: Text("Удалить"),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Комментарий",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Нет"),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: ProjectColor.lightGrey,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: ProjectColor.darkGrey, width: 1)),
                          child: Text("Редактировать"),
                        ),
                      )
                    ],
                  ),
                ),
                floatingActionButton: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                        heroTag: 'btn1',
                        backgroundColor: ProjectColor.orange,
                        child: const Icon(Icons.camera_alt_rounded),
                        onPressed: () async {
                          // final picker = ImagePicker();
                          // final file =
                          //     await picker.getImage(source: ImageSource.camera);
                          // pointDetailsBloc.mapEventToState(
                          //     PointDetailsCameraTapEvent(file: file));
                          Navigator.pushNamed(context, CameraScreen.routeName);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                        heroTag: "btn2",
                        backgroundColor: ProjectColor.orange,
                        child: const Icon(Icons.videocam),
                        onPressed: () async {
                          final picker = ImagePicker();
                          final file =
                              await picker.getVideo(source: ImageSource.camera);
                          pointDetailsBloc.mapEventToState(
                              PointDetailsVideoTapEvent(file: file));
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                        heroTag: "btn3",
                        backgroundColor: ProjectColor.orange,
                        child: const Icon(Icons.list_alt_outlined),
                        onPressed: () async {
                          final file = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          pointDetailsBloc.mapEventToState(
                              PointDetailsGalleryTapEvent(file: file));
                        })
                  ],
                ),
              );
            } else {
              return Scaffold(
                body: Container(),
              );
            }
          }),
    );
  }
}
