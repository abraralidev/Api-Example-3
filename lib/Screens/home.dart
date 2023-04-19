// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:complexapi/constants/api_const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> userlist = [];

  Future<List<UserModel>> getuserapi() async {
    final response = await http.get(Uri.parse(userapi));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        print("work");
        userlist.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  void initState() {
    getuserapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex Api"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<UserModel>>(
                future: getuserapi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 6,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Center(
                                child:
                                    Text(snapshot.data![index].id.toString()),
                              ),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Name: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data![index].name.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'UserName: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data![index].username
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'City: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data![index].address!.city
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Address: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data![index].address!.street
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Company: ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data![index].company!.name
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].address!.geo!.lat
                                    .toString()),
                                Text(snapshot.data![index].address!.geo!.lat
                                    .toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
