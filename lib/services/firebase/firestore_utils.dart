import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUtils {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseDatabase _realtime = FirebaseDatabase.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static FirebaseFirestore get firestore => _firestore;
  static FirebaseDatabase get realtime => _realtime;
  static FirebaseAuth get auth => _auth;
  static FirebaseStorage get storage => _storage;
}
