import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hotel_pfa/pallete.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:hotel_pfa/widgets/text-field-input.dart';


class User {
  String i;
  String name;
  String e;

  User({
  required this.i,
    required  this.name,
    required this.e,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(

        i: json['image'],
        name: json['name'],
        e: json['email'],
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController controller=PageController();
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = "";

  late DateTime dateDebut;
  late DateTime datefin;
  List<String> tag = ['Beach', 'Hiking','Boating','golf'];
  List imageTag=[
    'images/hero-image.jpg',
    'images/jon_rahm.jpg',
    'images/Anse-Source-DArgent-La-Digue-Seychelles-beach1.jpg',
    'images/table_rock_lake_0.jpg'
  ];
  int count=0;
  //void _read() async {
  //  DocumentSnapshot documentSnapshot;
  //  try {
   //   documentSnapshot = FirebaseFirestore.instance.collection('users');
    //  print(documentSnapshot.data());
    //} catch (e) {
     // print(e);
    //}
 // }

  //var email='admin4@gmail.com';
  //@override
  //void initState () {
  //super.initState();
  //  _asyncMethod();
  //}

  //_asyncMethod() async {
  //  var e = await SessionManager().get("email");;
  //  setState(() {
   //   email = e;
   // });
  //}



  final  _collectionRef =
  FirebaseFirestore.instance.collection('users').where('email',isEqualTo: 'admin4@gmail.com');
  var nameuser="";
  var imageuser="";
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final dataName = querySnapshot.docs.map((doc) => doc['name']).toList();
    final dataImage = querySnapshot.docs.map((doc) => doc['image']).toList();


    //allData.forEach((element) {print(element);});
    nameuser=dataName[0].toString();
    print(nameuser);
    imageuser= await dataImage.toString();
    print(imageuser);

  }

  @override
  Widget build(BuildContext context) {
    getData();
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: WBLue,

              title:  Text('Hi  '+nameuser.toUpperCase()),
               actions: [
                 ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:  Image.network( imageuser
                    ,
                    height: 150.0,
                    width: 100.0,
                    color: Wblack,
                  ),
                )
              ],
            ),
            backgroundColor: WBLue,
            body: Container(

              child: Column(

            children: [
              Container(
                margin: EdgeInsets.all(5),
                child:
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                  Text(
                    "Tags",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Wblack),
                  ),
                ),),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    height: 190
                  ),
                  items: imageTag.map((e) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(e,
                          width: 900,
                          height:40,
                          fit: BoxFit.cover,),
                       // Text(tag[count]+'')

                      ],
                    ) ,

                  ),).toList(),
                ),
              ),
             // Container(
             //   child:
             // ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0,right:10.0,top: 10.0),
                  child:CSCPicker(
                    flagState: CountryFlag.DISABLE,

                    dropdownDecoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                      boxShadow: [ BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 7),)],
                      // border: Border.all(
                      //   color: Colors.yellow,
                      // width: 0,
                      //),


                    ),
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged:(value) {
                      setState(() {
                        stateValue = value;
                      });
                    },
                    onCityChanged:(value) {
                      setState(() {
                        cityValue = value;
                      });
                    },
                  ),),




                //datetime
                Container(
                    margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
                    //padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),

                    height: 60,
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(15.0),
                color: Color(0xFFF3F3F4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 7),
            )
          ],
        ),
                child:Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width/2.3,
                  //height: 50,


                  child:
              DateTimePicker(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText:'ar',
                  labelStyle: TextStyle(color: kBlue)
                ),
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Date',
                        onChanged: (val) => print(val),
                        validator: (val) {
                  dateDebut=val as DateTime;
                          print(dateDebut);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      )
              ),
              Container(
                //margin: EdgeInsets.only(left: 10.0,right: 10.0) ,

                child:const VerticalDivider(
                  color: Colors.grey,
                  width: 5,
                  endIndent: 5,
                  indent: 5,



                )
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),

                width: MediaQuery.of(context).size.width/2.3,
                //height: 50,
                child: DateTimePicker(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText:'ar',
                      labelStyle: TextStyle(color: kBlue)
                  ),
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    datefin=val as DateTime;

                    print(datefin);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
            ]
                )),
              Container(

                  margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),

              child:FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                  onPressed: (){
                    print('test');
                  },
                  color: LBlue,
                  height: 40,
                  minWidth:MediaQuery.of(context).size.width ,

                child: Text(
                    'test',
                    style:TextStyle(color: Colors.white),
                ),
              ))
              ]),
            )));
      }
  }


