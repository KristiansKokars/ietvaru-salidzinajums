import 'package:demo/APIResponse.dart';
import 'package:demo/itemdao.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.itemId, required this.itemsDao});

  final ItemsDao itemsDao;
  final String itemId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Stream<APIResponse> _item;

  @override
  void initState() {
    super.initState();
    _item = widget.itemsDao.getItem(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: MediaQuery.of(context).padding,
        child: StreamBuilder(
          stream: _item,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data!.url);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
