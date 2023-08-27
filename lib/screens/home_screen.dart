import 'dart:convert';

import 'package:api_practice/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.clear();
        postList.add(
          PostsModel.fromJson(i),
        );
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API\'s Practice'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (contex, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Title',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  postList[index].title.toString(),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  postList[index].body.toString(),
                                )
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
