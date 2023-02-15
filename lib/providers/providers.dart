import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dit_mca_store/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// int productId = 0;

// final productIdProvider = StateProvider<int>((ref) {
//   return productId;
// });

// final productsProvider = StateProvider<List<Product>>((ref) {
//   return [];
// });

// final cartItemsProvider = Provider<List<int>>((ref) {
//   return [];
// });

final cartItemsProvider = StateProvider<List<int>>((ref) {
  return [];
});

final nCartItemsProvider = StateProvider<int>((ref) {
  return 0;
});

final totalPriceProvider = StateProvider<int>((ref) {
  // ref.listen(cartItemsProvider, (a, b) {});

  return 0;
});

// final balanceProvider = StateProvider<int>((ref) {
//   return 1000;
// });

final balanceProvider = StreamProvider<int>((ref) async* {
  String phoneNumber =
      await FirebaseAuth.instance.currentUser!.phoneNumber ?? "";
  Stream documentStream = FirebaseFirestore.instance
      .collection('users')
      .doc(phoneNumber)
      .snapshots();

      
  return;
});
