import 'dart:convert';

import 'package:api_practice/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUserApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    var data = jsonDecode(
      response.body.toString(),
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(
          UsersModel.fromJson(i),
        );
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Api Practice'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReuseableRow(
                                  title: 'Name',
                                  value: snapshot.data![index].name.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Username',
                                  value:
                                      snapshot.data![index].username.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Email',
                                  value: snapshot.data![index].email.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Address',
                                  value: snapshot.data![index].address!.city
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReuseableRow extends StatelessWidget {
  ReuseableRow({super.key, required this.title, required this.value});
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title + value),
        ],
      ),
    );
  }
}
