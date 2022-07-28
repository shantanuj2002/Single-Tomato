import 'package:flutter/material.dart';
class about_project extends StatefulWidget {
  const about_project({Key? key}) : super(key: key);

  @override
  State<about_project> createState() => _about_projectState();
}

class _about_projectState extends State<about_project> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Project",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Text("This app is made with intention to get more handy to flutter devlopement and Google Firebase.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text.rich(
                TextSpan(
                  text: "Frontend :",style: TextStyle(fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(text: "Flutter",style: TextStyle(fontSize: 20)),
                  ]
                )
              ),
              Text.rich(TextSpan(
                  text: "Backend :",style: TextStyle(fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(text: "Google Firebase",style: TextStyle(fontSize: 20)),
                  ]
                )),
                 Text.rich(TextSpan(
                  text: "State-Management :",style: TextStyle(fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(text: "GetX",style: TextStyle(fontSize: 20)),
                  ]
                )),
                Text("Features :",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                Text("All the features are backed by Firebase and can be updated in realtime ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text("1.Story-View",style: TextStyle(fontSize: 20)),
                Text("2.User Login and logout",style: TextStyle(fontSize: 20)),
                Text("3.New Restaurant and its features addition from backend",style: TextStyle(fontSize: 20)),
                Text("4.Order Tracking of User",style: TextStyle(fontSize: 20)),
                Text("5.Live Location service from User to Reastaurant",style: TextStyle(fontSize: 20)),
                Text("6.User Food-Cart Management",style: TextStyle(fontSize: 20)),
                Text("7. Realtime Like system for Reastaurant",style: TextStyle(fontSize: 20)),
                Text("In Progress Feature :",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                Text("1.Payment System",style: TextStyle(fontSize: 20)),
                
    
                
    
            ],
          ),
        ),
      ),
    );
  }
}