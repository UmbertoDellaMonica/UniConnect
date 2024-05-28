import 'package:uni_connect_front_end/shared/color_utils.dart';
import 'package:uni_connect_front_end/shared/enums.dart';
import 'package:flutter/material.dart';

enum ImagePosition {
  left,
  right,
}

class SlideInCard extends StatelessWidget {
  final ImagePosition imagePosition;
  final String title;
  final String description;
  final ImageProvider? image;

  SlideInCard({
    required this.imagePosition,
    required this.title,
    required this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0, // Modifica il valore di elevation come desiderato
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: ColorUtils.getColor(CustomType.neutral), width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (imagePosition == ImagePosition.left)
              _buildImageWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: imagePosition == ImagePosition.left
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: (imagePosition == ImagePosition.right) ? TextAlign.right : TextAlign.left,
                      title,
                      style: TextStyle(
                        color: ColorUtils.getColor(CustomType.neutral),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      textAlign: (imagePosition == ImagePosition.right) ? TextAlign.right : TextAlign.left,
                      description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (imagePosition == ImagePosition.right) _buildImageWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Container(
      width: 200.0,
      height: 150.0,
      decoration: BoxDecoration(
        image: image != null
            ? DecorationImage(
                image: image!,
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
