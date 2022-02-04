import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero/util/component/label/component_label.dart';

class ImageFile extends StatelessWidget {
  final String? pathPhoto;
  const ImageFile({Key? key, required this.pathPhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pathPhoto == null) {
      return _widgetError();
    }
    return Image.file(
      File(pathPhoto!),
      errorBuilder: (context, error, stackTrace) {
        return _widgetError();
      },
    );
  }

  Widget _widgetError() {
    return const Center(
      child: LabelBlack.title('Photo tidak dapat di tampilkan.'),
    );
  }
}
