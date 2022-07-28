import 'package:flutter/material.dart';
import 'package:flutter_app1/provider/google_sign_pro.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class GoogleSignWidget extends StatefulWidget {
  const GoogleSignWidget({ Key? key }) : super(key: key);

  @override
  State<GoogleSignWidget> createState() => _GoogleSignWidgetState();
}

class _GoogleSignWidgetState extends State<GoogleSignWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:SafeArea(
        child: Center(
          child: Column(
            children: [
            "Welcome to Tomato".text.bold.xl.make(),
            ElevatedButton.icon(onPressed: (){
              final provider=Provider.of<googleSignInProvider>(context,listen: false);
              provider.googleLogin();
              
            }, icon: FaIcon(FontAwesomeIcons.google), label:"Google Sign in".text.make())
            ],
          ),
        ),
      )
    );
  }
}