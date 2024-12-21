import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageField extends StatefulWidget {
  const ImageField({super.key, required this.onFileChanged});
  final ValueChanged<File?> onFileChanged;

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  bool isLoading = false;
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      //pick image
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            await pickImage();
          } on Exception catch (e) {}
          isLoading = false;
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: fileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(fileImage!))
                    : const Icon(
                        Icons.image_outlined,
                        size: 180,
                      )),
            Visibility(
              visible: fileImage != null,
              child: IconButton(
                  onPressed: () {
                    fileImage = null;
                    widget.onFileChanged(fileImage);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    //hetet huwa gallery wla file 3ady wla eh
    final XFile? media = await picker.pickMedia();
    fileImage = File(media!.path);

    widget.onFileChanged(fileImage!);
  }
}
