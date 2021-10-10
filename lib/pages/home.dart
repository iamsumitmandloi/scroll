import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scroll/widget/get_box_offset.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List item = [];
  List ml = [];
  ScrollController? scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
     ml = [{'User':['u11','u12','u13','u14','u15','u16']},
       {'Group':['u31','u32','u33','u34','u35']},
       {'Player':['u11','u12','u13','u14','u15']},
       {'Others':['u11','u12','u13','u14','u15']},
     ];

    item = List.generate(ml.length, (index) => index.toDouble());
    super.initState();
  }
  List it = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top:80.0),
                  child: Container(
                    child: Column(
                      children: List.generate(
                        item.length,
                        (index) => Align(
                          alignment: Alignment.center,
                          child: GetBoxOffse(
                            offset: (offset) {
                              item[index] = offset.dy;
                            },
                            child:Column(
                              children: [
                                Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                  child: Row(
                                    children: [
                                      Text('${ml[index].keys}'),
                                    ],
                                  ),
                                ),
                                index!=1?ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  dragStartBehavior: DragStartBehavior.start,

                                  shrinkWrap: true,
                                  semanticChildCount: ml[index]['${ml[index].keys.toString().replaceAll('(', '').replaceAll(')', '')}'].length,
                                  scrollDirection: Axis.vertical,

                                  padding: EdgeInsets.all(0),
                                  itemCount: ml[index]['${ml[index].keys.toString().replaceAll('(', '').replaceAll(')', '')}'].length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            // height: 10,//Get.height * 0.0533,
                                            width: double.infinity,
                                            child: Card(
                                              color: i == 1 || i == 3 || i == 5
                                                  ? Colors.yellow.shade100
                                                  : Colors.yellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                    '${ml[index]["${ml[index].keys.toString().replaceAll('(', '').replaceAll(')', '')}"][i]}',
                                                    // style: subtitle.copyWith(color: white),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ):Text('asdfg'),
                              ],
                            )
                            // Container(
                            //   margin: const EdgeInsets.all(8),
                            //   height: 300,
                            //   width: 600,
                            //   color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            //   child: Center(
                            //       child: Text("Card Index $index", style: TextStyle(color: Colors.white, fontSize: 18))),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: List.generate(
                        item.length,
                        (index) => Expanded(
                          child: InkWell(
                            onTap: () {
                              scrollController!.animateTo(item[index],
                                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              color: Colors.white,
                              child: Center(child: Text("${ml[index].keys}", style: TextStyle(fontSize: 18))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
