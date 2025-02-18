import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/rendering.dart';

class PhotoApp extends StatefulWidget {
  const PhotoApp({super.key});

  @override
  _PhotoAppState createState() => _PhotoAppState();
}

class _PhotoAppState extends State<PhotoApp> {
  File? _image;
  final GlobalKey _globalKey = GlobalKey();
  bool _showPiglet = false;
  Offset _pigletPosition = const Offset(150, 300);

  @override
  void initState() {
    super.initState();
    _requestStoragePermission();
  }

  // Запрос разрешения на запись в хранилище
  Future<void> _requestStoragePermission() async {
    if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    }
  }

  // Сделать фото с камеры
  Future<void> _takePhoto() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Сохранить фото на устройство
  Future<void> _savePhoto() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Получаем путь к папке "Загрузки"
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath =
          '${directory.path}/saved_photo_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Фото сохранено в Загрузки: $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка при сохранении фото')),
      );
    }
  }

  // Поделиться фото
  Future<void> _sharePhoto() async {
    if (_image != null) {
      await Share.shareFiles([_image!.path], text: 'Мое фото!');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Сначала сделайте фото!')));
    }
  }

  // Перемещение Пятачка
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _pigletPosition = Offset(
        _pigletPosition.dx + details.delta.dx,
        _pigletPosition.dy + details.delta.dy,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фото и Пятачок'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: Stack(
                      children: [
                        Container(
                          width: 300,
                          height: 400,
                          color: Colors.grey[300],
                          child:
                              _image != null
                                  ? Image.file(_image!, fit: BoxFit.cover)
                                  : const Center(
                                    child: Text('Здесь будет фото'),
                                  ),
                        ),
                        if (_showPiglet)
                          Positioned(
                            left: _pigletPosition.dx,
                            top: _pigletPosition.dy,
                            child: GestureDetector(
                              onPanUpdate: _onPanUpdate,
                              child: Image.asset(
                                'assets/images/piglet.png',
                                width: 80,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _takePhoto,
                      child: const Text('📸 Сделать фото'),
                    ),
                    ElevatedButton(
                      onPressed: _savePhoto,
                      child: const Text('💾 Сохранить'),
                    ),
                    ElevatedButton(
                      onPressed: _sharePhoto,
                      child: const Text('📤 Поделиться'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Кнопка Пятачка всегда наверху
          Positioned(
            bottom: 75,
            left:
                MediaQuery.of(context).size.width / 2 - 28, // Центрируем кнопку
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showPiglet = !_showPiglet;
                });
              },
              child: const Icon(Icons.pets),
            ),
          ),
        ],
      ),
    );
  }
}
