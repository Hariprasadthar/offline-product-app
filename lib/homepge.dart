import 'package:flutter/material.dart';
import 'package:offline_product_app/databasehelper.dart';
import 'package:offline_product_app/model/model.dart';

import 'addpge.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> products;
  bool loading = true;

  get addpage => null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshProduct();
  }

  void refreshProduct() async {
    setState(() {
      loading = true;
    });
    products = await Databasehelper.Instance.listAllProduct();
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    Databasehelper.Instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                refreshProduct();
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text("PMS"),
      ),

//Body Section
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : products.isEmpty
              ? Center(
                  child: Text("No found Product"),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (ctx, i) {
                    return ListTile(
                      title: Text(products[i].title),
                      subtitle: Text(products[i].description),

                      // For trailing
                      trailing: SizedBox(
                        height: 50,
                        width: 100,
                        child: Row(children: [
                          Flexible(
                              child: IconButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addingpage(
                                          false,
                                          p: products[i],
                                        )),
                              );
                              refreshProduct();
                            },
                            color: Colors.black,
                            icon: Icon(Icons.edit),
                          )),
                          Flexible(
                              child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Do you want to delete?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              bool result =
                                                  await Databasehelper.Instance
                                                      .deleteProduct(
                                                          products[i].id!);
                                              if (result) {
                                                refreshProduct();
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "delete",
                                            )),
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"))
                                      ],
                                    );
                                  });
                            },
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                          ))
                        ]),
                      ),
                    );
                  }),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => addingpage(
                      true,
                      p: Product(
                        id: 1,
                        title: "",
                        description: "",
                      ),
                    )),
          );
          refreshProduct();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
