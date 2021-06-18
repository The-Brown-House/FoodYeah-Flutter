import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/products/product_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  late final String searchFieldLabel;
  late final List<Product> record;

  ProductSearchDelegate(this.searchFieldLabel, this.record);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            this.query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          this.close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) return buildSuggestions(context);

    final productProvider = new Products();

    return FutureBuilder(
      future: productProvider.getProductByName(query),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return _showProducts(snapshot.data);
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 50,
                  ),
                  Text(
                    "No se han encontrado productos",
                    style: GoogleFonts.varelaRound(fontSize: 20),
                  )
                ],
              ),
            );
          }
        } else {
          return Center(
            child: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(top: 40),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _showProducts(this.record);
  }

  Widget _showProducts(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, i) {
        final producto = products[i];

        return ListTile(
            title: Text(producto.name!),
            subtitle: Text('S/ ' + producto.price.toString()),
            trailing:
                CircleAvatar(backgroundImage: NetworkImage(producto.imageUrl!)),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetail.routeName, arguments: producto);
              this.record.insert(0, producto);
              final ids = this.record.map((e) => e.id).toSet();
              this.record.retainWhere((x) => ids.remove(x.id));
            });
      },
    );
  }
}
