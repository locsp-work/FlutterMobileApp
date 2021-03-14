import 'package:dashboardadmin/ViewsModel/shop_prod_model.dart';
import 'package:dashboardadmin/constants/routes.dart';
import 'package:dashboardadmin/Services/tab_selector.dart';
import 'package:dashboardadmin/ui/widgets/post_prod_item.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/locator.dart';
import 'package:dashboardadmin/Services/navigation_service.dart';
import 'package:dashboardadmin/ui/views/item_reviews_view.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
class ShopItemView extends StatelessWidget {
  ShopItemView({Key key}) : super(key: key);
  Tab_selector _tab_selector=locator<Tab_selector>();
  @override
  Widget build(BuildContext context){
    return ViewModelProvider<ShopProdModel>.withConsumer(
      viewModelBuilder:()=> ShopProdModel(),
      disposeViewModel: false,
      onModelReady: (model)=>{_tab_selector.Tab='products', model.listenToPosts()},
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
                                  child: PostProdItem(
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
                            Text("Products", style: TextStyle(color: Colors.white, fontSize: 24),),
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
//                    Container(
//                      child: Column(
//                        children: <Widget>[
//                          SizedBox(height: 60,),
//                          Padding(
//                            padding: EdgeInsets.symmetric(horizontal: 20),
//                            child: Material(
//                              elevation: 5.0,
//                              borderRadius: BorderRadius.all(Radius.circular(30)),
//                              child: TextField(
//                                cursorColor: Theme.of(context).primaryColor,
////                                style: dropdownMenuItem,
//                                decoration: InputDecoration(
//                                  hintText: "Search Product",
//                                  hintStyle: TextStyle(
//                                      color: Colors.black38, fontSize: 16),
//                                  prefixIcon: Material(
//                                    elevation: 0.0,
//                                    borderRadius:
//                                    BorderRadius.all(Radius.circular(30)),
//                                    child: Icon(Icons.search),
//                                  ),
//                                  border: InputBorder.none,
//                                  contentPadding: EdgeInsets.symmetric(
//                                      horizontal: 25, vertical: 13)),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    )
                  ],
                ),
              ),
            ),
          )
    );
  }
}
class ShopItem extends StatelessWidget {
  final NavigationService _navigationService=locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: <Widget>[
          /// Item card
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize(
                size: Size.fromHeight(172.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    /// Item description inside a material
                    Container(
                      margin: EdgeInsets.only(top: 24.0),
                      child: Material
                        (
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.white,
                        child: InkWell(
                          onTap: (){
                            _navigationService.navigateTo(ShopItemReviewViewRoute);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// Title and rating
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Nike Jordan III', style: TextStyle(color: Colors.blueAccent)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('4.6', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                        Icon(Icons.star, color: Colors.black, size: 24.0),
                                      ],
                                    ),
                                  ],
                                ),
                                /// Infos
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Bought', style: TextStyle()),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text('1,361', style: TextStyle(fontWeight: FontWeight.w700)),
                                    ),
                                    Text('times for a profit of', style: TextStyle()),
                                    Padding
                                      (
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Material
                                        (
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: Colors.green,
                                        child: Padding
                                          (
                                          padding: EdgeInsets.all(4.0),
                                          child: Text('\$ 13K', style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /// Item image
                    Align
                      (
                      alignment: Alignment.topRight,
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
                            child: Image.asset('res/shoes1.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          /// Review
          Padding
            (
            padding: EdgeInsets.only(top: 160.0, left: 32.0),
            child: Material
              (
              elevation: 12.0,
              color: Colors.transparent,
              borderRadius: BorderRadius.only
                (
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Container
                (
                decoration: BoxDecoration
                  (
                    gradient: LinearGradient
                      (
                        colors: [ Color(0xFF84fab0), Color(0xFF8fd3f4) ],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight
                    )
                ),
                child: Container
                  (
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile
                    (
                    leading: CircleAvatar
                      (
                      backgroundColor: Colors.purple,
                      child: Text('AI'),
                    ),
                    title: Text('Ivascu Adrian ★★★★★', style: TextStyle()),
                    subtitle: Text('The shoes were shipped one day before the shipping date, but this wasn\'t at all a problem :). The shoes are very comfortable and good looking', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle()),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BadShopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return Padding
      (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack
        (
        children: <Widget>
        [
          /// Item card
          Align
            (
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize
              (
                size: Size.fromHeight(172.0),
                child: Stack
                  (
                  fit: StackFit.expand,
                  children: <Widget>
                  [
                    /// Item description inside a material
                    Container
                      (
                      margin: EdgeInsets.only(top: 24.0),
                      child: Material
                        (
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.transparent,
                        child: Container
                          (
                          decoration: BoxDecoration
                            (
                              gradient: LinearGradient
                                (
                                  colors: [ Color(0xFFDA4453), Color(0xFF89216B) ]
                              )
                          ),
                          child: Padding
                            (
                            padding: EdgeInsets.all(24.0),
                            child: Column
                              (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                /// Title and rating
                                Column
                                  (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    Text('Nike Jordan III', style: TextStyle(color: Colors.white)),
                                    Row
                                      (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('1.3', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                        Icon(Icons.star, color: Colors.amber, size: 24.0),
                                      ],
                                    ),
                                  ],
                                ),
                                /// Infos
                                Row
                                  (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>
                                  [
                                    Text('Bought', style: TextStyle(color: Colors.white)),
                                    Padding
                                      (
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                    ),
                                    Text('times for a profit of', style: TextStyle(color: Colors.white)),
                                    Padding
                                      (
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Material
                                        (
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: Colors.green,
                                        child: Padding
                                          (
                                          padding: EdgeInsets.all(4.0),
                                          child: Text('\$ 363', style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /// Item image
                    Align
                      (
                      alignment: Alignment.topRight,
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
                            child: Image.asset('res/shoes1.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          /// Review
          Padding
            (
            padding: EdgeInsets.only(top: 160.0, right: 32.0,),
            child: Material
              (
              elevation: 12.0,
              color: Colors.white,
              borderRadius: BorderRadius.only
                (
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Container
                (
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile
                  (
                  leading: CircleAvatar
                    (
                    backgroundColor: Colors.purple,
                    child: Text('AI'),
                  ),
                  title: Text('Ivascu Adrian ★☆☆☆☆'),
                  subtitle: Text('The shoes that arrived weren\'t the same as the ones in the image...', maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewShopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return Padding
      (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Align
        (
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize
          (
            size: Size.fromHeight(172.0),
            child: Stack
              (
              fit: StackFit.expand,
              children: <Widget>
              [
                /// Item description inside a material
                Container
                  (
                  margin: EdgeInsets.only(top: 24.0),
                  child: Material
                    (
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shadowColor: Color(0x802196F3),
                    color: Colors.white,
                    child: Padding
                      (
                      padding: EdgeInsets.all(24.0),
                      child: Column
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          /// Title and rating
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('[New] Nike Jordan III', style: TextStyle(color: Colors.blueAccent)),
                              Row
                                (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>
                                [
                                  Text('No reviews', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                ],
                              ),
                            ],
                          ),
                          /// Infos
                          Row
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>
                            [
                              Text('Bought', style: TextStyle()),
                              Padding
                                (
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('0', style: TextStyle(fontWeight: FontWeight.w700)),
                              ),
                              Text('times for a profit of', style: TextStyle()),
                              Padding
                                (
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Material
                                  (
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.green,
                                  child: Padding
                                    (
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('\$ 0', style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /// Item image
                Align
                  (
                  alignment: Alignment.topRight,
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
                        child: Image.asset('res/shoes1.png'),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}