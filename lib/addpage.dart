import 'package:flutter/material.dart';
import 'package:offline_product_app/databasehelper.dart';

import 'model/model.dart';

class addpage extends StatefulWidget {
  @override
  State<addpage> createState() => _addpageState();
}

class _addpageState extends State<addpage> {
  TextEditingController Cname = TextEditingController();

  TextEditingController Cauthor = TextEditingController();

  TextEditingController Cimage = TextEditingController();

  TextEditingController Cpublishdate = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding page"),
      ),
      // body: Form(
      //     key: _formkey,
      //     child: Column(
      //       children: [
      //         //name, author , image, publishdate

      //         TextFormField(
      //           controller: Cname,
      //           decoration: InputDecoration(labelText: "Book Name"),
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return "Please enter Book name";
      //             }
      //             return null;
      //           },
      //         ),

      //         // TextFormField(
      //         //   controller: Cauthor,
      //         //   decoration: InputDecoration(labelText: "Author Name"),
      //         //   validator: (value) {
      //         //     if (value == null || value.isEmpty) {
      //         //       return "Please enter Author name";
      //         //     }
      //         //     return null;
      //         //   },
      //         // ),

      //         // TextFormField(
      //         //   controller: Cimage,
      //         //   decoration: InputDecoration(labelText: "Book Image"),
      //         //   validator: (value) {
      //         //     if (value == null || value.isEmpty) {
      //         //       return "Please enter Book url  name";
      //         //     }
      //         //     return null;
      //         //   },
      //         // ),

      //         // TextFormField(
      //         //   controller: Cpublishdate,
      //         //   decoration: InputDecoration(labelText: " Publish Date"),
      //         //   validator: (value) {
      //         //     if (value == null || value.isEmpty) {
      //         //       return "Please enter publish date";
      //         //     }
      //         //     return null;
      //         //   },
      //         // ),

      //         ElevatedButton(
      //             onPressed: () {
      //               if (_formkey.currentState!.validate()) {
      //                 Databasehelper.Instance.addProduct(Product(
      //                     title: "iphone" + Random().nextInt(10).toString(),
      //                     description: "This is discription"));
      //               }
      //               Navigator.pop(context);
      //             },
      //             child: Text("Save"))
      //       ],
      //     )),
    );
  }
}
