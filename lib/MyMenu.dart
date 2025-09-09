import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyMenu extends StatefulWidget {
  const MyMenu(
      {required this.arr, required this.link, required this.size, super.key});
  final List<String> arr;
  final LayerLink link;
  final Size size;
  @override
  State<StatefulWidget> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  OverlayEntry? _overlay;
  bool showMenu = false;
  late String buttonText;
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    buttonText = widget.arr.first;
    selected = List.generate(widget.arr.length, (ind) {
      if (ind == 0) {
        return true;
      } else {
        return false;
      }
    });
  }

  void startOverlay(BuildContext context) {
    _overlay = OverlayEntry(builder: (ctx) {
      return Positioned.fill(
          child: GestureDetector(
        onTap: () {
          setState(() {
            endOverlay();
            showMenu = false;
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Container(),
      ));
    });
    Overlay.of(context).insert(_overlay!);
  }

  void endOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      link: widget.link,
      showWhenUnlinked: false,
      child: Stack(
        children: [
          if (showMenu)
            Transform.translate(
              offset: Offset(0, widget.size.height / 2),
              child: Container(
                  width: widget.size.width,
                  height: 150,
                  padding: EdgeInsets.only(top: widget.size.height / 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 5)]),
                  child: Column(
                      children: widget.arr.indexed.map<Widget>((entry) {
                    ValueNotifier isHover = ValueNotifier(false);
                    return MouseRegion(
                      onEnter: (_) {
                        isHover.value = true;
                        endOverlay();
                      },
                      onExit: (_) {
                        isHover.value = false;
                        startOverlay(context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            endOverlay();
                            buttonText = entry.$2;
                            for (int i = 0; i < selected.length; ++i) {
                              if (i == entry.$1) {
                                selected[i] = true;
                              } else {
                                selected[i] = false;
                              }
                            }
                            showMenu = false;
                          });
                        },
                        child: ValueListenableBuilder(
                            valueListenable: isHover,
                            builder: (ctxt, hover, child) {
                              return Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.only(left: 5, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: selected[entry.$1]
                                        ? Colors.blue
                                        : hover
                                            ? Color.fromARGB(255, 189, 180, 180)
                                            : null),
                                child: Text(
                                  entry.$2,
                                  style: TextStyle(
                                      color: selected[entry.$1]
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 10),
                                ),
                              );
                            }),
                      ),
                    );
                  }).toList())),
            ),
          GestureDetector(
            onTap: () {
              setState(() {
                showMenu = true;
                startOverlay(context);
              });
            },
            child: Container(
                width: widget.size.width,
                height: widget.size.height,
                padding: EdgeInsets.only(left: 5),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 10),
                )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlay?.dispose();
    super.dispose();
  }
}
