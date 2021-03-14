import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';
import 'package:dashboardadmin/Services/firestore_service.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/ViewsModel/base_model.dart';
import 'package:dashboardadmin/Services/cloud_storage_service.dart';
import 'package:dashboardadmin/models/post_prod.dart';
class ShopProdModel extends BaseModel{
  final DialogService _dialogService = locator<DialogService>();
  final Tab_selector _tab_selector=locator<Tab_selector>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final CloudStorageService _cloudStorageService=locator<CloudStorageService>();
  List<PostProd> _posts;
  List<PostProd> get posts => _posts;
  void listenToPosts(){
    setBusy(true);
    _firestoreService.listenToPostsRealTime(_tab_selector.Tab).listen((postsData) {
      List<PostProd> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _posts = updatedPosts;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Bạn có chắc?',
      description: 'Bạn thực sự muốn xóa loại hàng này ?',
      confirmationTitle: 'Xác nhận',
      cancelTitle: 'Thoát',
    );
    if (dialogResponse.confirmed) {
      setBusy(true);
      await _cloudStorageService.deleteImageProd(_posts[index].imageUrl);
      await _firestoreService.deletePost(_posts[index].documentId,_tab_selector.Tab);
      if(index == 1) _navigationService.pop();
      _navigationService.navigateTo(_tab_selector.Tab=='categories'? ShopCatViewRoute:ShopItemViewRoute);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostProdViewRoute);
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreatePostProdViewRoute,
        arguments: _posts[index]);
  }
}
