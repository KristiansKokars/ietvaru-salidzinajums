import 'dart:convert';

import 'package:demo/APIResponse.dart';
import 'package:demo/detail.dart';
import 'package:demo/itemdao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  ListPage({super.key, required this.itemDao});

  final ItemsDao itemDao;

  @override
  State<ListPage> createState() => _ListPageState();
}

Future<List<APIResponse>> fetchCats() async {
  final response = await http.get(
    Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((item) => APIResponse.fromJson(item)).toList();
  } else {
    throw Exception("Failed to load album");
  }
}

class _ListPageState extends State<ListPage> {
  late Stream<List<APIResponse>> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.itemDao.getAll();
    addItems();
  }

  Future<void> addItems() async {
    widget.itemDao.addItems(await fetchCats());
  }

  void onGoToDetail(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(itemId: id, itemsDao: widget.itemDao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: addItems,
                child: Text("Get more items"),
              ),
              StreamBuilder(
                stream: _items,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => onGoToDetail(snapshot.data![index].id),
                          child: Container(
                            color: Colors.grey,
                            alignment: Alignment.center,

                            child: Image.network(snapshot.data![index].url),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
