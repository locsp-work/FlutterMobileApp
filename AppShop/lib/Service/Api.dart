import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  final Firestore _db = Firestore.instance;
  Future<QuerySnapshot> getDataCollection(String ref) {
    return  _db.collection(ref).getDocuments();

  }
  Stream<QuerySnapshot> streamDataCollection(String ref) {
    return _db.collection(ref).snapshots();
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return _db.document(id).get();
  }
  Future<void> removeDocument(String id){
    return _db.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data,String ref) {
    return _db.collection(ref).add(data);
  }
  Future<void> updateDocument(Map data , String id,String ref) {
    //return ref.document(id).updateData(data) ;
    return _db.document(ref).updateData(data);
  }
}