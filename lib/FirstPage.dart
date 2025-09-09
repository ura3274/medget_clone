import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/MovieList.dart';
import 'package:my_app/MyMenu.dart';
import 'package:my_app/MyFilter.dart';
import 'package:my_app/Repositiriy.dart';
import 'package:my_app/SliverTitle.dart';
import 'package:my_app/ViewModel.dart';
import 'package:my_app/MyAppBar.dart';

class FirstPage extends StatefulWidget {
  FirstPage({required this.vm, super.key});
  final titles = {
    "Жанр": ["Любой", "Боевик", "Вестерн", "Военный"],
    "Года": ["Любой", "2025", "2024", "2023", "2022"],
    "Рейтинг": ["Любой", "9+", "8+", "7+", "6+"],
    "Сортировать по": ["По рейтингу", "По новизне", "По популярности"],
    "Язык озвучки": ["Любой", "Русский", "English", "Espanol", "Turkish"],
    "Язык субтитров": ["Любой", "Русский", "English", "Espanol", "Turkish"],
  };
  final ViewModel vm;
  final double _scrollFactor = 0.7;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _enableExpand = false;
  bool _expandAppBar = true;
  bool _atTop = true;
  bool _enable = true;
  int routeId = 0;
  int titleId = 0;
  bool showFilter = false;
  final ScrollController _controller = ScrollController();
  late List<String> keys;
  late Map<String, myData> data;
  List<(LayerLink, Size)> _link = [];
  LayerLink filterLink = LayerLink();

  void openMenuCall(int id) {
    setState(() {
      titleId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    keys = widget.vm.getData()[routeId].keys.toList();
    data = widget.vm.getData()[routeId];
    for (var i in widget.titles.keys) {
      double widthButton = 0;

      widget.titles[i]?.forEach((v) {
        if (v.length.toDouble() > widthButton) {
          widthButton = v.length.toDouble();
        }
      });
      _link.add((LayerLink(), Size(widthButton * 10, 20)));
    }

    _controller.addListener(() {
      //print("Позиция скролла: ${_controller?.position.atEdge}");
      if (_controller.position.pixels != 0.0) {
        if (_enable) {
          setState(() {
            //print("enable");
            _atTop = false;
            _enableExpand = true;
            _expandAppBar = false;
            _enable = false;
          });
        }
      } else {
        setState(() {
          //print("disable");
          _atTop = true;
          _enableExpand = false;
          _expandAppBar = true;
          _enable = true;
        });
      }
    });
  }

  void routeCallBack(int id) {
    setState(() {
      routeId = id;
      keys = widget.vm.getData()[routeId].keys.toList();
      data = widget.vm.getData()[routeId];
    });
  }

  void showMyFiltering() {
    setState(() {
      showFilter = !showFilter;
    });
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final double newOffset =
          _controller.offset - event.scrollDelta.dy * widget._scrollFactor;
      //print("${_controller.offset}");
      //_controller.
      if (!((_controller.position.atEdge &&
              _controller.position.pixels == 0.0 &&
              event.scrollDelta.dy < 0.0) ||
          (_controller.position.atEdge &&
              _controller.position.pixels != 0.0 &&
              event.scrollDelta.dy > 0.0))) {
        _controller.jumpTo(newOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: _atTop ? false : true,
        appBar: AppBar(
          toolbarHeight: _expandAppBar ? kToolbarHeight - 10 : 5,
          shadowColor: Colors.black,
          //elevation: 20,
          clipBehavior: Clip.hardEdge,
          flexibleSpace: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                //margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: _expandAppBar ? kToolbarHeight - 10 : 5,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  //BoxShadow(
                  //  offset: Offset(-2, 0), blurRadius: 3, spreadRadius: 0)
                ]),
                clipBehavior: Clip.hardEdge,
                child: MyAppBar(
                    arr: widget.vm.getTitleData(),
                    btnChecked: routeId,
                    routeCallback: routeCallBack),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Listener(
              onPointerSignal: _handlePointerSignal,
              child: CustomScrollView(controller: _controller, slivers: [
                if (routeId != 0)
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverTitle(filterLink: filterLink)),
                if (showFilter)
                  SliverToBoxAdapter(
                    child: MyFilter(
                      link: _link,
                      titleMap: widget.titles,
                    ),
                  ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, ind) {
                  return MouseRegion(
                      onExit: (_) {
                        if (_enableExpand) {
                          setState(() {
                            _expandAppBar = true;
                          });
                        }
                      },
                      onEnter: (_) {
                        if (_enableExpand) {
                          setState(() {
                            _expandAppBar = false;
                          });
                        }
                      },
                      child:
                          MovieList(title: keys[ind], data: data[keys[ind]]!));
                }, childCount: data.length)),
              ]),
            ),
            if (showFilter)
              for (int i = 0; i < widget.titles.length; ++i)
                MyMenu(
                  arr: widget.titles[widget.titles.keys.toList()[i]]!,
                  link: _link[i].$1,
                  size: _link[i].$2,
                ),
            if (routeId != 0)
              CompositedTransformFollower(
                link: filterLink,
                child: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Text(widget.vm.getTitleData()[routeId].title),
                        TextButton(
                            onPressed: showMyFiltering, child: Text("Filter"))
                      ],
                    )),
              )
          ],
        ));
  }

  @override
  void dispose() {
    _controller.dispose(); // не забудьте очистить контроллер
    super.dispose();
  }
}
