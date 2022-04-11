import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  String myUid = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseFirestore.instance.collection('users');
  Future<QuerySnapshot<Map>> getUserByUserName(String username) {
    return user.where('username', isEqualTo: username).get();
  }

  Future<void> updateFullName(fullName, userUid) async {
    user.doc(userUid).update({'fullName': fullName});
  }

  Future<void> updatePassword(password, userUid) async {
    user.doc(userUid).update({'password': password});
  }

  Future<void> uploadUserInfo(email, password, userUid) async {
    user.doc(userUid).set({'email': email, 'password': password});
  }

  Future<QuerySnapshot<Map>> searchByName(String searchField) {
    return user.where('username', isEqualTo: searchField).get();
  }

  Future<DocumentSnapshot<Map>> getUserData() {
    return user.doc(myUid).get();
  }
}
