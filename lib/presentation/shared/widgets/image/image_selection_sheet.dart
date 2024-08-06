import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionSheet extends StatelessWidget {
  const ImageSelectionSheet({
    super.key,
    this.onImageSelected,
    this.onImageDeletion,
  });

  final void Function(XFile image)? onImageSelected;
  final VoidCallback? onImageDeletion;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Text(
            'Choose image',
            style: themeData.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Open camera'),
                onTap: () => _fromCamera(context),
              );
            }
            if (index == 1) {
              return ListTile(
                leading: const Icon(Icons.image_outlined),
                title: const Text('Select from album'),
                onTap: () => _fromGallery(context),
              );
            }
            if (index == 2) {
              return ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () => _onDeletion(),
              );
            }
            return null;
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ],
    );
  }

  void _fromCamera(BuildContext context) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (image?.path == null) {
      return;
    }

    if (onImageSelected != null) {
      onImageSelected!(image!);
    }
  }

  void _fromGallery(BuildContext context) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (image?.path == null) {
      return;
    }

    if (onImageSelected != null) {
      onImageSelected!(image!);
    }
  }

  void _onDeletion() {
    if (onImageDeletion != null) {
      onImageDeletion!();
    }
  }
}
