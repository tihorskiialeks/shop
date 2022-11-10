import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import 'package:shop/screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../provider/cart.dart';
import '../widgets/bage.dart';

import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorite = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Shop',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectValue) {
              setState(() {
                if (selectValue == FilterOptions.Favorites) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show all'),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Bage(
              value: cart.itemCount.toString(),
              color: Theme.of(context).primaryColor,
              child: ch!,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(
              showFavs: _showOnlyFavorite,
            ),
    );
  }
}
