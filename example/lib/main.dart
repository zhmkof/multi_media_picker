// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_media_picker/multi_media_picker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker Demo',
      home: new MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _imgs;
  bool isVideo = false;
  VoidCallback listener;

  _onImageButtonPressed(ImageSource source, {bool singleImage = false}) async {
    var imgs;
    if(!isVideo){
      imgs = await MultiMediaPicker.pickImages(source: source, singleImage: singleImage);
    }
    setState(() {
      if (isVideo) {
      } else {
        _imgs = imgs;
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  Widget _previewImages() {
    if(_imgs == null){
      return Text('No images selected.');
    } else {
      return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _imgs.map((File img) {
            return GridTile(
                child: Image.file(img, fit: BoxFit.contain));
          }).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: isVideo ? null : _previewImages(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              isVideo = false;
              _onImageButtonPressed(ImageSource.gallery, singleImage: true);
            },
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: Icon(Icons.photo_library),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'image1',
              tooltip: 'Pick Images from gallery',
              child: Icon(Icons.photo_album),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: Icon(Icons.videocam),
            ),
          ),
        ],
      ),
    );
  }
}
