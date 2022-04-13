import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Album {
  final dynamic message;

  const Album({
    required this.message,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      message: json['message'],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int crossaxiscounts = 1;
  Album? futureAlbum;
  List? data;
  String appBarHeading1 = 'List view of dogs';

  String changeString = "grid";
  @override
  Future fetchAlbum() async {
    final response = await http.get(
        Uri.parse('https://dog.ceo/api/breed/hound/images'),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      futureAlbum = Album.fromJson(jsonDecode(response.body));
      data = futureAlbum?.message;
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 237, 237),
        title: Text(
          appBarHeading1,
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (crossaxiscounts == 1) {
                        appBarHeading1 = 'Grid view of dogs';
                        crossaxiscounts = 2;
                      } else {
                        crossaxiscounts = 1;
                        appBarHeading1 = 'List view of dogs';
                      }
                    });
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))
            ],
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchAlbum(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Container();
            }
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossaxiscounts,
                  ),
                  itemCount: 150,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Image.network(data![index]),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                    );
                  });
              // itemCount: 10,
              // itemBuilder: (context, index) {
              //   return Image.network(data?[index]);
              // });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
