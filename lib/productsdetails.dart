import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:com_279045_rentaroom/model/config.dart';
import 'package:com_279045_rentaroom/model/room.dart';

class RoomScreen extends StatefulWidget {
  final Room room;
  const RoomScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late double screenHeight, screenWidth, resWidth;
  final List<int> num = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details',
            style: TextStyle(
              fontSize: 22,
            )),
        backgroundColor: Colors.pink[100],
      ),
      body: Column(
        children: [
          Flexible(
              flex: 4,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: num.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Card(
                                color: Colors.pink[100],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                  child: CachedNetworkImage(
                                    width: screenWidth,
                                    fit: BoxFit.cover,
                                    imageUrl: MyConfig.server +
                                        "images/" +
                                        widget.room.roomid.toString() +
                                        "_" +
                                        num[index].toString() +
                                        ".jpg",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )));
                      }))),
          Text(widget.room.title.toString(),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.3),
                        1: FractionColumnWidth(0.7)
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(children: [
                          const Text('Room ID',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.roomid.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Contact',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.contact.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Description',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.description.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Price(monthly)',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text("RM " +
                              double.parse(widget.room.price.toString())
                                  .toStringAsFixed(2)),
                        ]),
                        TableRow(children: [
                          const Text('Deposit',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text("RM " +
                              double.parse(widget.room.deposit.toString())
                                  .toStringAsFixed(2)),
                        ]),
                        TableRow(children: [
                          const Text('State',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.state.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Area',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.room.area.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Date Created',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.datecreated.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Latitude',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.latitude.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Longitude',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.room.longitude.toString()),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
