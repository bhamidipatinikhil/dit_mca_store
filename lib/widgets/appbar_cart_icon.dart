import 'package:dit_mca_store/widgets/productTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dit_mca_store/providers/providers.dart';

class AppbarCartIcon extends StatelessWidget {
  const AppbarCartIcon({Key? key, required this.nCartItems}) : super(key: key);

  final int nCartItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(nCartItems.toString()),
        Text(nCartItems.toString()),
        Icon(Icons.shopping_cart),
      ],
    );
    ;
  }
}
