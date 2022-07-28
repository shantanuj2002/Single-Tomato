import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_pro.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final Future<LottieComposition> _composition;
  @override
  void initState() {
    super.initState();
    _composition = _loadcomposition();
  }

  Future<LottieComposition> _loadcomposition() async {
    var assetdata = await rootBundle.load('assets/95592-preparing-food.json');
    return await LottieComposition.fromByteData(assetdata);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(children: [
            Lotieani(context),
            SizedBox(
              height: 36,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Welcome to ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              "Single-Tomato".text.red500.bold.italic.xl3.make(),
              CircleAvatar(
                child: Image.asset("assets/app_logo1.png"),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<googleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: ClipRRect(
                  child: Image.asset(
                    "assets/googlelogo.png",
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                label: "Google Sign in".text.xl2.make())
          ]),
        ),
      ),
    );
  }

  Widget Lotieani(BuildContext context) {
    return FutureBuilder<LottieComposition>(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) {
            return Lottie(composition: composition);
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }
        });
  }
}
