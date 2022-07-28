import 'package:flutter/material.dart';
import 'package:flutter_app1/main_page/SidepageView.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
enum Status { Waiting, Error }

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, this.MobileNo}) : super(key: key);
  final MobileNo;
  @override
  State<OtpPage> createState() => _OtpPageState(this.MobileNo);
}

class _OtpPageState extends State<OtpPage> {
  final Phoneno;
  var _status = Status.Waiting;
  var verficationid;
  var _textEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  _OtpPageState(this.Phoneno);
  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: Phoneno,
        verificationCompleted: (PhoneAuthCredential) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verficationid, resendingToken) async {
          setState(() {
            this.verficationid = verficationid;
          });
        },
        codeAutoRetrievalTimeout: (verficationid) async {});
  }

  Future _sendCodetoFireBase({String? code}) async {
    if (verficationid != null ) {
      var credential = PhoneAuthProvider.credential(
          verificationId: verficationid, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SidepageViewer()));
          })
          .whenComplete(() {})
          .onError((error,stackTrace) {
            setState(() {
              _textEditingController.text = "";
              _status = Status.Error;
              
            });
          })
          ;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: _status != Status.Error
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "OTP Verification".text.xl4.bold.make(),
                          Text(Phoneno == Null ? " " : Phoneno),
                        
                          TextField(
                            controller: _textEditingController,
                            maxLength: 6,
                            onChanged: (value) async {
                              if (value.length == 6) {
                                await _sendCodetoFireBase(code: value);
                              }
                            },
                            style:  const TextStyle(
                              letterSpacing: 30,
                              fontSize: 30,
                              decorationThickness:5,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          "Didn't Recieve OTP ?".text.xl2.make(),
                          TextButton(
                              onPressed: () async {
                                setState(() {
                                  _status = Status.Waiting;
                                });
                                _verifyPhoneNumber();
                              },
                              child: "Resend OTP".text.xl3.red300.make()),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "OTP Verification".text.xl4.bold.make(),
                          const SizedBox(
                            height: 30,
                          ),
                          "***Code is Invalid***".text.xl3.red800.make(),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(
                                                  255, 238, 235, 235)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      )),
                                  onPressed: () => Navigator.pop(context),
                                  child: "Edit Number".text.xl3.make())
                              .p12(),
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 238, 235, 235)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )),
                              onPressed: () {
                                setState(() {
                                  _status = Status.Waiting;
                                });
                                _verifyPhoneNumber();
                              },
                              child: "Resend Otp".text.xl3.make()),
                        ],
                      ),
                    ))
          .p12(),
    );
  }

  // void ListenOtp() async {
  //   await SmsAutoFill().listenForCode();
  // }
}
