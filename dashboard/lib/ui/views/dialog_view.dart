import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/models/dialog_model.dart';
import 'package:dashboardadmin/Services/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  File _image;
  TextEditingController categoryController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController imgController=TextEditingController();
  final _categoryFormKey = GlobalKey<FormState>();
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
//    Future uploadpic(context)async{
//      String fileName=basename(imgController.text);
//      final StorageReference storageReference = FirebaseStorage().ref().child(fileName);
//      final StorageUploadTask uploadTask = storageReference.putFile(_image);
//      final StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
//      setState(() => Fluttertoast.showToast(msg: "Category picture uploaded"));
//    }
//    Future getImage() async {
//      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//      setState(() => _image = image);
//    }
    return widget.child;
  }
  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        builder: (context) =>AlertDialog(
            content:new Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: 50.0,
                top: -70.0,
                child: Padding
                  (
                  padding: EdgeInsets.only(right: 16.0),
                  child: SizedBox.fromSize
                    (
                    size: Size.fromRadius(54.0),
                    child: Material
                      (
                      elevation: 20.0,
                      shadowColor: Color(0x802196F3),
                      shape: CircleBorder(),
                      child: ClipOval(
                        child: _image!=null ? Image.file(_image) :
                        Image.network('https://us.123rf.com/450wm/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-stock-vector-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg?ver=6',fit: BoxFit.fill)
                        ,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -30.0,
                top: -30.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 10.0,
                    child: Icon(Icons.close,size: 15.0,color: Colors.white,),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                    key: _categoryFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                          child: TextFormField(
                            controller: categoryController,
                            validator: (value){
                              if(value.isEmpty){
                                return "category cannot is empty";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Type category name",
                              prefixIcon: Icon(Icons.playlist_add),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                              children:<Widget>[
                                Expanded(
                                  flex:3,
                                  child: TextFormField(
                                    controller: imgController,
                                    validator: (value){
                                      if(value.isEmpty){
                                        return "Image name cannot is empty";
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type Image Name",
                                      prefixIcon: Icon(Icons.image),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child:GestureDetector(
                                      child: Icon(Icons.add_photo_alternate),
                                      onTap: () async{
//                                        await getImage();
                                      },
                                    )
                                ),
                              ]
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                          child: RaisedButton(
                            onPressed: (){
                              if(_categoryFormKey.currentState.validate() == null) {
//                                _category.createCat(categoryController.text);
//                                uploadpic(context);
//                                Navigator.pop(context);
//                                Fluttertoast.showToast(msg: "Category created");
                              }
                            },
                            color: Colors.blue,
                            child: Text('ADD'),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
            )
      )
    );
  }
}
