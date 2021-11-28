import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:publico/styles/colors.dart';

class PhotoViewer extends StatefulWidget {
  final String imageUrl;
  const PhotoViewer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              backgroundDecoration: BoxDecoration(
                color: kRichBlack.withOpacity(0.55),
              ),
              imageProvider: NetworkImage(
                widget.imageUrl,
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 4,
            ),
            Positioned(
              top: 15,
              left: 5,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kRichBlack.withOpacity(0.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: kRichWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
