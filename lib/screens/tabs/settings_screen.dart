import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text("Settings"),
          onTap: () async{
            final imagePicker = ImagePicker();
            await imagePicker.getImage(source: ImageSource.camera);
          },
        ),
      ),
    );
  }
}
