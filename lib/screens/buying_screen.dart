import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dit_mca_store/models/product.dart';
import 'package:dit_mca_store/providers/providers.dart';
import 'package:dit_mca_store/widgets/single_list_tile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyingScreen extends ConsumerWidget {
  const BuyingScreen({Key? key}) : super(key: key);

  // Future<int> calculateTotalPrice(List<int> cartItems) async {
  //   int totalPrice = 0;
  //   for (final ci in cartItems) {
  //     DocumentSnapshot ds = await FirebaseFirestore.instance
  //         .collection("products")
  //         .doc("${ci}")
  //         .get();
  //     totalPrice += ds.data!.data()["price"] as int;
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.read(cartItemsProvider);
    List<Widget> list = cartItems.map<Widget>((productId) {
      return SingleListTile(productId: productId);
    }).toList();

    int totalPrice = 0;

    // ref.listen();

    // for(final w in list){
    //   totalPrice +=
    // }

    list.add(SizedBox(height: 20));
    list.add(ListTile(
        title: Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(ref.watch(totalPriceProvider).toString())));

    list.add(SizedBox(height: 20));
    list.add(ListTile(
        title: Text("BALANCE", style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(ref.watch(balanceProvider).toString(),
            style: TextStyle(color: Colors.green[900]))));
    return Scaffold(
      appBar: AppBar(title: Text("Buy Screen")),
      body: ListView(
        children: list,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomSheet: Text("Bottom Sheet"),
      // bottomNavigationBar: Text("Bottom Navigation"),
      floatingActionButton: ElevatedButton(
          child: Text("Pay"),
          onPressed: () {
            
            


          }),
    );
  }
}
