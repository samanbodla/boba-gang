import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boba_gang/models/boba.dart';
import 'package:boba_gang/models/user.dart';

class DataBaseService {

  final String uid;
  DataBaseService ({ this.uid });

  //collection reference
  final CollectionReference bobaCollection = Firestore.instance.collection('boba');

  Future updateUserData(int sugars, String name, String flavor, String boba) async {
    return await bobaCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'flavor': flavor,
      'boba': boba, });
  }

  //  boba list from snapshot
  List<Boba> _brewListFromSnapcshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Boba(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? 0,
        flavor: doc.data['flavor'] ?? '',
        boba: doc.data['boba'] ?? 'no'
      );
    }).toList();
  }

  //  boba list from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
      return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        flavor: snapshot.data['flavor'],
        boba: snapshot.data['boba']
      );
    
  }

  //  get the boba stream when changes occur
  Stream<List<Boba>> get bobas {
    return bobaCollection.snapshots()
    .map(_brewListFromSnapcshot);
  }

  // get the user doc stream
  Stream<UserData> get userData {
    return bobaCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}