import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_provider.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final products = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),

      body: products.when(

        data: (data) {

          return ListView.builder(
            itemCount: data.length,

            itemBuilder: (_, index) {

              return ListTile(
                title: Text(
                  data[index]["name"],
                ),
              );
            },
          );
        },

        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (e, _) => Center(
          child: Text(
            e.toString(),
          ),
        ),
      ),
    );
  }
}