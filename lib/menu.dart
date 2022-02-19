import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:com_279045_rentaroom/productsdetails.dart';
import 'package:flutter/material.dart';
import 'package:com_279045_rentaroom/model/config.dart';
import 'package:com_279045_rentaroom/model/room.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List roomlist = [];
  String titlecenter = "Please wait...";
  late double screenHeight, screenWidth, resWidth;
  late ScrollController _scrollController;
  int scrollcount = 10;
  int rowcount = 2;
  int numprd = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadrooms();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: roomlist.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                    fontSize: 22,
                  )))
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 3),
                  child: Text("Available Rooms",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                ),
                Text(
                  "A total of " + numprd.toString() + " rooms found\n",
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: rowcount,
                    controller: _scrollController,
                    children: List.generate(scrollcount, (index) {
                      return Card(
                          child: InkWell(
                        onTap: () => {_roomDetails(index)},
                        child: Column(
                          children: [
                            Flexible(
                              flex: 7,
                              child: CachedNetworkImage(
                                width: screenWidth,
                                fit: BoxFit.cover,
                                imageUrl: MyConfig.server +
                                    "images/" +
                                    roomlist[index]['roomid'] +
                                    "_1.jpg",
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Flexible(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          truncateString(roomlist[index]
                                                  ['title']
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: resWidth * 0.04,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "Price (monthly): RM " +
                                              double.parse(
                                                      roomlist[index]['price'])
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: resWidth * 0.025,
                                          )),
                                      Text(
                                          "Deposit: RM " +
                                              double.parse(roomlist[index]
                                                      ['deposit'])
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: resWidth * 0.025,
                                          )),
                                      Text(
                                          truncateString(roomlist[index]['area']
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: resWidth * 0.025,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ));
                    }),
                  ),
                ),
              ],
            ),
    );
  }

  void _loadrooms() {
    http.post(Uri.parse(MyConfig.server + "php/load_rooms.php"), body: {}).then(
        (response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        print(response.body);
        var extractdata = data['data'];
        setState(() {
          roomlist = extractdata["rooms"];
          numprd = roomlist.length;
          if (scrollcount >= roomlist.length) {
            scrollcount = roomlist.length;
          }
        });
      } else {
        setState(() {
          titlecenter = "No Data";
        });
      }
    });
  }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  _roomDetails(int index) {
    Room room = Room(
      roomid: roomlist[index]['roomid'],
      contact: roomlist[index]['contact'],
      title: roomlist[index]['title'],
      description: roomlist[index]['description'],
      price: roomlist[index]['price'],
      deposit: roomlist[index]['deposit'],
      state: roomlist[index]['state'],
      area: roomlist[index]['area'],
      datecreated: roomlist[index]['date_created'],
      latitude: roomlist[index]['latitude'],
      longitude: roomlist[index]['longitude'],
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RoomScreen(
                  room: room,
                )));
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (roomlist.length > scrollcount) {
          scrollcount = scrollcount + 10;
          if (scrollcount >= roomlist.length) {
            scrollcount = roomlist.length;
          }
        }
      });
    }
  }
}
