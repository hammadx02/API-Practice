import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final PickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      setState(
        () {},
      );
    } else {
      print('no image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(
      () {
        showSpinner = true;
      },
    );

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var url = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', url);

    request.fields['title'] = 'Static title';

    var multipart = new http.MultipartFile('image', stream, length);

    request.files.add(multipart);

    var response = await request.send();

    print(response.stream.toString());

    if (response.statusCode == 200) {
      setState(
        () {
          showSpinner = false;
        },
      );
      print('image uploaded');
    } else {
      setState(
        () {
          showSpinner = false;
        },
      );
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Upload Image',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  child: image == null
                      ? const Center(
                          child: Text('Upload Image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Upload'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
