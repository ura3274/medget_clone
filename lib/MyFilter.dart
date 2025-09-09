import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyFilter extends StatefulWidget {
  const MyFilter({required this.link, required this.titleMap, super.key});
  final Map<String, List<String>> titleMap;
  final List<(LayerLink, Size)> link;
  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 80,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Row(
            spacing: 10,
            children: List.generate(widget.titleMap.length, (ind) {
              int widthButton = 0;
              final titleKey = widget.titleMap.keys.toList()[ind];
              widget.titleMap[titleKey]?.forEach((v) {
                if (v.length > widthButton) {
                  widthButton = v.length;
                }
              });
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                spacing: 10,
                children: [
                  Text(
                    titleKey,
                    style: TextStyle(fontSize: 10),
                  ),
                  CompositedTransformTarget(
                    link: widget.link[ind].$1,
                    child: SizedBox(
                      width: widget.link[ind].$2.width,
                      height: widget.link[ind].$2.height,
                    ),
                  )
                ],
              );
            })));
  }
}
