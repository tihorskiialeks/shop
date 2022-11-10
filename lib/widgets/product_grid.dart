import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid({super.key, required this.showFavs});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
        context); // провайдер оф мы слушаем <дженерик> что изменилось в данном случае в продактс
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // говорит о том, сколько колонок мы хотим, в д.случае 2
        childAspectRatio: 3 / 2,
        // соотношение сторон, должно быть в ширину меньше, чем в длину
        crossAxisSpacing: 10,
        // расстояние между колонками 10пикселей
        mainAxisSpacing: 10, //расстояние между рядками 10пикселей
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
