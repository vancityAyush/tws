import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tws/apiService/AppConstant.dart';
import 'package:tws/apiService/apimanager.dart';
import 'package:tws/apiService/sharedprefrence.dart';

class OtpScreen extends StatefulWidget {
  final String phone, otp;

  OtpScreen({this.phone, this.otp});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoad = false;
  bool _isLoadResend = false;
  String currentText = "", otp;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  var onTapRecognizer;
  final _formKey = GlobalKey<FormState>();

  _trySubmit() async {
    otp = await SharedPrefManager.getPrefrenceString(AppConstant.OTP);
    final isValid = _formKey.currentState.validate();
    if (currentText.length != 4) {
      errorController
          .add(ErrorAnimationType.shake); // Triggring error shake animation
      setState(() {
        hasError = true;
      });
    } else {
      if (currentText != otp.toString()) {
        errorController.add(ErrorAnimationType.shake);
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please input valid OTP"),
          duration: Duration(milliseconds: 1500),
        ));
      } else {
        FocusScope.of(context).unfocus();
        if (isValid) {
          _formKey.currentState.save();
          setState(() {
            _isLoad = true;
          });
          await Provider.of<ApiManager>(context, listen: false)
              .verifyOtp(widget.phone, otp);
          setState(() {
            _isLoad = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Verification Code",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25 * MediaQuery.of(context).textScaleFactor,
                          color: Color(0XFF24A19B),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 3),
                        child: Text(
                          "Please type the verification code sent to +9810441232",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  15 * MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 65, right: 65),
                          child: PinCodeTextField(
                            backgroundColor: Colors.black,
                            length: 4,
                            textStyle: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            autoDismissKeyboard: true,
                            animationType: AnimationType.fade,
                            validator: (text) {
                              if (text.length < 4) {
                                return "Please input valid OTP.";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                selectedColor: Colors.grey,
                                selectedFillColor: Colors.transparent,
                                activeFillColor: Colors.transparent,
                                activeColor: Colors.grey,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 60,
                                fieldWidth: 42,
                                inactiveColor: Colors.grey,
                                inactiveFillColor: Colors.transparent),
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            // controller: textEditingController,
                            onCompleted: (v) {},
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            appContext: context,
                          ),
                        ),
                        if (_isLoadResend)
                          CircularProgressIndicator()
                        else
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                _isLoadResend = true;
                              });
                              await Provider.of<ApiManager>(context,
                                      listen: false)
                                  .resendApi();
                              setState(() {
                                _isLoadResend = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 65),
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Proxima Nova",
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 15 *
                                          MediaQuery.of(context)
                                              .textScaleFactor),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_isLoad)
                    CircularProgressIndicator()
                  else
                    GestureDetector(
                      onTap: _trySubmit,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 45,
                        child: Center(
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                fontSize:
                                    21 * MediaQuery.of(context).textScaleFactor,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0XFF299FAB),
                        ),
                      ),
                    )
                ],
              ),
              Positioned(
                  left: 15,
                  top: 18,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
