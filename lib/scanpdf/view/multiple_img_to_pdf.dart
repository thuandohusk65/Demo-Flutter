import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/scanpdf/cubit/scan_pdf_cubit.dart';
import 'package:flutter_project/scanpdf/cubit/scan_pdf_state.dart';

class MutipleImageToPdf extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MutipleImageToPdf> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanPdfCubit>(
        create: (_) => ScanPdfCubit(),
        child: Scaffold(body:
            BlocBuilder<ScanPdfCubit, ScanPdfState>(builder: (context, state) {
          final cubit = BlocProvider.of<ScanPdfCubit>(context);
          cubit.createPdfStream.listen((event) {
            showPrintedMessage("create pdf", (event) ? "success" : "error!");
          });
          return Column(children: [
            AppBar(title: const Text("image to pdf"), actions: [
              IconButton(
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: () {
                    cubit.takeAPicture(context);
                  }),
              IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    cubit.getImageFromGallery();
                  }),
              IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: () {
                    cubit.createPDF();
                    cubit.savePDF();
                  })
            ]),
            Stack(children: [
              (state == ScanPdfState.initial)
                  ? const Center(child: Text("Add your photo!"))
                  : ListView.builder(
                      itemCount: cubit.image.length,
                      itemBuilder: (context, index) => Container(
                          height: 400,
                          width: double.infinity,
                          margin: EdgeInsets.all(8),
                          child: Image.file(
                            cubit.image[index],
                            fit: BoxFit.cover,
                          )),
                    ),
              (state == ScanPdfState.loading)
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox()
            ])
          ]);
        })));
  }

  showPrintedMessage(String title, String msg) {
    Flushbar(
      title: title,
      message: msg,
      duration: Duration(seconds: 3),
      icon: const Icon(
        Icons.info,
        color: Colors.blue,
      ),
    ).show(context);
  }
}
