// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:instgram_nk/resources.dart';
import 'package:instgram_nk/models/profileModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: customAppBar(),
      body: Column(
        children: [
          topTitle(),
          statusView(),
          Divider(thickness: 1),
          // postView(),
        ],
      ),
    );
  }

  SingleChildScrollView statusView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          myStoryWidget(),
          for (int i = 0; i < profileList.length; i++) ...{
            storyWidget(
              profileNamePath: profileList[i].profileNamePath,
              imagePath: profileList[i].imagePath,
            ),
          }
        ],
      ),
    );
  }

  topTitle() {
    return Row(
      children: const [
        Text(
          'Stories',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.play_arrow),
        Text(
          'Watch All',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  AppBar customAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.grey.shade100,
      elevation: 1,
      leading: const Icon(
        Icons.camera_alt_sharp,
        color: Colors.black,
      ),
      centerTitle: true,
      title: const Text(
        'Instagram',
        style: TextStyle(fontStyle: FontStyle.normal, color: Colors.black),
      ),
      actions: const [
        Icon(
          Icons.send,
          color: Colors.black,
        )
      ],
    );
  }
}

// class postView extends StatefulWidget {
//   const postView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<postView> createState() => _postViewState();
// }

// class _postViewState extends State<postView> {
//   List? data;

//   @override
//   Future<String> apiCall() async {
//     var response = await http.get(
//         Uri.parse("https://fakestoreapi.com/products"),
//         headers: {"Accept": "application/json"});

//     setState(() {
//       data = json.decode(response.body);
//     });
//     return "Success";
//   }

//   @override
//   void initState() {
//     super.initState();
//     apiCall();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(itemBuilder: ((context, index) {
//       return Container(
//         child: (data?.length ?? 0) > 0
//             ? Text(
//                 data!.toString(),
//                 style: TextStyle(fontSize: 30),
//               )
//             : Text("Please wait"),
//       );
//     }));
//   }
// }

class myStoryWidget extends StatelessWidget {
  const myStoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Stack(
              children: [
                CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/87.jpg')),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ))
              ],
            ),
          ),
        ),
        Text(
          'My story',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class storyWidget extends StatelessWidget {
  final String imagePath;
  final String profileNamePath;

  const storyWidget(
      {Key? key, required this.imagePath, required this.profileNamePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(3),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: const [
                  Color.fromARGB(255, 255, 54, 131),
                  Color.fromARGB(255, 31, 28, 252),
                  Color.fromARGB(255, 54, 49, 121),
                  Color.fromARGB(255, 255, 199, 126),
                ],
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                },
                child: CircleAvatar(
                    radius: 28, backgroundImage: NetworkImage(imagePath)),
              ),
            ),
          ),
        ),
        Text(
          profileNamePath,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: Text('Popup example'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.network(profileList[4].imagePath),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
