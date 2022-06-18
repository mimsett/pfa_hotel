import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? hotel;
  final String? image;
  final String? prix;
  final String? desc;
  //const Room(this.hotel, this.image,this.prix, this.desc);

  DataModel({this.hotel, this.image,this.prix, this.desc});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;
      print("test");
      return DataModel(
          hotel: dataMap['hotel'],
          image: dataMap['image'],
          prix: dataMap['prix'],
          desc: dataMap['desc']);
    }).toList();
  }
}
