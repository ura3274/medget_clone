import 'package:flutter/material.dart';
import 'MyAppBarTarget.dart';

class MySliverHeader extends SliverPersistentHeaderDelegate {
  MySliverHeader({required this.appBarLink});

  LayerLink appBarLink;
  //void Function() showFiltering;
  @override
  double get minExtent => 40;
  @override
  double get maxExtent => 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //print("${shrinkOffset}");

    return Target(appBarLink: appBarLink);
  }

  @override
  bool shouldRebuild(_) => true;
}
