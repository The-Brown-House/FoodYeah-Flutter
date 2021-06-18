import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/models/Order.dart';
import 'package:foodyeah/models/OrderDetail.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/models/QuoteDetail.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/providers/orders_provider.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/cart/cart_item.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen();

  static const routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    var productProvider = Provider.of<Products>(context);
    var orderProvider = Provider.of<Orders>(context);
    var customerProvider = Provider.of<Customers>(context);

    void createOrder() async {
      setState(() {
        loading = true;
      });
      var cart = cartProvider.items;
      if (cartProvider.itemCount > 0) {
        var customerdata = await customerProvider.getDataFromJwt();
        var customer =
            await customerProvider.getCustomerByEmail(customerdata['email']);
        QuoteDetail quoteDetails =
            new QuoteDetail(int.parse(customer.customerId!));

        List<OrderDetailCreateDto> details = [];
        cart.forEach((key, value) {
          OrderDetailCreateDto orderCreated = OrderDetailCreateDto(
              productId: int.parse(value.productId!), quantity: value.quantity);
          details.add(orderCreated);
        });

        CreateOrderDto createOrderDto = CreateOrderDto(
            int.parse(customer.customerId!), details, quoteDetails);
        orderProvider.createOrder(createOrderDto, context).then((value) {
          if (value) {
            cartProvider.clear();
            setState(() {
              loading = false;
            });
          } else {
            setState(() {
              loading = false;
            });
            return;
          }
        });
      } else {
        setState(() {
          loading = false;
        });
        NotificationService().showSnackbar(
            context, Messages().errorNoItemsInCart, "error", null);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Consumer<Cart>(
                      builder: (_, cart, child) => Chip(
                        label: Text('\S/${cart.totalAmount}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .color,
                            )),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        createOrder();
                      },
                      child: Text(
                        "Registre su orden",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Carrito de compras",
            ),
            if (loading)
              Container(
                padding: EdgeInsets.all(4),
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: cartProvider.itemCount > 0
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return FutureBuilder(
                          future: productProvider.getProductById(cartProvider
                              .items.values
                              .toList()[index]
                              .productId!),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                var product = snapshot.data as Product;

                                return CartItems(
                                    cartProvider.items.values
                                        .toList()[index]
                                        .productId!,
                                    cartProvider.items.values
                                        .toList()[index]
                                        .price!,
                                    cartProvider.items.values
                                        .toList()[index]
                                        .quantity!,
                                    product.name.toString(),
                                    product.imageUrl.toString());
                              } else {
                                return Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: Text("Load"),
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
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                      itemCount: cartProvider.itemCount,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(
                            Icons.remove_shopping_cart,
                            size: 50,
                          ),
                          Text(
                              "No ha agregado ningun producto al carrito de compras",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.varelaRound(fontSize: 25))
                        ]),
            ),
            Text("Deslizar hacia la izquierda para eliminar un producto",
                style: GoogleFonts.varelaRound(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
