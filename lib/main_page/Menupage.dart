import 'package:flutter/material.dart';
import 'package:flutter_app1/main_page/customize.dart';
import 'package:flutter_app1/main_page/unlimited.dart';


class MenuListPage extends StatefulWidget {
  
  final String userno;
  final String messno;
  const MenuListPage({Key? key, required this.userno, required this.messno})
      : super(key: key);
  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              text: "Customized",
              icon: Icon(Icons.dashboard_customize),
            ),
            Tab(
              text: "Unlimited",
              icon: Icon(Icons.drag_handle_rounded),
            ),
          ]),
        ),
        body: TabBarView(children: [
          CustomizedRate(),
          Unlimited(userno: widget.userno, messno: widget.messno)
        ]),
      ),
    );
  }
}
