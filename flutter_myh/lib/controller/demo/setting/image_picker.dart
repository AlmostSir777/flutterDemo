import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_flutter/image_picker_flutter.dart';

class ImagePickerDemoPage extends StatefulWidget {
  @override
  _ImagePickerDemoPageState createState() => _ImagePickerDemoPageState();
}

class _ImagePickerDemoPageState extends State<ImagePickerDemoPage> {
  AssetData _assetData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片选择'),
      ),
      body: Container(
        alignment: Alignment(0, 0),
        child: FlatButton(
            onPressed: () {
              _pickImage();
            },
            child: _assetData == null
                ? Text('选择图片')
                : Image.file(File(
                    _assetData.path,
                  ))),
      ),
    );
  }

  void _pickImage() async {
    // ImagePicker.mulPicker(
    //   context,
    //   mulCallback: (List<AssetData> images) {
    //     print(images);
    //   },
    // );
    ImagePicker.singlePicker(
      context,
      singleCallback: (AssetData image) {
        setState(() {
          _assetData = image;
        });
      },
    );
  }
}
