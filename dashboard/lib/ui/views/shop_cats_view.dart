import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:dashboardadmin/ui/widgets/post_cat_item.dart';
import 'package:dashboardadmin/ViewsModel/shop_cat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:dashboardadmin/locator.dart';
class ShopCatView extends StatelessWidget {
  ShopCatView({Key key}) : super(key: key);
  Tab_selector _tab_selector=locator<Tab_selector>();
  @override
  Widget build(BuildContext context){

    return ViewModelProvider<ShopCatModel>.withConsumer(
        viewModelBuilder: ()=>ShopCatModel(),
        // ignore: deprecated_member_use
        disposeViewModel: false,
        onModelReady: (model){_tab_selector.Tab='categories'; model.listenToPosts();},
        builder: (context,model,child) =>
            MaterialApp(
              home: Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: !model.busy ? Icon(Icons.add) : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                  onPressed: (){
                    model.navigateToCreateView();
                  },

                ),
                backgroundColor: Color(0xfff0f0f0),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.only(top: 85),
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: model.posts!=null
                                ? ListView.builder(
                                itemCount: model.posts.length,
                                itemBuilder: (context, int index)
                                =>GestureDetector(
                                  onTap: () => model.editPost(index),
                                  child: PostCatItem(
                                    post: model.posts[index],
                                    onDeleteItem: () => model.deletePost(index),
                                  ),
                                )
                            )
                                : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).primaryColor),
                              ),
                            )
                        ),
                      ),
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff696b9b),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Category",
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
//                      Container(
//                        child: Column(
//                          children: <Widget>[
//                            SizedBox(
//                              height: 60,
//                            ),
//                            Padding(
//                              padding: EdgeInsets.symmetric(horizontal: 20),
//                              child: Material(
//                                elevation: 5.0,
//                                borderRadius: BorderRadius.all(Radius.circular(30)),
//                                child: TextField(
//                                  // controller: TextEditingController(text: locations[0]),
//                                  cursorColor: Theme.of(context).primaryColor,
////                                style: dropdownMenuItem,
//                                  decoration: InputDecoration(
//                                      hintText: "Search Category",
//                                      hintStyle: TextStyle(
//                                          color: Colors.black38, fontSize: 16),
//                                      prefixIcon: Material(
//                                        elevation: 0.0,
//                                        borderRadius:
//                                        BorderRadius.all(Radius.circular(30)),
//                                        child: Icon(Icons.search),
//                                      ),
//                                      border: InputBorder.none,
//                                      contentPadding: EdgeInsets.symmetric(
//                                          horizontal: 25, vertical: 13)),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      )
                    ],
                  ),
                ),
              ),
            )
    );
  }
}
//---------------------------------------