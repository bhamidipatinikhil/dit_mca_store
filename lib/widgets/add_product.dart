import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dit_mca_store/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  File? imageFile;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  // TextEditingController titleController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Builder(builder: (context) {
              if (imageFile == null) {
                print("Image file is null");
                return Text("Press any of the 2 below buttons to add picture");
              } else {
                print("Image file is there");
                return Image.file(
                  imageFile!,
                  height: 320,
                );
              }
            }),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo_size_select_actual),
                  onPressed: () async {
                    XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1800,
                      maxHeight: 1800,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        imageFile = File(pickedFile.path);
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1800,
                      maxHeight: 1800,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        print(pickedFile.path);
                        imageFile = File(pickedFile.path);
                        // print(imageFile);
                      });
                    }
                  },
                ),
              ],
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  hintText: "Title",
                  labelText: "Enter the title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  hintText: "Description",
                  labelText: "Enter the Description"),
            ),
            TextField(
                controller: priceController,
                decoration: InputDecoration(
                    hintText: "Enter the Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))))),
            OutlinedButton(
                onPressed: () async {
                  if (int.tryParse(priceController.text) == null) {
                    return;
                  }
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  CollectionReference metaData =
                      firestore.collection('metaData');
                  late int currentNProducts;
                  await metaData
                      .doc('productsMetaData')
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    final tmpMap =
                        documentSnapshot.data() as Map<String, dynamic>;
                    print(tmpMap);
                    currentNProducts = (tmpMap['nProducts']) as int;
                    print("currentNProducts: " + currentNProducts.toString());
                  });
                  print(currentNProducts);
                  final storageRef = FirebaseStorage.instance.ref();
                  print(imageFile!.path);
                  print("${(currentNProducts).toString()}");
                  currentNProducts++;
                  await storageRef
                      .child("products/${(currentNProducts).toString()}/image")
                      .putFile(imageFile as File);

                  print("I ran 3");
                  // await Future.delayed(Duration(seconds: 3), () {
                  //   print("Finished waiting for 3 seconds");
                  // });
                  String? networkImagePath;
                  if (imageFile != null) {
                    networkImagePath = await storageRef
                        .child(
                            "products/${(currentNProducts).toString()}/image")
                        .getDownloadURL();
                  }
                  networkImagePath == null
                      ? print("Network image is null")
                      : print(networkImagePath as String);

                  String phoneNumber =
                      FirebaseAuth.instance.currentUser!.phoneNumber as String;
                  print(phoneNumber);
                  CollectionReference productsReference =
                      firestore.collection('products');

                  Navigator.pop(context);

                  firestore.collection('metaData').doc('productsMetaData').set(
                      {'nProducts': currentNProducts}, SetOptions(merge: true));

                  return productsReference.doc("${currentNProducts}").set({
                    'description': descriptionController.text,
                    'price': int.parse(priceController.text),
                    'productId': currentNProducts,
                    'title': titleController.text,
                    'networkImagePath': networkImagePath,
                    'postedBy': phoneNumber
                  }, SetOptions(merge: true)).then((value) {
                    print("Added data successfully");
                  }).catchError(
                      (error) => print("Failed to add data:: ${error}"));
                },
                child: Text("Add Your Product"))
          ],
        ),
      ),
    );
  }
}
