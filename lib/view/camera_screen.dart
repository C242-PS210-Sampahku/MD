import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/repository/remote/response/history_prediction_response.dart';
import 'package:sampahku_flutter/repository/remote/response/predict_response.dart';
import 'package:sampahku_flutter/view/detail_history_screen.dart';

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
        children: [Expanded(
            child: Center(child:Image.file(File(imagePath)), // Menampilkan gambar
          ),
           ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () =>
                  predictImage(context)
              ,
              child: const Text("Analisa"),
            ),
          ),
        ],
      ),
    );
  }

  void predictImage(context)async{
    ApiService apiService = ApiService();

    PredictResponse response =  await apiService.predictImage(File(imagePath));

    if(response.success){
      Fluttertoast.showToast(msg: "Berhasil memprediksi ${response.data!.prediction.category}");
      _goToDetailHistory(context, response.data);
    }
  }

  void _goToDetailHistory(BuildContext context, PredictionData? data) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DetailHistoryScreen(
                  data: data,
                )));
  }
  
}
