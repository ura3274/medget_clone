import 'package:flutter/material.dart';

class MyTooltip extends StatefulWidget {
  final Widget child;
  final String message;

  const MyTooltip({
    super.key,
    required this.child,
    required this.message,
  });

  @override
  State<MyTooltip> createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<MyTooltip> {
  OverlayEntry? _overlayEntry;

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
                  widget.message,
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (_overlayEntry == null) {
          _showOverlay(context);
        }
      },
      onExit: (_) {
        _hideOverlay();
      },
      child: widget.child,
    );
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
