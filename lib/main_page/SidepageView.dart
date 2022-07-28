
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/main_page/Menupage.dart';
import 'package:flutter_app1/main_page/unlimited.dart';
import 'package:flutter_app1/pages/StoryPage1.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Loggedin.dart';
import '../pages/StoryPage1.dart';

class SidepageViewer extends StatefulWidget {
  const SidepageViewer({Key? key}) : super(key: key);
  @override
  State<SidepageViewer> createState() => _SidepageViewerState();
}

class _SidepageViewerState extends State<SidepageViewer> {
  final pagecontroller = PageController();
  final customer = FirebaseAuth.instance.currentUser!;
  late List urlimages;
  bool flag = true;
  void initState() {
    // controller = ConfettiController(duration: const Duration(seconds: 1));
    // controller.addListener(() {
    //   setState(() {
    //     isplay = controller.state == ConfettiControllerState.playing;
    //   });
    // });
    //
    //controller.play();
    super.initState();
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition().then((value) => null);
  }

  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: buildStoryButton(),
          title: "Single-Tomato".text.red500.bold.italic.xl3.make(),
          centerTitle: false,
          actions: [
            buildCustomerPhoto(),
          ]),
      // drawer: buildList(context),
      body: buildList(context),
      // bottomSheet: Container(
      //   decoration: const BoxDecoration(
      //       color: Colors.orange,
      //       borderRadius: BorderRadius.all(Radius.circular(4))),
      //   margin: EdgeInsets.symmetric(horizontal: 4),
      //   height: 40,
      //   child: Center(
      //     child: SmoothPageIndicator(
      //         controller: pagecontroller,
      //         count: 6,
      //         effect: const WormEffect(
      //             spacing: 20,
      //             dotColor: Colors.white,
      //             activeDotColor: Colors.blueAccent),
      //         onDotClicked: (index) => pagecontroller.animateToPage(index,
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.easeIn)),
      //   ),
      // ),
      //     TextButton(
      //         onPressed: () {
      //           pagecontroller.nextPage(
      //               duration: const Duration(milliseconds: 500),
      //               curve: Curves.easeIn);
      //         },
      //         child: Row(
      //           children: const [Text("Next"), Icon(Icons.navigate_next)],
      //         ))
      //   ]),
      // ),
    );
  }

  Widget buildStoryButton() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => StoryPage1()));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
  radius: 48,
  backgroundColor: Colors.red,
  child: Padding(
    padding: const EdgeInsets.all(4), // Border radius
    child: ClipRRect(child: Image.asset("assets/app_logo1.png"),borderRadius: BorderRadius.circular(42),),
  ),
),
        )
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        HotelList(context, "user1", "mess1"),
        HotelList(context, "user2", "mess2"),
        HotelList(context, "user3", "mess3"),
        HotelList(context, "user4", "mess4")
      ]),
    );
  }

  Widget buildCustomerPhoto() {
    return IconButton(
      iconSize: 56,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoggedIn()));
        },
        icon: CircleAvatar(
          radius: 56,
          backgroundImage: NetworkImage(customer.photoURL!),
        ));
  }

  Widget buildImage(int index, String urlImage) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
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

  Widget HotelList(BuildContext context, String user, String mess) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection(user).doc(mess).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final urlimages = [
              data['urlImage'],
              data['urlImage2'],
              data['urlImage3']
            ];
            return SizedBox(
              height: MediaQuery.of(context).size.height * (0.53),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                        color: Colors.grey.withOpacity(1),
                        width: 1,
                        style: BorderStyle.solid)),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shadowColor: Colors.blueAccent,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider.builder(
                        itemCount: urlimages.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlimage = urlimages[index];
                          return buildImage(index, urlimage);
                        },
                        options: CarouselOptions(
                            height: 175,
                            autoPlay: true,
                            viewportFraction: 1,
                            autoPlayInterval: Duration(seconds: 5))),
                    Divider(),
                    ListTile(
                      title: Text(
                        data['name'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Column(
                        children: [
                         Text(data["rating"].toString(),style: TextStyle(fontWeight: FontWeight.bold),) ,
                          Icon(Icons.star,color: Colors.amberAccent,),
                        ],
                      ),
                      subtitle: Text(data['address']),
                      leading: CircleAvatar(
                        radius: 24,
                        child: Text(data['activity']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Likes :" + data['likes'].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.pinkAccent,
                          ),
                          Spacer(),
                          buildType(data['type']),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          iconSize: 32,
                          onPressed: () async {
                            var olocation =
                                await Geolocator.getCurrentPosition();
                            if (await MapLauncher.isMapAvailable(
                                    MapType.google) ==
                                true) {
                              MapLauncher.showDirections(
                                  mapType: MapType.google,
                                  destination: Coords(
                                      data['latitude'], data['longitude']),
                                  origin: Coords(
                                      olocation.latitude, olocation.longitude));
                            }
                          },
                          icon: const Icon(
                            Icons.gps_fixed,
                            color: Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Unlimited(userno: user, messno: mess)));
                          },
                          child: Text(
                            "Unlimited " + data['rate'].toString() + '₹',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuListPage(
                                          userno: user,
                                          messno: mess,
                                        )));
                          },
                          child:
                              Text( "Customize", style: TextStyle(fontSize: 18)
                               
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Text("");
        });
  }
}
