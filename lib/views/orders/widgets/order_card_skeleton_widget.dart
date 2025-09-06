import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const Shimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
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
        // slide gradient horizontally
        final t = _c.value;
        return ShaderMask(
          shaderCallback: (rect) {
            final width = rect.width;
            final dx = (width * 1.5) * t - width * 0.75;
            return LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.25, 0.5, 0.75],
              transform: GradientTranslation(dx, 0),
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Convenience for grey rounded boxes
class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;
  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // left accent
          Container(
            width: 6,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            ),
          ),

          // content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title + price row
                  Row(
                    children: [
                      // title line
                      const Expanded(
                        child: ShimmerBox(height: 18, width: double.infinity),
                      ),
                      const SizedBox(width: 12),
                      // price pill
                      const ShimmerBox(height: 16, width: 58),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // timeslot line
                  Row(
                    children: const [
                      // clock icon placeholder
                      ShimmerBox(height: 16, width: 16, borderRadius: BorderRadius.all(Radius.circular(4))),
                      SizedBox(width: 8),
                      Expanded(
                        child: ShimmerBox(height: 14, width: double.infinity),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // status chip + actions
                  Row(
                    children: [
                      const ShimmerBox(height: 28, width: 86, borderRadius: BorderRadius.all(Radius.circular(999))),
                      const Spacer(),
                      // view button
                      const ShimmerBox(height: 36, width: 72, borderRadius: BorderRadius.all(Radius.circular(20))),
                      const SizedBox(width: 8),
                      // cancel button
                      const ShimmerBox(height: 36, width: 84, borderRadius: BorderRadius.all(Radius.circular(10))),
                    ],
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

/// Optional: list placeholder you can show while loading
class OrdersSkeletonList extends StatelessWidget {
  final int itemCount;
  const OrdersSkeletonList({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemBuilder: (_, __) => const OrderCardSkeleton(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: itemCount,
    );
  }
}

/// Gradient translation helper for the shimmer animation
class GradientTranslation extends GradientTransform {
  final double dx;
  final double dy;
  const GradientTranslation(this.dx, this.dy);
  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(dx, dy, 0.0);
  }
}
