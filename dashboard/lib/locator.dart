import 'package:dashboardadmin/Services/dialog_service.dart';
import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:dashboardadmin/ViewsModel/create_post_prod_view_model.dart';
import 'Services/authentication_service.dart';
import 'Services/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'Services/navigation_service.dart';
import 'Services/dialog_service.dart';
import 'Services/cloud_storage_service.dart';
import 'Services/image_selector.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => Tab_selector());
  locator.registerLazySingleton<CreatePostProdViewModel>(() => CreatePostProdViewModel());


}
