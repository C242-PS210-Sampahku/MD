import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampahku_flutter/color/app_color.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  bool isTakingAPicture = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _takePhoto();
          },
          shape: CircleBorder(),
          backgroundColor: AppColor.captureButtonColor,
          child: Icon(Icons.camera_alt, color: Colors.white,),
        ),
        body: _initializeControllerFuture != null
            ? FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_controller.value.isInitialized) {
                      return CameraPreview(_controller);
                    } else {
                      return Center(child: Text('Kamera tidak tersedia.'));
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Terjadi kesalahan: ${snapshot.error}'));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        Fluttertoast.showToast(msg: "Terjadi kesalahan.");
        return;
      }

      _controller = CameraController(cameras.first, ResolutionPreset.high);

      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: "Terjadi kesalahan :$e");
    }
  }

  Future<void> _takePhoto() async {
    try {
      if (isTakingAPicture) {
        return;
      }
      if (!_controller.value.isInitialized) {
        Fluttertoast.showToast(msg: "Kamera belum siap.");
        return;
      }

      setState(() {
        isTakingAPicture = true;
      });
      final XFile photo = await _controller.takePicture();

      Fluttertoast.showToast(msg: "Photo berhasil disimpan.");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PicturePreviewScreen(
                    imagePath: photo.path,
                  )));
    } catch (e) {
      Fluttertoast.showToast(msg: "Terjadi kesalahan :$e");
    } finally {
      setState(() {
        isTakingAPicture = false;
      });
    }
  }
}

class PicturePreviewScreen extends StatelessWidget {
  final String imagePath;

  const PicturePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Gambar")),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)), // Menampilkan gambar
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Kembali"),
            ),
          ),
        ],
      ),
    );
  }
}
