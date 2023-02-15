import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dit_mca_store/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

String phoneNumber = "";

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  TextEditingController _phoneNumberEditingController =
      new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  String otp = "";
  dynamic _firebaseUser = "";
  dynamic _status = "";

  dynamic _phoneAuthCredential = "";
  dynamic _verificationId = "";
  dynamic _code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntlPhoneField(
          controller: _phoneNumberEditingController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
        ),
        SizedBox(height: 30),
        ElevatedButton(
            onPressed: () async {
              phoneNumber =
                  "+91 " + _phoneNumberEditingController.text.toString().trim();

              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phoneNumber,
                verificationCompleted: (PhoneAuthCredential credential) {
                  print('verificationCompleted');
                  setState(() {
                    _status += 'verificationCompleted\n';
                  });
                  this._phoneAuthCredential = credential;
                  print(credential);
                },
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  this._verificationId = verificationId;
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text("Enter OTP"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _otpController,
                                  decoration: InputDecoration(
                                    labelText: 'OTP',
                                  )),
                              Center(
                                  child: ElevatedButton(
                                      child: Text("Submit"),
                                      onPressed: () async {
                                        otp = _otpController.text
                                            .toString()
                                            .trim();
                                        this._phoneAuthCredential =
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    this._verificationId,
                                                smsCode: otp);
                                        await FirebaseAuth.instance
                                            .signInWithCredential(
                                                this._phoneAuthCredential)
                                            .then(
                                          (dynamic authRes) {
                                            _firebaseUser = authRes.user;
                                            print(_firebaseUser.toString());
                                          },
                                        );

                                        bool userAlreadyAuthenticated = false;

                                        CollectionReference users =
                                            FirebaseFirestore.instance
                                                .collection('users');

                                        await users
                                            .doc(phoneNumber.toString())
                                            .get()
                                            .then((snapshot) {
                                          if (snapshot.exists) {
                                            userAlreadyAuthenticated = true;
                                          }
                                        });

                                        if (!userAlreadyAuthenticated) {
                                          await users
                                              .doc(phoneNumber.toString())
                                              .set({
                                            'name': "",
                                            'balance': 1000,
                                            'boughtProducts': [],
                                            'postedProducts': []
                                          });
                                        }
                                        

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return HomeScreen();
                                        }));
                                      }))
                            ],
                          ),
                        ));
                  });
            },
            child: Text("Generate OTP"))
      ],
    ));
  }
}
