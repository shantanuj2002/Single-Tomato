import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:story_view/story_view.dart';

class StoryPage1 extends StatefulWidget {
  const StoryPage1({Key? key}) : super(key: key);

  @override
  State<StoryPage1> createState() => _StoryPage1State();
}

class _StoryPage1State extends State<StoryPage1> {
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StoryList(context));
  }

  Widget StoryList(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('story').doc('media').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
                body: StoryView(
              controller: controller,
              storyItems: [
                StoryItem.pageImage(
                    url: data['image'],
                    controller: controller,
                    imageFit: BoxFit.cover),
                StoryItem.text(
                    title: data['text'],
                    backgroundColor: Color.fromARGB(255, 159, 50, 50),
                    textStyle:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                StoryItem.pageVideo(data['video'],
                    caption:"Share with your Friends",
                    controller: controller, duration: Duration(seconds: 3))
              ],
              progressPosition: ProgressPosition.bottom,
              inline: true,
              onComplete: () {
                Navigator.pop(context);
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
            ));
          }
          return Text("");
        });
  }
}
