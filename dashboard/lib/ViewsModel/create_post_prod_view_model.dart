import 'package:dashboardadmin/ViewsModel/base_model.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';
import 'package:dashboardadmin/Services/firestore_service.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/models/post_prod.dart';
import 'package:flutter/foundation.dart';
import 'package:dashboardadmin/Services/cloud_storage_service.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class CreatePostProdViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService = locator<CloudStorageService>();
  PostProd _edittingPost;
  bool get _editting => _edittingPost != null;

  //=============================================//
  String _category;
  set category(String c)=>_category=c;
  String get category=>_category;
  //=============================================//

  int _quantity=0;
  set quantity(int c)=>_quantity=c;
  int get quantity=>_quantity;
  //=============================================//

  String _selectSize;
  String get selectSize=>_selectSize;
  set selectSize(String size)=>_selectSize=size;
  //=============================================//

  int _sale;
  int get sale=>_sale;
  set sale(int Sale)=>_sale=Sale;
  //=============================================//

  int _price;
  int get price=>_price;
  set price(int Price)=>_price=Price;
  //=============================================//
  List<Asset> _images = List<Asset>();
  List<Asset> get images=>_images;
  set images(List<Asset> i)=>_images=List.from(i);
  //=============================================//
  String _imageUrl;
  String get imageUrl=>_imageUrl;
  set imageUrl(String i)=>_imageUrl=i;
  //=============================================//
  String _imageFileName;
  String get imageFilename=>_imageFileName;
  set imageFilename(String i)=>_imageFileName=i;
  //=============================================//
  String _error = 'No Error Dectected';
  bool isUploading = false;
    Future addPost({@required String title,String detail}) async {
    setBusy(true);

    CloudStorageProdResult storageResult;
    if (!_editting) {
      storageResult = await _cloudStorageService.uploadImages(
        imageToUpload: _images,
        title: title,
      );
    }
    var result;
    if (!_editting) {
      result = await _firestoreService
        .addPostProd(PostProd(
        title: title,
        detail: detail,
        userId: currentUser.id,
        imageUrl: storageResult.imageUrl,
        imageFileName: storageResult.imageFileName,
        categories: _category,
        quantity: _quantity,
        size: _selectSize,
        price: _price,
        sale: _sale
      ));
    } else{
      result = await _firestoreService.updatePostProd(PostProd(
        title: title,
        detail: detail,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        imageUrl: _edittingPost.imageUrl,
        imageFileName: _edittingPost.imageFileName,
        categories: _edittingPost.categories,
        quantity: _edittingPost.quantity,
        size: _edittingPost.size,
        price: _edittingPost.price,
        sale: _edittingPost.sale
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
      _cloudStorageService.renewImageUrls(true);
    }
    _navigationService.pop();
  }
  void setEdittingPost(PostProd edittingPost) {
      _edittingPost = edittingPost;
  }
}
