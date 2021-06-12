import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/products/product_detail.dart';

class ProductSearchDelegate extends SearchDelegate<Product>{

  @override
  late final String searchFieldLabel;
  late final List<Product> record;

  ProductSearchDelegate(this.searchFieldLabel, this.record);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon( Icons.clear ),
          onPressed: () {this.query = '';}
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: ()  {Navigator.of(context).pop();}
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0)
      return ListTile(title: Text('No hay datos de búsqueda'));

    final productProvider = new Products();

    return FutureBuilder(
      future: productProvider.getProductByName(query),
      builder: (_, AsyncSnapshot snapshot) {

        if (!snapshot.hasData)
          return ListTile(title: Text('No tenemos platillos con ese término'));

        if (snapshot.hasData)
          return _showProducts(snapshot.data);

        else
          return Center(child: CircularProgressIndicator( strokeWidth: 4 ));
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
      itemBuilder: (context , i) {

        final producto = products[i];

        return ListTile(
          title: Text(producto.name!),
          subtitle: Text('S/ ' + producto.price.toString()),
          trailing: CircleAvatar(backgroundImage: NetworkImage(producto.imageUrl!)),
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.routeName, arguments: producto);
          },
        );
      },
    );

  }
}