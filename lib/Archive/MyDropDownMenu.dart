import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDropDownMenu extends StatefulWidget {
  const MyDropDownMenu({required this.arr, super.key});

  final List<String> arr;

  @override
  State<MyDropDownMenu> createState() => _MyDropDownMenuState();
}

class _MyDropDownMenuState extends State<MyDropDownMenu> {
  OverlayEntry? _overlayEntry;
  final LayerLink _link = LayerLink();
  final GlobalKey _key = GlobalKey();
  late String _text;

  void getTextFmMenu(String value) {
    setState(() {
      _text = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _text = widget.arr.first;
  }

  void _showOverlay(BuildContext context) {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(builder: (ctx) {
      return Positioned(
          top: offset.dy,
          left: offset.dx,
          child: CompositedTransformFollower(
            link: _link,
            showWhenUnlinked: false,
            offset: Offset(0, size.height - 8),
            child: Material(
              child: Container(
                width: 50,
                //height: 50,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: widget.arr.map((it) {
                    final ValueNotifier<bool> isHovered = ValueNotifier(false);
                    return MouseRegion(
                      onEnter: (_) {
                        //print('enter');
                        setState(() {
                          isHovered.value = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHovered.value = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _text = it;
                          });
                        },
                        child: ValueListenableBuilder(
                            valueListenable: isHovered,
                            builder: (ctxt, hovered, child) {
                              return Text(
                                it,
                                style: TextStyle(
                                    color: Colors.black,
                                    backgroundColor: hovered
                                        ? Color.fromARGB(255, 189, 180, 180)
                                        : null,
                                    fontSize: 10),
                              );
                            }),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ));
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  /*void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _showOverlay(context);
        },
        child: CompositedTransformTarget(
          link: _link,
          child: Container(
              key: _key,
              //width: 40,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(_text)),
        ));
  }
}
