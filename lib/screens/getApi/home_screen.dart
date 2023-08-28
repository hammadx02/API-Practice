import 'dart:convert';


import 'package:api_practice/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  // String BASE_URL = 'https://dummyjson.com/posts';

  // @override
  // initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (timeStamp) async {
  //       String? _data = await onGetPost();

  //       if (_data != null) {
  //         PostModel? _postModel = postModelFromJson(_data);
  //         if (_postModel != null) {
  //           setState(() {
  //             postList = _postModel.posts!;
  //           });
  //           log(postList[0].tags.toString());
  //         }
  //       }
  //     },
  //   );
  // }

  // Future<String?> onGetPost() async {
  //   try {
  //     _showLoading();
  //     var client = http.Client();
  //     var response = await client.get(Uri.parse(BASE_URL));

  //     if (response.statusCode == 200) {
  //       return response.body;
  //     }
  //     Navigator.pop(context);
  //   } catch (e) {
  //     Navigator.pop(context);
  //     log(e.toString());
  //   }
  //   return null;
  // }

  // Future<dynamic> _showLoading() {
  //   return showDialog(
  //     context: context,
  //     builder: (_) {
  //       return const Center(
  //         child: SizedBox(
  //           width: 30,
  //           height: 30,
  //           child: CircularProgressIndicator(
  //             color: Colors.red,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        // postList.clear();
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
