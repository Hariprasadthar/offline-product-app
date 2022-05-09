import 'dart:math';

import 'package:flutter/material.dart';
import 'package:offline_product_app/model/model.dart';

import 'databasehelper.dart';

class addingpage extends StatelessWidget {
  final bool isadded;
  Product p;
  addingpage(this.isadded, {required this.p});
  TextEditingController Ctitle = TextEditingController();
  TextEditingController Cdesc = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!isadded) {
      Ctitle.text = p.title;
      Cdesc.text = p.description;
    }
    return Scaffold(
      appBar:
          AppBar(title: isadded ? Text("Adding Page") : Text("Updating page")),
      body: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: Ctitle,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: Cdesc,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description ";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      if (isadded) {
                        Databasehelper.Instance.addProduct(Product(
                            title: Ctitle.text, description: Cdesc.text));
                      } else {
                        await Databasehelper.Instance.updateProduct(Product(
                            id: p.id,
                            title: Ctitle.text,
                            description: Cdesc.text));
                      }
                    }

                    Navigator.pop(context);
                  },
                  child: isadded ? Text("Save") : Text("Update"))
            ],
          )),
    );
  }
}
