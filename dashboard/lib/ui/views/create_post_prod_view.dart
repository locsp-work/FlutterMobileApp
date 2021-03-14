import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/ViewsModel/create_post_prod_view_model.dart';
import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/models/post_prod.dart';
import 'package:dashboardadmin/ui/shared/ui_helpers.dart';
import 'package:dashboardadmin/ui/widgets/busy_button.dart';
import 'package:dashboardadmin/ui/widgets/input_field.dart';
import 'package:dashboardadmin/ui/widgets/threeDcontainer.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/cloud_storage_service.dart';
import 'package:provider_architecture/provider_architecture.dart';
class CreatePostProdView extends StatefulWidget {
  @override
  final PostProd edittingPost;
  CreatePostProdView({Key key, this.edittingPost}) : super(key: key);
  CreatePostProdViewState createState() => CreatePostProdViewState();
}

class CreatePostProdViewState extends State<CreatePostProdView> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final saleController = TextEditingController();
  List<String> selectSize=[];
  List<String> oldImg;
  PostProd edittingPost;
  bool isEditting=false;
  var selectCategories;
  List<Asset> _images = List<Asset>();
  String _error = 'No Error Dectected';
  CloudStorageService _cloudStorageService=locator<CloudStorageService>();
  NavigationService _navigationService=locator<NavigationService>();
  @override
  initState() {
    super.initState();
    edittingPost = widget.edittingPost;
    if(edittingPost!=null) isEditting=true;
    _images=[];
  }
  @override
  Future loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if(!mounted) return;
    setState(() {
      _images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _Checkbox(String Size){
      return Checkbox(
        value: selectSize.contains(Size),
        onChanged: (value){
          setState(() {
            if (value) {selectSize.add(Size);}
            else {
              selectSize.removeWhere((value)=> value==Size);
            }
          });
        },
      );
    }
    return WillPopScope(
      onWillPop: ()=>_navigationService.pushNamedAndRemoveUntil(HomeViewRoute, ShopItemViewRoute),
      child: ViewModelProvider<CreatePostProdViewModel>.withConsumer(
        viewModelBuilder:()=> CreatePostProdViewModel(),
        disposeViewModel: false,
        onModelReady: (model) {
          titleController.text = edittingPost?.title ?? '';
          detailController.text = edittingPost?.detail ?? '';
          if(edittingPost==null){
            quantityController.text='';
            saleController.text='';
            priceController.text='';
          }else{
            quantityController.text='${edittingPost?.quantity}';
            saleController.text='${edittingPost?.sale}';
            priceController.text='${edittingPost?.price}';
          }
          selectCategories=edittingPost?.categories ?? '';
        },
        builder: (context, model, child){
          Widget buildGridView() {
            return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_images.length, (index) {
              Asset asset = _images[index];
              print(_images.length);
              print(asset.getByteData(quality: 100));
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ThreeDContainer(
                  backgroundColor: Colors.white12,
                  backgroundDarkerColor: Colors.black12,
                  height: 80,
                  width: 80,
                  borderDarkerColor:Colors.black12,
                  borderColor: Colors.white12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: AssetThumb(
                      asset: asset,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              );
            }),
          );
        }
          return
            Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: !model.busy
                      ? Icon(Icons.add)
                      : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                  onPressed: () async{
                    if(selectCategories!=null && edittingPost!=null){
                      edittingPost.categories=selectCategories;
                    }

                    if(edittingPost!=null && edittingPost.quantity!=null){
                      edittingPost.quantity=int.parse(quantityController.text) ?? 0;
                    }
                    else {
                      model.quantity=int.parse(quantityController.text);
                    }
                    if(edittingPost!=null){
                      edittingPost.size=selectSize.join(',');
                      edittingPost.price=int.parse(priceController.text);
                      (0<int.parse(saleController.text) || int.parse(saleController.text)<=100)
                          ? edittingPost.sale=int.parse(saleController.text)
                          : edittingPost.sale=0;
                    }else{
                      model.selectSize=selectSize.join(',');
                      model.price=int.parse(priceController.text);
                      model.sale=int.parse(saleController.text);
                    }
                    if (_images!=null && edittingPost!=null && isEditting==false){
                      await _cloudStorageService.uploadImages(
                        imageToUpload: _images,
                        title: titleController.text,
                      )
                          .then((image) => {
                        oldImg=List.from(edittingPost.imageUrl),
                        edittingPost?.imageUrl=List.from(image.imageUrl),
                        edittingPost?.imageFileName=List.from(image.imageFileName),
                      }).whenComplete((){
                        _cloudStorageService.deleteImageProd(oldImg);
                      });
                    }
                    if(isEditting==true && edittingPost!=null){
                      List<String> tempName=List<String>();
                      edittingPost.imageFileName.forEach((imgName){
                        String i=imgName.replaceAll(edittingPost.title, titleController.text);
                        tempName.add(i);
                      });
                      edittingPost.imageFileName=List.from(tempName);
                      tempName=[];
                    }
                    model.setEdittingPost(edittingPost);

                    if(!model.busy){
                      model.images=_images;
                      await model.addPost(title: titleController.text,detail: detailController.text);
                      setState(() {
                        _images=[];
                      });
                      model.images=_images;
                    }
                  },
                  backgroundColor:
                  !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                            [
                              verticalSpace(40),
                              (edittingPost != null && isEditting)
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(edittingPost.imageUrl.length, (index) {
                                        Image image=Image.network(edittingPost.imageUrl[index],width: 50,height: 50,fit: BoxFit.fill,);
                                        return Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ThreeDContainer(
                                            backgroundColor: Colors.white12,
                                            backgroundDarkerColor: Colors.black12,
                                            height: 80,
                                            width: 80,
                                            borderDarkerColor:Colors.black12,
                                            borderColor: Colors.white12,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              child: image,
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  : buildGridView(),
                              BusyButton(
                                title: 'Pick Image',
                                onPressed: (){
                                  loadAssets();
                                  setState(() {
                                    isEditting=false;
                                  });
                                }
                              ),
                              verticalSpace(40),
                              Text(
                                'Create Post',
                                style: TextStyle(fontSize: 26),
                              ),
                              verticalSpaceMedium,
                              InputField(
                                placeholder: 'Title',
                                controller: titleController,
                              ),
                              verticalSpaceMedium,
                              StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance.collection('categories').snapshots(),
                                  builder: (context,snapshot){
                                    if(snapshot.hasData){
                                      var length=snapshot.data.documents.length;
                                      DocumentSnapshot ds=snapshot.data.documents[length-1];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.library_books,size: 20.0,),
                                          SizedBox(width: 50.0,),
                                          SizedBox(
                                            width:220.0,
                                            child: DropdownButton(
                                              hint: Text('Select category'),
                                              items: snapshot.data.documents.map((DocumentSnapshot doc){
                                                return DropdownMenuItem(
                                                    child: new Text('${doc.data['title']}'),
                                                    value: '${doc.data['title']}',
                                                  );
                                              }).toList(),
                                              isDense: true,
                                              value:null,
                                              onChanged: (categoryValue){
                                                final snackBar=SnackBar(
                                                  content: Text('Selected category value is $categoryValue'),
                                                );
                                                Scaffold.of(context).showSnackBar(snackBar);
                                                setState((){
                                                  print(categoryValue);
                                                  selectCategories=categoryValue;
                                                  model.category=selectCategories;
                                                });
                                              },
                                              isExpanded: true,
                                            ),
                                          ),
                                        ],
                                      );
                                    }else if(snapshot.hasError){
                                      const Text('No data avaible right now');
                                    }
                                    return Center(child: CircularProgressIndicator());
                                  }
                              ),
                              verticalSpaceMedium,
                              InputField(
                                textInputType: TextInputType.number,
                                placeholder: 'Price',
                                controller: priceController,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex:2,
                                    child: InputField(
                                      textInputType: TextInputType.number,
                                      placeholder: 'Quantity',
                                      controller: quantityController,
                                    ),
                                  ),
                                  SizedBox(width: 30.0),
                                  Expanded(
                                    flex: 1,
                                    child: InputField(
                                      textInputType: TextInputType.number,
                                      placeholder: 'Sale (%)',
                                      controller: saleController,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _Checkbox('S'),
                                  Text('S'),
                                  _Checkbox('M'),
                                  Text('M'),
                                  _Checkbox('L'),
                                  Text('L'),
                                ],
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
                            ]
                        ),

                      ),
                    ],
                  ),
                )
            );
        }
      ),
    );

  }
}

