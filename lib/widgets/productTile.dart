import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dit_mca_store/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod/riverpod.dart';
import '../models/product.dart';

class ProductTile extends ConsumerWidget {
  ProductTile({super.key, required this.product});
  Product product;

  // Function updateNCartItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        elevation: 10,
        color: Colors.amber,
        child: Stack(
          children: [
            SizedBox(
                width: 200,
                height: 200,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("${product.title}"),
                                  content: ListView(children: [
                                    Image.network(product.networkImagePath!,
                                        height: 500),
                                    SizedBox(height: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2)),
                                      child: Text(product.description,
                                          style: TextStyle(fontSize: 24)),
                                    ),
                                    SizedBox(height: 5),
                                    Text("Price:: ${product.price} aakus",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontStyle: FontStyle.italic))
                                  ]));
                            });
                      },
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Builder(
                                builder: (context) =>
                                    (product.networkImagePath == "" ||
                                            product.networkImagePath == null)
                                        ? Icon(
                                            Icons.photo_size_select_actual,
                                            size: 100,
                                          )
                                        : Image.network(
                                            product.networkImagePath!,
                                            height: 100),
                              ),
                            ),
                            Text(product.productId.toString()),
                            Text(product.title,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Builder(builder: (context) {
                              if (product.description.length > 10) {
                                return Text(
                                    product.description.substring(0, 10) +
                                        "...");
                              }
                              return Text(
                                product.description,
                              );
                            }),
                            Builder(builder: (context) {
                              String toDisplay =
                                  "${product.price.toString()} aakus";
                              if (toDisplay.length > 12) {
                                return Text(toDisplay.substring(0, 7),
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic));
                              }
                              return Text("Price:: ${product.price} aakus",
                                  style:
                                      TextStyle(fontStyle: FontStyle.italic));
                            })
                          ]),
                    ))),
            SizedBox(
                width: 200,
                height: 200,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Color.fromARGB(105, 233, 255, 112)),
                          child: IconButton(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                print("Add button pressed");

                                if (!ref
                                    .read(cartItemsProvider)
                                    .contains(product.productId)) {
                                  ref
                                      .read(cartItemsProvider.notifier)
                                      .state
                                      .add(product.productId);

                                  ref.read(nCartItemsProvider.notifier).state++;
                                }

                                ref.read(totalPriceProvider.notifier).state +=
                                    product.price;

                                // ref.read(nCartItemsProvider) = ref.read(nCartItemsProvider) + 1;
                              }),
                        ),
                      ),
                      SizedBox(width: 90),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Color.fromARGB(105, 233, 255, 112)),
                          child: IconButton(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                print("Delete button pressed");
                              }),
                        ),
                      ),
                    ])),
          ],
        ));
  }
}
