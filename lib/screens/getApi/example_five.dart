import 'dart:convert';

import 'package:api_practice/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/bf13f268-49bb-4a71-bd72-a2fe72fea349'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Practice'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              snapshot.data!.data![index].shop!.name.toString(),
                            ),
                            subtitle: Text(
                              snapshot.data!.data![index].shop!.shopemail
                                  .toString(),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data!.data![index].shop!.image
                                    .toString(),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * .1,
                            child: ListView.builder(
                              itemCount:
                                  snapshot.data!.data![index].images!.length,
                              itemBuilder: (context, position) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 2.5,
                                  width: MediaQuery.of(context).size.width * .5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        snapshot.data!.data![index]
                                            .images![position].url
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Icon(
                            snapshot.data!.data![index].inWishlist! == false
                                ? Icons.favorite
                                : Icons.favorite_outline,
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
