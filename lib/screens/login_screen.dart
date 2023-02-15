import 'package:dit_mca_store/screens/login_with_phone_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login Screen")),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 4),
                  color: Color.fromARGB(255, 255, 183, 3),
                ),
                // color: Colors.amber,
                // color: Colors.yellow,
                padding: const EdgeInsets.all(38.0),
                child: Center(
                  child: Text("Welcome to the Aakash Store Platform",
                      style:
                          TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => LoginWithPhoneScreen())
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Login with phone number"),
                        Icon(Icons.phone)
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
