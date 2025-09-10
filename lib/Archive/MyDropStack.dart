import 'package:flutter/material.dart';

class MyStates extends ChangeNotifier {
  bool isHovered = false;
  bool menuShow = false;

  void isHoveredState(bool value) {
    isHovered = value;
    notifyListeners();
  }
}

class MyDropStack extends StatefulWidget {
  const MyDropStack({required this.arr, super.key});

  final List<String> arr;
  @override
  State<StatefulWidget> createState() => _MyDropStackState();
}

class _MyDropStackState extends State<MyDropStack> {
  OverlayEntry? entry;
  OverlayEntry? entry2;
  final GlobalKey _key = GlobalKey();
  final LayerLink _link = LayerLink();
  late String _text;
  int widthButton = 0;

  @override
  void initState() {
    super.initState();
    //int kk = 0;
    for (var v in widget.arr) {
      if (v.length > widthButton) {
        widthButton = v.length;
      }
    }
    //print("${widthButton}");
    _text = widget.arr.first;
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    //startOverlay(cctx!);
    //});
  }

  void startOverlay(BuildContext context) {
    final box = _key.currentContext?.findRenderObject() as RenderBox;
    final size = box.size;
    final offset = box.localToGlobal(Offset.zero);

    entry = OverlayEntry(builder: (ctx) {
      return Positioned(
          //top: offset.dy,
          left: offset.dx,
          child: CompositedTransformFollower(
            link: _link,
            showWhenUnlinked: false,
            offset: Offset(0, 0),
            child: Material(
              child: Stack(
                //fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Transform.translate(
                    offset: Offset(0, 10),
                    child: Container(
                      width: size.width,
                      //height: 50,
                      padding: EdgeInsets.only(top: size.height / 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 5)]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.arr.map((it) {
                          final myStates = MyStates();
                          return MouseRegion(
                            onEnter: (_) {
                              //print('enter');
                              setState(() {
                                myStates.isHoveredState(true);
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                myStates.isHoveredState(false);
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                endOverlay();
                                setState(() {
                                  _text = it;
                                });
                              },
                              child: ListenableBuilder(
                                  listenable: myStates,
                                  builder: (ctxt, child) {
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: myStates.isHovered
                                            ? Color.fromARGB(255, 189, 180, 180)
                                            : null,
                                      ),
                                      child: Text(
                                        it,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    );
                                  }),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      endOverlay();
                    },
                    child: Container(
                        width: size.width,
                        height: size.height,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          _text,
                          style: TextStyle(fontSize: 10),
                        )),
                  ),
                ],
              ),
            ),
          ));
    });
    entry2 = OverlayEntry(builder: (ctx) {
      return Positioned.fill(
        child: GestureDetector(
          onTap: () {
            endOverlay();
          },
          behavior: HitTestBehavior.translucent, // очень важно!
          child: Container(), // пустой, просто ловит тап
        ),
      );
    });
    Overlay.of(context).insert(entry2!);
    Overlay.of(context).insert(entry!);
  }

  void endOverlay() {
    entry?.remove();
    entry = null;
    entry2?.remove();
    entry2 = null;
  }

  @override
  Widget build(BuildContext context) {
    //cctx = context;
    return GestureDetector(
        onTap: () {
          startOverlay(context);
        },
        child: CompositedTransformTarget(
          link: _link,
          child: Container(
            key: _key,
            alignment: Alignment.centerLeft,
            width: widthButton * 10,
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              _text,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    entry?.dispose();
    entry2?.dispose();
    super.dispose();
  }
}
