import 'dart:convert';
import 'dart:io';

import 'package:api_practice/models/dropdown_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropDownApi extends StatefulWidget {
  const DropDownApi({super.key});

  @override
  State<DropDownApi> createState() => _DropDownApiState();
}

class _DropDownApiState extends State<DropDownApi> {
  var selectedValue;
  Future<List<DropDownModel>> getPost() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownModel(
              userId: map['userId'],
              id: map['id'],
              title: map['title'],
              body: map['body']);
        }).toList();
      }
    } on SocketException {
      throw Exception('Network error');
    }
    throw (Exception('Error fetching data'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<DropDownModel>>(
                future: getPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      isExpanded: true,
                      value: selectedValue,
                      hint: const Text('Select value'),
                      items: snapshot.data!.map(
                        (e) {
                          return DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(
                              e.id.toString(),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        selectedValue = value;
                        setState(() {});
                      },
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
