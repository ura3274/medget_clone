import 'package:flutter/material.dart';
import 'package:my_app/MyTooltip.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callFn(widget.id);
      },
      child: MouseRegion(
        onEnter: (e) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (e) {
          setState(() {
            _isHovered = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Wrap(
          //mainAxisSize: MainAxisSize.min,
          children: [
            MyTooltip(
              message: "ggggg",
              child: Container(
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
            )
          ],
        ),
      ),
    );
  }
}
