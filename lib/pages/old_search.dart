import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_pfa/pages/description_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../pallete.dart';
import 'custom_image.dart';
class Room {
  final String hotel;
  final String image;
  final String prix;
  final String desc;


  const Room(this.hotel, this.image,this.prix, this.desc);
}
class OldSearchPage extends StatefulWidget {
  const OldSearchPage({Key? key}) : super(key: key);

  @override
  State<OldSearchPage> createState() => _OldSearchPageState();
}
screenAwareSize(int size, BuildContext context) {
  double baseHeight = 250.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
class _OldSearchPageState extends State<OldSearchPage> {

  final Stream<QuerySnapshot> _soldeStream = FirebaseFirestore.instance.collection('room').snapshots();
  @override
  Widget build(BuildContext context) {
    AppBar(
        backgroundColor: Colors.black,
        title: const Text('AppBar Demo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ]
    );


    return StreamBuilder<QuerySnapshot>(
      stream: _soldeStream,
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child:SpinKitSpinningLines(
                duration: const Duration(seconds: 4),
                color: kBlue,
                size: 50.0,)
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap:  () {
                Room r=new Room(data['hotel'],data[' image'], data['prix'],data['desc']);
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
                        data["image"],
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
                              data["hotel"],
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
                                  data["prix"]+'',
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
      },
    );

  }
}
class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(onPressed: (){

      }, icon: Icon(Icons.clear),)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}
