import 'dart:io';
import 'package:flutter/material.dart';
import 'package:management_factory_system/View/Containers/background.dart';
import 'package:management_factory_system/View/Main%20Pages/Add%20Pages/add_product.dart';
import 'package:management_factory_system/View/Main%20Pages/Add%20Pages/add_stock.dart';
import 'package:management_factory_system/View/Main%20Pages/Delete%20Pages/delete_product.dart';
import 'package:management_factory_system/View/Main%20Pages/Delete%20Pages/delete_stock.dart';
import 'package:management_factory_system/View/Main%20Pages/Display%20Pages/display_product.dart';
import 'package:management_factory_system/View/Main%20Pages/Display%20Pages/display_stock.dart';
import 'package:management_factory_system/View/Main%20Pages/Edit%20Pages/edit_product.dart';
import 'package:management_factory_system/View/Main%20Pages/Edit%20Pages/edit_stock.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final bool isOkay =
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  static const List<Widget> bodyPages = [
    AddStockPage(),
    EditStockPage(),
    DisplayStockPage(),
    DeleteStockPage(),
    AddProductPage(),
    EditProductPage(),
    DisplayProductPage(),
    DeleteProductPage()
  ];
  static const List<String> descriptions = [
    'From here, you may create a new sales invoice for what you\'ve sold.',
    'You may update past sales invoices that have been sold from your side by going to this page.',
    'You may search and view any sales invoices that you have sold from your side here.',
    'If you made a mistake in a previous sales invoice or would like to delete it in any way, you may do it from here.',
    'From here, you may create a new purchases invoice for what you\'ve sold.',
    'You may update past purchases invoices that have been sold from your side by going to this page.',
    'You may search and view any purchases invoices that you have sold from your side here.',
    'If you made a mistake in a previous purchases invoice or would like to delete it in any way, you may do it from here.',
  ];

  ListView bodyPage(BuildContext ctx) {
    return ListView(
      children: [
        const Center(
          child: Text('STOCK',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        buildFormatPage([
          createItem('add store', 'Add Stock', 0, ctx),
          createItem('edit store', 'Edit Stock', 1, ctx),
          createItem('display store', 'View Stock', 2, ctx),
          createItem('delete store', 'Delete Stock', 3, ctx),
        ], 0),
        Divider(
          color: Colors.black,
          thickness: isOkay ? 5 : 2,
          endIndent: 50,
          indent: 50,
        ),
        const Center(
          child: Text('PRODUCT',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        buildFormatPage([
          createItem('add product', 'Add Product', 4, ctx),
          createItem('edit product', 'Edit Product', 5, ctx),
          createItem('display product', 'View Product', 6, ctx),
          createItem('delete product', 'Delete Product', 7, ctx),
        ], 0),
      ],
    );
  }

  GridView buildFormatPage(List<Widget> items, int option) {
    return GridView(
        shrinkWrap: option == 0 ? true : false,
        padding: const EdgeInsets.all(50),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: isOkay ? 300 : 200,
            mainAxisExtent: isOkay ? 150 : 50,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: items);
  }

  Tooltip createItem(
      String pathImage, String nameMenu, int action, BuildContext ctx) {
    return Tooltip(
      message: descriptions[action],
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(100, 254, 255, 255)),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildImage(pathImage),
                  buildDiv(),
                  const SizedBox(width: 5),
                  buildText(nameMenu)
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(ctx)
              .push(MaterialPageRoute(builder: (_) => bodyPages[action]));
        },
      ),
    );
  }

  Container buildImage(String pathImage) {
    return Container(
        margin: const EdgeInsets.only(bottom: 25, left: 5, right: 0, top: 25),
        child: Image.asset('lib/Assets/Images/$pathImage.png'));
  }

  VerticalDivider buildDiv() {
    return VerticalDivider(
      color: const Color.fromARGB(255, 0, 0, 0),
      thickness: 1,
      endIndent: isOkay ? 70 : 40,
      indent: isOkay ? 70 : 40,
    );
  }

  Column buildText(String nameMenu) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(nameMenu,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(widget: bodyPage(context)).build();
  }
}
