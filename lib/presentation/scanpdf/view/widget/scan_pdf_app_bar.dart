import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/scan_pdf_cubit.dart';

class ScanPdfAppBar extends StatelessWidget {
  const ScanPdfAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        buildWhen: (_1, _2) => false,
        builder: (_1, _2) {
          final cubit = BlocProvider.of<ScanPdfCubit>(context);
          return AppBar(title: const Text("image to pdf"), actions: [
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
          ]);
        });
  }
}
