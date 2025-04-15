import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:gpdikpbaru/controller/testingpage_controller.dart';
import 'package:gpdikpbaru/custom_widget/custom_appbar.dart';
import 'package:gpdikpbaru/widgets/nodata.dart';
import 'package:gpdikpbaru/widgets/shimmer.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  final List myImages = [
    'assets/images/alkitab.png',
    'assets/images/gopay.png',
  ]; // contoh list image
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Asdasd"),
        ),
        body: ReorderableListView(
          children: [
            for (int index = 0; index < myImages.length; index++)
              KeyedSubtree(
                key: ValueKey(index), // berikan ValueKey dengan index
                child: ReorderableDragStartListener(
                  // tambahkan ReorderableDragStartListener di luar Row
                  index: index, // berikan index
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Image.asset(myImages[index]),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final image = myImages.removeAt(oldIndex);
            myImages.insert(newIndex, image);
            setState(() {});
          },
        ));
  }
}
