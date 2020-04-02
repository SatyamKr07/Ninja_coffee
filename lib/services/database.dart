import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnn_ff/models/brew.dart';
import 'package:tnn_ff/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection Reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData(
      {
        'sugar': sugars,
        'name': name,
        'strength': strength,
      },
    );
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugar'] ?? '',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  //set up stream of database update
  // Stream<QuerySnapshot> get brews {
  //   return brewCollection.snapshots();
  // }
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugar'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
