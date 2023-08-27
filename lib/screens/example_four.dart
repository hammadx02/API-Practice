import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Api practice'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReuseableRow(
                                title: 'Name',
                                value: data[index]['name'].toString(),
                              ),
                              ReuseableRow(
                                title: 'Username',
                                value: data[index]['username'].toString(),
                              ),
                              ReuseableRow(
                                title: 'City',
                                value:
                                    data[index]['address']['city'].toString(),
                              ),
                              ReuseableRow(
                                title: 'Geo',
                                value: data[index]['address']['geo']['lat']
                                    .toString(),
                              ),
                            ],
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
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
