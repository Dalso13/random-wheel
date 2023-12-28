import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RandomWheelMain extends StatefulWidget {
  const RandomWheelMain({super.key});

  @override
  State<RandomWheelMain> createState() => _RandomWheelMainState();
}

class _RandomWheelMainState extends State<RandomWheelMain> {
  final textController = TextEditingController();

  List<String> values = [];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('행운의 돌림판', style: TextStyle(fontSize: 30)),
                Text('(2개~8개 설정가능)', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: '옵션 추가',
                        filled: true,
                        fillColor: Colors.green[50],
                      ),
                      maxLength: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (textController.text.length > 0 &&
                            values.length < 8 &&
                            textController.text.trim() != '') {
                          values.add(textController.text);
                          textController.text = '';
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 200,
              height: 250,
              child: ListView(
                children: values
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 150,
                                child: Text(
                                  e,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 20),
                                )),
                            SizedBox(
                                height: 25,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        values.remove(e);
                                      });
                                    },
                                    icon: const Icon(Icons.remove)))
                          ],
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 16),
              child: Text('${values.length}개 입력',
                  style: TextStyle(
                      fontSize: 20,
                      color: values.length < 2 ? Colors.red : Colors.green)),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    if (values.length > 1 && values.length < 9) {
                      context.push(Uri(
                              path: '/wheel',
                              queryParameters: {'items': values.join(',')})
                          .toString());
                    }
                  },
                  child: const Text("설정완료")),
            ])
          ],
        ),
      ),
    ));
  }
}
