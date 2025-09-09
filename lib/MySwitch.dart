import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;
  bool _isChecked = false;
  bool _isEnabled = true;
  Color setColorRail = Color.fromARGB(255, 223, 229, 226);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _anim = Tween<double>(begin: -1, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: _isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: () {
            if (_isEnabled) {
              _isChecked ? _controller.reverse() : _controller.forward();
              _isChecked = !_isChecked;
              if (_isChecked) {
                setState(() {
                  _isEnabled = false;
                  setColorRail = Color.fromARGB(255, 148, 201, 143);
                  Future.delayed(Duration(milliseconds: 1000), () {
                    setState(() {
                      _isEnabled = true;
                      setColorRail = Color.fromARGB(255, 30, 193, 15);
                    });
                  });
                });
              } else {
                setState(() {
                  _isEnabled = false;
                  setColorRail = Color.fromARGB(255, 223, 229, 226);
                  Future.delayed(Duration(milliseconds: 1000), () {
                    setState(() {
                      _isEnabled = true;
                      setColorRail = Color.fromARGB(255, 170, 174, 170);
                    });
                  });
                });
              }
            }
          },
          child: Wrap(
            children: [
              Container(
                  alignment: Alignment(_anim.value, 0),
                  decoration: BoxDecoration(
                      color: setColorRail,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15)),
                  width: 40,
                  height: 20,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(),
                          shape: BoxShape.circle),
                    ),
                  )),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
