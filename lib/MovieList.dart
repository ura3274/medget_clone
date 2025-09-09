import 'package:flutter/material.dart';
import 'package:my_app/Repositiriy.dart';

class MovieList extends StatefulWidget {
  const MovieList({required this.title, required this.data, super.key});
  final String title;
  final myData data;
  @override
  State<StatefulWidget> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  ScrollController controller = ScrollController();
  double scrollStep = 0;
  bool inStartPos = true;
  bool inEndPos = false;

  void scrollRight() {
    if (!inEndPos) {
      scrollStep += 150;
    }
    if (scrollStep < controller.position.maxScrollExtent || !inEndPos) {
      //scrollStep += 150;
      //print("${scrollStep}");
      controller.animateTo(scrollStep,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      if (scrollStep > controller.position.maxScrollExtent) {
        print("1");
        setState(() {
          inEndPos = true;
        });
      }

      if (inStartPos) {
        print("2");
        setState(() {
          inStartPos = false;
        });
      }
    }
  }

  void scrollLeft() {
    if (!inStartPos) {
      scrollStep -= 150;
    }
    if (scrollStep != 0 || !inStartPos) {
      //print("${scrollStep}");
      controller.animateTo(scrollStep,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      if (scrollStep == 0) {
        print("3");
        setState(() {
          inStartPos = true;
        });
      }
    }
    if (inEndPos) {
      print("4");
      setState(() {
        inEndPos = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: scrollLeft,
          child: Opacity(
            opacity: inStartPos ? 0.2 : 1.0,
            child: Icon(
              Icons.keyboard_double_arrow_left,
            ),
          ),
        ),
        Expanded(
            child: Container(
          //width: 50,
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 157,
          decoration: BoxDecoration(color: Colors.amber, border: Border.all()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (ctx, ind) {
                        return Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey, border: Border.all()),
                          child: Text(
                            "page: $ind",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }))
            ],
          ),
        )),
        //IconButton(onPressed: scrollRight, icon: Icon(Icons.arrow_right_sharp)),
        GestureDetector(
          onTap: scrollRight,
          child: Opacity(
            opacity: inEndPos ? 0.2 : 1.0,
            child: Icon(
              Icons.keyboard_double_arrow_right,
            ),
          ),
        )
      ],
    );
  }
}
