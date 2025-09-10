import 'package:flutter/material.dart';

class Target extends StatefulWidget {
  final LayerLink appBarLink;
  const Target({super.key, required this.appBarLink});

  @override
  State<Target> createState() => _TargetState();
}

class _TargetState extends State<Target> {
  @override
  void dispose() {
    print("Target уничтожен → follower отсоединится");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: widget.appBarLink,
      child: Container(),
    );
  }
}
