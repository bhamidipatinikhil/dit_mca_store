// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// / import '../providers/providers.dart';



class Product {
  String? networkImagePath;
  String title;
  String description;
  int price;
  late int productId;
  String postedBy;

  Product(
      {this.networkImagePath = "",
      required this.title,
      required this.description,
      required this.price,
      required this.postedBy,
      required this.productId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'networkImagePath': networkImagePath,
      'title': title,
      'description': description,
      'price': price,
      'productId': productId,
      'postedBy': postedBy,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      networkImagePath: map['networkImagePath'] != null ? map['networkImagePath'] as String : "",
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      productId: map['productId'],
      postedBy: map['postedBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
