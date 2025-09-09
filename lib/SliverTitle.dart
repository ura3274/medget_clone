import 'package:flutter/material.dart';

class SliverTitle extends SliverPersistentHeaderDelegate {
  SliverTitle({required this.filterLink});

  LayerLink filterLink;
  //void Function() showFiltering;
  @override
  double get minExtent => 40;
  @override
  double get maxExtent => 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //print("${shrinkOffset}");
    return CompositedTransformTarget(
      link: filterLink,
      child: Container(),
    );
  }

  @override
  bool shouldRebuild(_) => true;
}
