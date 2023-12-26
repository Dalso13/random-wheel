import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

class RandomWheel extends StatefulWidget {
  List<String> items;

  RandomWheel({super.key, required this.items});

  @override
  State<RandomWheel> createState() => _RandomWheelState();
}

class _RandomWheelState extends State<RandomWheel> {
  final _controller = BehaviorSubject<int>();
  String? _result;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: const Text(
          '돌려 돌려 돌림판',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: _result != null
                  ? Column(
                      children: [
                        Text(
                          '당첨!',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _result!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green[400],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Text('돌림판을 돌려주세요',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 350,
              height: 350,
              child: FortuneWheel(
                  physics: NoPanPhysics(),
                  animateFirst: false,
                  selected: _controller.stream,
                  onAnimationEnd: () {
                    setState(() {
                      _result = widget.items[_controller.value];
                    });
                  },
                  items: widget.items
                      .map((e) => FortuneItem(
                              child: SizedBox(
                            width: 100,
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 20),
                            ),
                          )))
                      .toList()),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller
                              .add(Fortune.randomInt(0, widget.items.length));
                        });
                      },
                      child: const Text("돌리기")),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text("다시설정")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
