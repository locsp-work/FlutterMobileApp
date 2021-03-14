import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class CloudStorageService {
  final Tab_selector _tab_selector=locator<Tab_selector>();
  List<String> imageUrls=[];
  List<String> imageName=[];
  void renewImageUrls(bool i){if(i) {
    imageUrls=[];
    imageName=[];
  }}

  Future<CloudStorageCatResult> uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {
    final imageFileName =
        title +'   '+ DateTime.now().toString();
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('image/${_tab_selector.Tab}/$imageFileName');

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageCatResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    }
    return null;
  }
  Future deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(imageFileName);
    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
  Future deleteImageProd(List<String> imageUrl)async{
    imageUrl.forEach((element) {
      FirebaseStorage.instance.getReferenceFromUrl(element)
          .then((res) => res.delete().
      then((res) => print('Deleted')));
    });

  }


  Future<CloudStorageProdResult> uploadImages({
    @required List<Asset> imageToUpload,
    @required String title,
  }) async{
    for ( var imageFile in imageToUpload) {
      await postImage(imageFile,title).then((img){
        imageUrls.add(img.toString());
      }).catchError((err) {
            print(err);
      });
    }
//    var url;
//    url=imageUrls.join(',');
//    var imgName;
//    imgName=imageName.join(',');
    return CloudStorageProdResult(imageUrl: imageUrls,imageFileName: imageName);
  }
  Future<dynamic> postImage(Asset imageFile,String title) async {
    String fileName =title+'----'+DateTime.now().toString();
    imageName.add(fileName);
    StorageReference reference = FirebaseStorage.instance.ref().child('image/${_tab_selector.Tab}/$fileName');
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    return await storageTaskSnapshot.ref.getDownloadURL();
  }
}

class CloudStorageProdResult {
   List<String> imageUrl;
   List<String> imageFileName;
  CloudStorageProdResult({this.imageUrl, this.imageFileName});
}
class CloudStorageCatResult {
  String imageUrl;
  String imageFileName;
  CloudStorageCatResult({this.imageUrl, this.imageFileName});
}