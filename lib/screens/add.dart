import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:instgram_nk/models/addModel.dart';
import 'package:http/http.dart' as http;

bool click = false;

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Posts? postsResponse;
  List<Posts> data = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<Posts>> apicall() async {
    try {
      final response = await http.get(
          Uri.parse('https://fakestoreapi.com/products'),
          headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        data = jsonResponse.map((job) => Posts.fromJson(job)).toList();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 102, 104, 105),
        title: const Text("Products at Instagram"),
      ),
      body: FutureBuilder<List<Posts>>(
          future: apicall(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.black,
                      child: Card(
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data![index].title!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              snapshot.data![index].image!,
                              width: 220,
                              height: 160,
                            ),
                            Row(children: [
                              const Text(
                                'Price : ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 100, 10, 246),
                                  fontSize: 23,
                                ),
                              ),
                              Text(
                                ' Rs. ${snapshot.data![index].price.toString()}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    click = !click;
                                  });
                                },
                                child: Icon(
                                    (click == true)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red),
                              ),
                            ]),
                            Text(
                              snapshot.data![index].description!,
                              style: TextStyle(color: Colors.black38),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Ratings - ',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                                Text(
                                  "${snapshot.data![index].rating!.rate.toString()}/5  Out of ${snapshot.data![index].rating!.count!} ",
                                  style: TextStyle(color: Colors.purple),
                                ),
                              ],
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.send),
                                hintText: 'Add a comment',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 76, 76, 76),
                                minimumSize: Size.fromHeight(39),
                              ),
                              onPressed: () {},
                              child: Text('Add to cart'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Container();
            }
          }),
    );
  }
}
