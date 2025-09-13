import 'package:flutter/material.dart';

class CarCardSkeleton extends StatelessWidget {
  const CarCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          // Container(
          //   width: 6,
          //   height: double.infinity,
          //   decoration: const BoxDecoration(
          //     color: Color(0xFFEEEEEE),
          //     borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title + price
                  Row(
                    children: const [
                      _ShimmerBox(height: 18, width: 180),
                      Spacer(),
                      _ShimmerBox(height: 16, width: 60),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // specs chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _ShimmerBox(height: 22, width: 90, radius: 999),
                      _ShimmerBox(height: 22, width: 80, radius: 999),
                      _ShimmerBox(height: 22, width: 70, radius: 999),
                      _ShimmerBox(height: 22, width: 90, radius: 999),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      _ShimmerBox(height: 28, width: 86, radius: 999),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarCardsSkeletonList extends StatelessWidget {
  final int count;
  const CarCardsSkeletonList({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemBuilder: (_, __) => const CarCardSkeleton(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: count,
    );
  }
}

/// Minimal shimmer (no external package)
class _ShimmerBox extends StatefulWidget {
  final double height;
  final double width;
  final double radius;
  const _ShimmerBox({required this.height, required this.width, this.radius = 8});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = _c.value;
        return ShaderMask(
          shaderCallback: (rect) {
            final dx = rect.width * (t * 2 - 0.5);
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.grey.shade300, Colors.grey.shade100, Colors.grey.shade300],
              stops: const [0.25, 0.5, 0.75],
              transform: GradientRotation(0),
            ).createShader(Rect.fromLTWH(dx, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        );
      },
    );
  }
}
