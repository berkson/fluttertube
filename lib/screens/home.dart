import 'package:flutter/material.dart';
import 'package:fluttertube/delegates/data_search.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          height: 60,
          width: MediaQuery.of(context).size.width / 2,
          child: Image.asset('images/you-ico.png', fit: BoxFit.cover),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text('0'),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
          IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(),
    );
  }
}
