import 'package:dit_mca_store/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:dit_mca_store/screens/login_with_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditCard extends ConsumerWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";

    return Container(
        color: Colors.grey[700],
        padding: EdgeInsets.all(5),
        height: 350,
        child: Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.pink, Colors.purple])),
            child: Column(children: [
              SizedBox(height: 2),
              Text("CREDIT CARD",
                  style: GoogleFonts.exo2(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.normal))),
              SizedBox(height: 20),
              Text("6375  1308  0410  1490",
                  style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 2))),
              SizedBox(height: 20),
              Divider(height: 15, thickness: 15, color: Colors.grey[900]),
              SizedBox(height: 20),
              ListTile(
                tileColor: Colors.blue,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("CVV",
                        style: GoogleFonts.play(
                            textStyle: TextStyle(fontWeight: FontWeight.bold))),
                    Text("704",
                        style: GoogleFonts.play(
                            textStyle: TextStyle(fontStyle: FontStyle.italic)))
                  ],
                ),
              ),
              ListTile(
                  tileColor: Colors.deepPurple,
                  title: Text("BALANCE",
                      style:
                          GoogleFonts.teko(textStyle: TextStyle(fontSize: 20))),
                  trailing: Text(ref.watch(balanceProvider).toString(),
                      style: GoogleFonts.abrilFatface())),
              SizedBox(height: 10),
              Text(phoneNumber.toString(),
                  style: GoogleFonts.aboreto(
                      textStyle: TextStyle(
                          letterSpacing: 2, fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Text("Issued by Sanga Inc.",
                  style:
                      GoogleFonts.satisfy(textStyle: TextStyle(fontSize: 24)))
            ])));
  }
}
