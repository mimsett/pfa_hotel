import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'custom_image.dart';
import 'description_page.dart';
import 'old_search.dart';

void main() => runApp(SearchPage ());

class SearchPage  extends StatefulWidget {
  @override
  _SearchPage  createState() => _SearchPage ();
}

class _SearchPage  extends State<SearchPage > {
  String name = "";
   var hotel =FirebaseFirestore.instance
      .collection('room');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (val) => initiateSearch(val),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: name != "" && name != null
              ? FirebaseFirestore.instance
              .collection('room')
              .where('hotel',
            isGreaterThanOrEqualTo: name,
            isLessThan: name.substring(0, name.length - 1) +
                String.fromCharCode(name.codeUnitAt(name.length - 1) + 1),
              )
              .snapshots()
              : FirebaseFirestore.instance.collection("room").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return  ListView(
                  children:
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    print(document['hotel']);
                    return GestureDetector(
                      onTap:  () {
                        Room r=new Room(document['hotel'],document[' image'], document['prix'],document['desc']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  DescPage()),
                        );
                        //print(data.values);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CustomImage(
                                document["image"],
                                radius: 15,
                                height: 80,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document["hotel"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'test',
                                      style: TextStyle(fontSize: 12, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'test',
                                            style: TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                        ),
                                        Text(
                                          document["prix"]+'',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      print(val+'');
      name = val;
    });
  }
}

////////////////////////////////////////////////


