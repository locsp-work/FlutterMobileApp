import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';
import 'package:dashboardadmin/Services/firestore_service.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/ViewsModel/base_model.dart';
import 'package:dashboardadmin/models/post_cat.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:dashboardadmin/Services/image_selector.dart';
import 'package:dashboardadmin/Services/cloud_storage_service.dart';
class CreatePostCatViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService = locator<CloudStorageService>();
  final Tab_selector _tab_selector=locator<Tab_selector>();
  PostCat _edittingPost;
  bool get _editting => _edittingPost != null;
  Future addPost({@required String title,String detail}) async {
    setBusy(true);
    CloudStorageCatResult storageResult;
    if (!_editting) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    }
    var result;
    if (!_editting) {
      result = await _firestoreService
          .addPostCat(PostCat(
          title: title,
          detail: detail,
          userId: currentUser.id,
          imageUrl: storageResult.imageUrl,
          imageFileName: storageResult.imageFileName,
      ));
    } else {
      result = await _firestoreService.updatePostCat(PostCat(
          title: title,
          detail: detail,
          userId: _edittingPost.userId,
          documentId: _edittingPost.documentId,
          imageUrl: _edittingPost.imageUrl,
          imageFileName: _edittingPost.imageFileName,
      ));
    }
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }
    _navigationService.popUntil(ShopCatViewRoute);
  }
  void setEdittingPost(PostCat edittingPost) {
    _edittingPost = edittingPost;
  }
  File _selectedImage;
  File get selectedImage => _selectedImage;
  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if(tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }
}
