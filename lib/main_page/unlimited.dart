import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Unlimited extends StatefulWidget {
  const Unlimited({Key? key, required this.userno, required this.messno})
      : super(key: key);
  final String userno;
  final String messno;

  @override
  State<Unlimited> createState() => _UnlimitedState();
}

class _UnlimitedState extends State<Unlimited> {
  // User11 user1;
  bool islike = false;
  bool repeatLike = true;
  late ConfettiController controller;
  @override
  void initState() {
    // User11 user1;
    controller = ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
    // Geolocator.requestPermission();
    // Geolocator.getCurrentPosition().then((value) => null);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection(widget.userno)
                .doc(widget.messno)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something Error");
              } else if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          actions: [buildLike(context)],
                          floating: true,
                          pinned: true,
                          expandedHeight: 250,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Image.network(
                              data['urlImage'],
                              fit: BoxFit.cover,
                            ),
                            title: Text(data['name']),
                          )),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildType(data['type']),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  buildTime(data['time'])
                                ],
                              ),
                              Card(
                                color: Colors.greenAccent[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(1),
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.percent,
                                    color: Colors.redAccent,
                                    size: 32,
                                  ),
                                  title: Text(data['offer']),
                                  subtitle: Text(data['code']),
                                ),
                              ),
                              buildRate(data['rate'])
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        data['menuImage'][index],
                                        fit: BoxFit.cover,
                                      )),
                                  title: Text(
                                    data['menuList'][index],
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  subtitle: Text(
                                    data['menusub'][index],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }, childCount: 6))
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
              //return CircularProgressIndicator();
            }),
      ),
      ConfettiWidget(
        confettiController: controller,
        shouldLoop: false,
        blastDirectionality: BlastDirectionality.explosive,
        emissionFrequency: 0.1,
        numberOfParticles: 12,
      ),
    ]);
  }

  Widget buildType(String type) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), border: Border.all()),
      child: Text(type,
          style: type == "Pure Veg"
              ? TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
              : TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildTime(String timerequire) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), border: Border.all()),
      child: Row(
        children: [Icon(Icons.timer), Text(timerequire)],
      ),
    );
  }

  void likefunc() {
    setState(() {
      islike = true;
      repeatLike = false;
    });
    if (islike && !repeatLike) {
      Timer(Duration(days: 1), () {
        setState(() {
          repeatLike = true;
          islike = false;
        });
      });
    }
  }

  Widget buildLike(BuildContext context) {
    return IconButton(
            iconSize: 40,
            onPressed: () {
              if (repeatLike) {
                var likecount =
                    FirebaseFirestore.instance.collection("user1").doc("mess1");
                likecount.update({"likes": FieldValue.increment(1)});
                controller.play();
              } else {
                null;
              }
              likefunc();
            },
            icon: islike
                ? const Icon(
                    Icons.favorite_outlined,
                    color: Colors.pink,
                  )
                : const Icon(
                    Icons.favorite_outlined,
                    color: Colors.white,
                  ))
        .px8();
  }

  Widget buildRate(int rate) {
    return Card(
      color: Colors.limeAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
              color: Colors.grey.withOpacity(1),
              width: 1,
              style: BorderStyle.solid)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            rate.toString() + '₹',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "(per Person)",
            textScaleFactor: 0.5,
            style: TextStyle(fontSize: 24),
          )
        ]),
      ),
    );
  }
}
