import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/about_project.dart';
import 'package:flutter_app1/pages/splash.dart';
import 'package:flutter_app1/provider/google_sign_pro.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  Future<void>? launching;
  @override
  Widget build(BuildContext context) {
    final customer = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "User Info",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(customer.photoURL!),
              ),
              Text(
                customer.displayName!,
                style: const TextStyle(fontSize: 24),
              ),
               SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email_outlined),
                  Text(customer.email!,style:TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text("Customer Id", style: TextStyle(fontSize: 20)),
              Text(
                customer.uid,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              buildLogout(context),
              Spacer(),
              devlopersContact()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogout(BuildContext context) {
    return TextButton(
        onPressed: () {
          final provider =
              Provider.of<googleSignInProvider>(context, listen: false);
          provider.logout();
          // Navigator.push(context,MaterialPageRoute(builder:(context)=>SplashPage()));
          Navigator.pop(context);
        },
        child: Text(
          "Log Out",
          style: TextStyle(fontSize: 20),
        ));
  }

  Widget devlopersContact() {
    return Container(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            
            borderRadius: BorderRadius.circular(8)
          ),
          child: TextButton.icon(
            
           
            onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => about_project()));
          } , icon: Icon(Icons.details,size: 20,), label: Text("Project Details",style: TextStyle(fontSize: 20),)),
        ),
        "Devloped by: Shantanu Joshi".text.xl2.make(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Link(
              uri: Uri.parse("https://twitter.com/shantanuj2002"),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return IconButton(
                    onPressed: openLink,
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    iconSize: 32,);
              }),
          Link(
              uri: Uri.parse(
                  "https://www.linkedin.com/in/shantanu-joshi-3a0a89208/"),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return IconButton(
                    onPressed: openLink,
                    icon: FaIcon(FontAwesomeIcons.linkedinIn,),iconSize: 32,);
              }),
          IconButton(
            onPressed: () => setState(() {
              launching = mail("joshishantanu21@gmail.com");
            }),
            icon: Icon(Icons.mail),
            iconSize: 32,
          ),
          FutureBuilder(
            future: launching,
            builder: _launchmail,
          )
        ])
      ],
    ));
  }

  Widget _launchmail(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> mail(String mailadress) async {
    final Uri launch = Uri(scheme: 'mailto', path: mailadress);
    await launchUrl(launch);
  }
}
