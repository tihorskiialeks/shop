import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductScreen({Key? key}) : super(key: key);
  Future<void> _refreshProducts(BuildContext context)async{
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);

  }

  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products!'),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        }, icon: const Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder:(ctx, snapshot)=> snapshot.connectionState==ConnectionState.waiting ?
        Center(child:
          CircularProgressIndicator(),):
        RefreshIndicator(
          onRefresh: ()=>_refreshProducts(context),
          child: Consumer<Products>(
            builder: (ctx, productData, _)=>Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      id: productData.items[i].id,
                      title: productData.items[i].title,
                      imgUrl: productData.items[i].imageUrl,
                    ),
                    Divider(),
                  ],
                ),
                itemCount: productData.items.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
