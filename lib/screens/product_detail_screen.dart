import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  static const routeName = 'product-detail';

  const ProductDetailScreen({
    Key? key,
    // required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments
        as String; // Таким образом мы получаем id товара, которое мы передали в продакт айтем ж.детектор как аргумент

    final loadedProduct = Provider.of<Products>(
      context,
      listen:
          false, // значит, что виджет не будет перестраиваться при изменениях
    ).findById(
        productId); //выбирает тот продутк у которого айди совпадет с тем, с которого пришел на эту страницу (findById-метод, вынесен как бизнес-логика в продактс)

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${loadedProduct.price}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 800,)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
