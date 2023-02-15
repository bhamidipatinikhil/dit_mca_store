import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dit_mca_store/models/product.dart';
import 'package:dit_mca_store/screens/buying_screen.dart';
import 'package:dit_mca_store/widgets/add_product.dart';
import 'package:dit_mca_store/widgets/appbar_cart_icon.dart';
import 'package:dit_mca_store/widgets/credit_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
import '../providers/providers.dart';
// import '../models/product.dart';
import '../widgets/productTile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int nCartItems = 0;
  File? imageFile;
  String title = "";
  String description = "";
  int price = 0;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          width: 250,
        ),
        endDrawer: Drawer(
            width: 250,
            backgroundColor: Colors.brown[200],
            child: ListView(
                padding: EdgeInsets.all(7),
                children: [SizedBox(height: 50), CreditCard()])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AddProduct())));
            }),
        appBar: AppBar(
            title: Text("Store"),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      // print(ref.read(productsProvider).length);
                      print(ref.read(cartItemsProvider).length.toString());
                    });
                  }),
              IconButton(
                  icon: AppbarCartIcon(
                    nCartItems: ref.watch(nCartItemsProvider),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyingScreen(),
                        ));
                  }),
              IconButton(
                icon: CircleAvatar(child: Icon(Icons.person)),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              )
            ]),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return GridView.count(
                crossAxisCount: 2,
                children: snapshot.data!.docs
                    .map<Widget>((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  // String networkImagePath = ;
                  Product tmpProduct = Product(
                    title: data["title"],
                    description: data["description"],
                    price: data["price"],
                    postedBy: data["postedBy"],
                    networkImagePath: data['networkImagePath'],
                    productId: data["productId"],
                  );
                  print(tmpProduct.productId);
                  // int tmpProductId =
                  return ProductTile(product: tmpProduct);
                }).toList());
          },
        ));
    ;
  }
}
