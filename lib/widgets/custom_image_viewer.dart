import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomImageViewer extends StatefulWidget {
  final int? startIndex;
  final List<String> imagesList;

  const CustomImageViewer(
      {super.key, required this.imagesList, this.startIndex});

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  int index = 1;
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    if (widget.startIndex != null) {
      index = widget.startIndex! + 1;
      _controller = PageController(
        initialPage: widget.startIndex!,
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      bool isLandscape = orientation == Orientation.landscape ? true : false;
      var size = isLandscape
          ? MediaQuery.of(context).size / 2
          : MediaQuery.of(context).size;
      return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.primaryColor,
                    semanticLabel: "Close",
                  ))),
          body: Stack(
            children: [
              PageView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (page) {
                    setState(() {
                      index = page + 1;
                    });
                  },
                  children: widget.imagesList
                      .map(
                        (imageUrl) => InteractiveViewer(
                          maxScale: 5.0,
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (contect, url) =>
                                  const CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                  size: 40),
                            ),
                          ),
                        ),
                      )
                      .toList()),
              widget.imagesList.length > 1
                  ? Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.045,
                            vertical: size.width * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black38),
                        child: Text(
                          index.toString() +
                              ' / ' +
                              widget.imagesList.length.toString(),
                          style: TextStyle(
                              fontSize: size.width * 0.034,
                              color: Colors.white,
                              fontFamily: 'Roboto'),
                        ),
                      ))
                  : const SizedBox.shrink()
            ],
          ));
    });
  }
}
