import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

import '../provider/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Consumer<Product>(
      builder: (ctx, product, child) => ClipRRect(
        //чтобы округлить края, мы упаковываем Гридтайл в КлипРРект, который имеет бордер радиус
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            //полоска с кнопками и текстом внизу категории
            backgroundColor: Colors.black87,
            // черный с прозрачным задний фон полоски
            leading: IconButton(
              //Лидинг - то что перед титулом в данном сл иконка
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              }, // действие, выполненное после нажатия (пока пустое)
            ),
            title: Text(
              // титул - по середине ГридБара (в данном случае текст - тайтл - переменная данного класса
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              // Трейлинг - картинка, после текста
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    'Added item to the cart',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeOneItem(product.id);
                      }),
                ));
              },
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
