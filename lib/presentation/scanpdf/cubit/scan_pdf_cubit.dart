import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/presentation/scanpdf/cubit/scan_pdf_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../view/widget/take_camera.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class ScanPdfCubit extends Cubit<ScanPdfState> {
  ScanPdfCubit() : super(ScanPdfState.initial);
  final picker = ImagePicker();
  final pdf = pw.Document();
  final List<File> image = [];
  StreamController createPdfStreamController =
      StreamController<bool>.broadcast();

  Stream get createPdfStream => createPdfStreamController.stream;

  getImageFromGallery() async {
    final pickedFile = await picker.pickMultiImage();
    emit(ScanPdfState.loading);
    if (pickedFile != null) {
      pickedFile.forEach((element) {
        image.add(File(element.path));
      });
    } else {
      print('No image selected');
    }
    emit(ScanPdfState.complete);
  }

  takeAPicture(BuildContext context) async {
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(
                camera: firstCamera,
                onGetPath: (XFile a) {
                  emit(ScanPdfState.loading);
                  image.add(File(a.path));
                  emit(ScanPdfState.complete);
                })));
  }

  createPDF() async {
    emit(ScanPdfState.loading);
    for (var img in image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(image, fit: pw.BoxFit.fitWidth));
          }));
    }
    emit(ScanPdfState.complete);
  }

  savePDF() async {
    emit(ScanPdfState.loading);
    try {
      if (kIsWeb) {
        Uint8List pdfInBytes = await pdf.save();

//Create blob and link from bytes
        final blob = html.Blob([pdfInBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.document.createElement('a') as html.AnchorElement
          ..href = url
          ..style.display = 'none'
          ..download = '${DateTime.now().millisecondsSinceEpoch}.pdf';
        html.document.body!.children.add(anchor);

// download
        anchor.click();

// cleanup
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);

      } else {
        final dir = await getExternalStorageDirectory();
        final file =
            File('${dir!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(await pdf.save());
      }
      createPdfStreamController.sink.add(true);
      emit(ScanPdfState.complete);
    } catch (e) {
      createPdfStreamController.sink.add(false);
      emit(ScanPdfState.complete);
    }
  }
}
