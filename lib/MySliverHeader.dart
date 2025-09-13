import 'package:flutter/material.dart';

class MySliverHeader extends SliverPersistentHeaderDelegate {
  MySliverHeader({required this.data, required this.appBarHeightCallBack});
  Sliverheaderdata data;
  void Function(bool) appBarHeightCallBack;

  //void Function() showFiltering;
  @override
  double get minExtent => 40;
  @override
  double get maxExtent => 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("${shrinkOffset}");
    data.offset = shrinkOffset;
    if (shrinkOffset >= 40.0 && data.disconnected) {
      appBarHeightCallBack(true);
      data.disconnected = false;
    } else if (shrinkOffset < 40.0 && !data.disconnected) {
      appBarHeightCallBack(false);
      data.disconnected = true;
    }

    return CompositedTransformTarget(
      link: data.link,
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            /*if (shrinkOffset >= 40.0 && data.disconnected) {
              appBarHeightCallBack(true);
              data.disconnected = false;
            } else
            if (shrinkOffset < 40.0 && !data.disconnected) {
              appBarHeightCallBack(false);
              data.disconnected = true;
            }*/
          });

          return Container();
        },
      ),
    );
  }

  @override
  bool shouldRebuild(_) => false;
}

class Sliverheaderdata {
  final LayerLink link;
  bool disconnected;
  double offset;
  Sliverheaderdata(
      {required this.link, required this.disconnected, required this.offset});
}
