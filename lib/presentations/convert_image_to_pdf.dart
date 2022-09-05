
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/presentations/take_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class GeneratePdfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConvertImageToPdfStatefulWidget(title: 'Convert Image to PDF'),
    );
  }
}

class ConvertImageToPdfStatefulWidget extends StatefulWidget {
  ConvertImageToPdfStatefulWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _ConvertImageToPdfState createState() => _ConvertImageToPdfState();
}

class _ConvertImageToPdfState extends State<ConvertImageToPdfStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: const Text(
                'take a picture',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue)),
              onPressed: () async {
                final cameras = await availableCameras();

                // Get a specific camera from the list of available cameras.
                final firstCamera = cameras.first;
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) => TakePictureScreen(camera: firstCamera, onGetPath: (String a) {
                          _convertImageToPDF(a);
                        },
                        )
                    )
                );
              },
            ),
            TextButton(
              child: const Text(
                'choose from gallery',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue)),
              onPressed: getImage,
            ),
            TextButton(
              child: const Text(
                'Convert',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue)),
              onPressed: () async { _convertImageToPDF('assets/images/img_home_bg.png');},
            )
          ],
        ),
      ),
    );
  }

  Future<void> _convertImageToPDF(String name) async {
    //Create the PDF document
    PdfDocument document = PdfDocument();
    //Add the page
    PdfPage page = document.pages.add();
    //Load the image.
    final PdfImage image = PdfBitmap(await _readImageData(name));
    //draw image to the first page
    page.graphics.drawImage(
        image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
    //Save the docuemnt
    List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get external storage directory
    Directory directory = (await getApplicationDocumentsDirectory())!;
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }

  void _takeAPicture() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
  }

  Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load(name);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image != null) {
      _convertImageToPDF(image.path);
    }
  }
}
