import 'package:flutter/material.dart';

class MyNavButton extends StatefulWidget {
  const MyNavButton(
      {required this.id,
      required this.title,
      this.isChecked = false,
      required this.callFn,
      super.key});

  final int id;
  final String title;
  final bool isChecked;
  final void Function(int) callFn;

  @override
  State<MyNavButton> createState() => _MyNavButtonState();
}

class _MyNavButtonState extends State<MyNavButton> {
  bool _isHovered = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideOverlay();
        widget.callFn(widget.id);
      },
      child: MouseRegion(
        onEnter: (e) {
          if (_overlayEntry == null) {
            _showOverlay(context);
          }
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (e) {
          _hideOverlay();
          setState(() {
            _isHovered = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Wrap(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              //height: 5,
              decoration: BoxDecoration(
                  color: widget.isChecked
                      ? Color.fromARGB(255, 13, 204, 51)
                      : _isHovered
                          ? Color.fromARGB(255, 13, 204, 51)
                          : Color.fromARGB(255, 223, 229, 226),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(widget.title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: widget.isChecked
                        ? Colors.white
                        : _isHovered
                            ? Colors.white
                            : null,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx, // смещение тултипа по центру
        top: offset.dy + size.height,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: Size(20, 10),
                painter: _TrianglePainter(sized: size),
              ),
              // тултип
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 100,
                child: Text(
                  "jjjjjj", //widget.message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // стрелочка (треугольник)
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({required this.sized});
  Size sized;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black87;
    final path = Path()
      ..moveTo(sized.width / 2, 0)
      ..lineTo((sized.width / 2) - size.width / 2, size.height)
      ..lineTo((sized.width / 2) + size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
