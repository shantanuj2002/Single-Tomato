import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/OtpPage.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var nameController = TextEditingController();
  String number = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 6),
          "Welcome to Unltd".text.bold.rose600.xl4.makeCentered(),
          const SizedBox(
            height: 24,
          ),
          userName(),
          const SizedBox(
            height: 24,
          ),
          mobileNo(),
          const SizedBox(
            height: 24,
          ),
          getOtp(),
        ],
      ).p12()),
    );
  }

  Widget getOtp() => ElevatedButton(
        onPressed: () async {
          //final signinCode = await SmsAutoFill().getAppSignature;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpPage(MobileNo: number)));
        },
        child: "Get Otp".text.bold.xl4.make(),
      ).h(50).wFull(context).cornerRadius(10);
  Widget mobileNo() => TextFormField(
        onChanged: (value) => setState(() {
          number = "+91" + value;
        }),
        
        decoration: const InputDecoration(
          labelText: "Mobile number",
          hintText: "Mobile Number",
          errorText: "*10 digit Mobile number",
          prefixIcon: Icon(Icons.phone_android),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      );
  Widget userName() => TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          labelText: "Name",
          hintText: "Enter a name",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
      );
}
