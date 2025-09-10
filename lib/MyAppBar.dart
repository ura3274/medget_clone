import 'package:flutter/material.dart';
import 'package:my_app/Repositiriy.dart';
import 'package:my_app/MyNavButton.dart';
import 'package:my_app/MySwitch.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar(
      {required this.arr,
      required this.btnChecked,
      required this.routeCallback,
      super.key});
  final void Function(int) routeCallback;
  final int btnChecked;
  final List<BtnState> arr;
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  //bool _switch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: widget.arr.map((it) {
            return MyNavButton(
                id: it.id,
                title: it.title,
                isChecked: it.id == widget.btnChecked ? true : false,
                callFn: widget.routeCallback);
          }).toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Скачать без торрентов")),
              MySwitch()
            ],
          )
        ],
      ),
    );
  }
}
