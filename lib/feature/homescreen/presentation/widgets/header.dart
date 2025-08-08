
import 'package:flutter/material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  HeaderDelegate(
      {required this.child, required this.minHeight, required this.maxHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant HeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
