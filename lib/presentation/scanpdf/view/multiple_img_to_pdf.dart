import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/scan_pdf_cubit.dart';
import '../cubit/scan_pdf_state.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: ListView.builder(
                        itemCount: cubit.image.length,
                        itemBuilder: (context, index) => Container(
                            height: 400,
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: (kIsWeb)
                                ? Image.network(cubit.image[index].path)
                                : Image.file(
                                    cubit.image[index],
                                    fit: BoxFit.cover,
                                  )),
                      )),
              if (state == ScanPdfState.loading)
                const Center(child: CircularProgressIndicator())
              else
                const SizedBox(width: 0, height: 0)
            ])
          ]);
        })));
  }

  showPrintedMessage(String title, String msg) {
    Flushbar(
      title: title,
      message: msg,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.info,
        color: Colors.blue,
      ),
    ).show(context);
  }
}
