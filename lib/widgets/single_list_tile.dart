import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dit_mca_store/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleListTile extends ConsumerWidget {
  const SingleListTile({Key? key, required this.productId}) : super(key: key);

  final int productId;
  // int totalPrice = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = FirebaseFirestore.instance.collection('products');
    Random r = new Random();
    return FutureBuilder(
        future: products.doc("${productId}").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print("I ran 1");
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print("I ran 2");
            int price = data["price"];
            // totalPrice += price;
            // ref.read(totalPriceProvider.notifier).state += price;
            return ListTile(
                tileColor: Color.fromARGB(
                    150, r.nextInt(255), r.nextInt(255), r.nextInt(255)),
                title: Text(data["title"]),
                trailing: Text(price.toString()));
          }
          return Text("Loading");
        });
  }
}
