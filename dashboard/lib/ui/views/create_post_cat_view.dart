import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:dashboardadmin/models/post_cat.dart';
import 'package:dashboardadmin/ui/shared/ui_helpers.dart';
import 'package:dashboardadmin/ui/widgets/input_field.dart';
import 'package:dashboardadmin/ViewsModel/create_post_cat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/cloud_storage_service.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
 class CreatePostCatView extends StatefulWidget {
   @override
   final PostCat edittingPost;
   CreatePostCatView({Key key, this.edittingPost}) : super(key: key);
   CreatePostCatViewState createState() => CreatePostCatViewState();
 }

 class CreatePostCatViewState extends State<CreatePostCatView> {
   final titleController = TextEditingController();
   final detailController = TextEditingController();
   String oldImg;
   PostCat edittingPost;
   var selectCategories;
   Tab_selector _tab_selector=locator<Tab_selector>();
   CloudStorageService _cloudStorageService=locator<CloudStorageService>();
   @override
   initState(){
     super.initState();
     edittingPost=widget.edittingPost;
   }
   @override
   Widget build(BuildContext context) {
     return ViewModelProvider<CreatePostCatViewModel>.withConsumer(
       viewModelBuilder:()=> CreatePostCatViewModel(),
       disposeViewModel: false,
       onModelReady: (model) {
         titleController.text = edittingPost?.title ?? '';
         detailController.text = edittingPost?.detail ?? '';
         model.setEdittingPost(edittingPost);
       },
       builder: (context, model, child) =>
           Scaffold(
               floatingActionButton: FloatingActionButton(
                 child: !model.busy
                     ? Icon(Icons.add)
                     : CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(Colors.white),
                 ),
                 onPressed: () async{
                   if (model.selectedImage!=null && edittingPost!=null){
                     await _cloudStorageService.uploadImage(
                       imageToUpload: model.selectedImage,
                       title: titleController.text,
                     )
                         .then((image) => {
                       oldImg = edittingPost.imageFileName,
                       edittingPost.imageUrl=image?.imageUrl ?? '',
                       edittingPost.imageFileName=image?.imageFileName ?? '',
                     }).whenComplete(() => {
                       model.setEdittingPost(edittingPost),
                       _cloudStorageService.deleteImage(oldImg),
                     }
                     );
                   }
                   if(!model.busy){
                     model.addPost(title: titleController.text,detail: detailController.text);
                   }
                 },
                 backgroundColor:
                 !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
               ),
               body: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
                 child: SingleChildScrollView(
                   child: Column(
                     children: <Widget>[
                       verticalSpace(40),
                       Text(
                         'Create Category',
                         style: TextStyle(fontSize: 26),
                       ),
                       verticalSpaceMedium,
                       GestureDetector(
                         onTap: () async=>{
                           await model.selectImage(),
                         },
                         child: Container(
                           height: 250,
                           decoration: BoxDecoration(
                               color: Colors.grey[200],
                               borderRadius: BorderRadius.circular(10)),
                           alignment: Alignment.center,
                           child: model.selectedImage == null
                               ? Image.network(edittingPost?.imageUrl!=null ? edittingPost.imageUrl : 'https://sciences.ucf.edu/psychology/wp-content/uploads/sites/63/2019/09/No-Image-Available.png')
                               : Image.file(model.selectedImage),
                         ),
                       ),
                       verticalSpaceMedium,
                       InputField(
                         placeholder: 'Title',
                         controller: titleController,
                       ),
                       verticalSpaceMedium,
                       Container(
                         height: 300.0,
                         child: TextField(
                           decoration: InputDecoration(
                             hintText: 'Nhập mô tả',
                             filled: true,
                             fillColor: Colors.grey.shade200,
                           ),
                           maxLines: 10,
                           controller: detailController,
                         ),
                       )
                     ],
                   ),
                 ),
               )),
     );
   }
 }

