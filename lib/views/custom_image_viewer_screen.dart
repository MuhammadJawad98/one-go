import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageViewer extends StatefulWidget {
  final int? startIndex;
  final List<String> imagesList;

  const CustomImageViewer({
    super.key,
    required this.imagesList,
    this.startIndex,
  });

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    currentIndex = widget.startIndex ?? 0;
    _controller = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Main Image Viewer
          PageView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: widget.imagesList.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1.0,
                maxScale: 5.0,
                onInteractionStart: (details) {},
                onInteractionEnd: (details) {},
                child: Hero(
                  tag: widget.imagesList[index],
                  child: CachedNetworkImage(
                    imageUrl: widget.imagesList[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[400],
                        size: 50,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Indicator
          if (widget.imagesList.length > 1)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentIndex + 1}/${widget.imagesList.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Navigation Arrows (only show for multiple images)
          if (widget.imagesList.length > 1)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentIndex > 0)
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left),
                          color: Colors.white,
                          onPressed: () => _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                    const Spacer(),
                    if (currentIndex < widget.imagesList.length - 1)
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right),
                          color: Colors.white,
                          onPressed: () => _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
