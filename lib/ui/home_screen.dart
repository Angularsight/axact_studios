



import 'package:axact_studios/ui/widgets/category_card.dart';
import 'package:axact_studios/ui/widgets/offer_card.dart';
import 'package:axact_studios/ui/widgets/popular_products_card.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_wheel_scroll_view_x/list_wheel_scroll_view_x.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;
  late ScrollController _controller;
  int _expandedHeight = 150;


  //***********FIREBASE**************
  var firebaseDb = FirebaseFirestore.instance.collection('products').snapshots();
  var categories = [];
  var carouselDb = FirebaseFirestore.instance.collection('carousel').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {

      });
    });
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {});
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff171717),
      extendBodyBehindAppBar: true,


      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              buildSliverAppBar(),
              SliverToBoxAdapter(
                child: StreamBuilder<QuerySnapshot>(
                    stream: firebaseDb,
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData){
                        snapshot.data!.docs.forEach((element) {
                          if(!categories.contains(element['category'])){
                            categories.add(element['category']);
                          }
                        });

                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 75.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: carouselDb,
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData){
                                            var wantedImages = snapshot.data!.docs;
                                            print(wantedImages[0]);
                                            return Carousel(
                                              borderRadius: true,
                                              boxFit: BoxFit.cover,
                                              autoplay: true,
                                              autoplayDuration: Duration(milliseconds: 3000),
                                              animationCurve: Curves.fastOutSlowIn,
                                              animationDuration: Duration(milliseconds: 1000),
                                              dotSize: 6.0,
                                              dotColor: Colors.black,
                                              dotIncreasedColor: Colors.orange,
                                              dotBgColor: Colors.transparent,
                                              dotPosition: DotPosition.bottomCenter,
                                              dotVerticalPadding: 10.0,
                                              showIndicator: true,
                                              indicatorBgPadding: 7.0,
                                              images: [
                                                NetworkImage(wantedImages[0]['img'],),
                                                NetworkImage(wantedImages[1]['img'],),
                                                NetworkImage(wantedImages[2]['img'],),
                                                NetworkImage(wantedImages[3]['img'],)
                                              ],
                                            );
                                          }else{
                                            return Center(child: CircularProgressIndicator());
                                          }

                                        }
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 22.0,left: 18),
                                  child: Text("Catgories",style: GoogleFonts.archivo(
                                      fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context,index){
                                          return CategoryCard(index: index,snapshot: snapshot,categories: categories);
                                        },
                                        separatorBuilder: (context,index)=>SizedBox(width: 15,),
                                        itemCount: categories.length),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.only(top: 22.0,left: 18),
                                  child: Text("Popular Products",style: GoogleFonts.archivo(
                                      fontSize:20,color:Colors.white,fontWeight:FontWeight.w500),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                                  child: Container(
                                    height: 310,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListWheelScrollViewX.useDelegate(
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.004,
                                      squeeze: 1,

                                      scrollDirection: Axis.horizontal,
                                      itemExtent: 300,
                                      childDelegate: ListWheelChildBuilderDelegate(
                                          childCount: snapshot.data!.docs.length,
                                          builder: (BuildContext context, int index) {
                                            return PopularProductsCard(index:index,snapshot:snapshot);
                                          }),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.only(top: 22.0,left: 18,bottom: 25),
                                  child: Text("Offers and Discounts",style: GoogleFonts.archivo(
                                      fontSize:20,color:Colors.white,fontWeight:FontWeight.w500),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    height: 500,
                                    width: double.infinity,
                                    child: StaggeredGridView.countBuilder(
                                      crossAxisCount: 2,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context,index){
                                        return OfferCard(index: index,snapshot:snapshot);
                                      },
                                      staggeredTileBuilder: (int index)=>StaggeredTile.count(1, index.isEven?1.5:1.5),
                                      mainAxisSpacing: 8,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }else{
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                ) ,
              )
          ],
          ),

          _buildSearchBar()

        ],
      ),

      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 1.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: kToolbarHeight * 1.1,
          decoration: BoxDecoration(
            color: Colors.grey.shade900
          ),
          child: BottomNavigationBar(
            onTap: (index){
              setState(() {
                _selectedIndex = index;
              });
            },
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(size: 30),
            unselectedIconTheme: IconThemeData(size: 28),
            elevation: 0,
            items: [
              buildBottomNavigationBarItem('Home','New and true',Icons.home),
              buildBottomNavigationBarItem('Feed', 'Trending', Icons.dynamic_feed_outlined),
              buildBottomNavigationBarItem('Wishlist', 'Your wishlist', Icons.favorite),
              buildBottomNavigationBarItem('Account', '', Icons.person)

            ],

          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          backgroundColor: Colors.orange,
          onPressed: (){},
          child: Icon(Icons.add,size: 28,color: Colors.white,),
        ),
      ),

      resizeToAvoidBottomInset: false,

    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
            pinned: false,
            automaticallyImplyLeading: false,
            expandedHeight: _expandedHeight.toDouble(),
            backgroundColor: Colors.grey.shade900,
            title: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Axact Studios",style: GoogleFonts.museoModerno(fontSize: 27),),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Icon(Icons.format_align_left_rounded,size: 27,color: Colors.grey,),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Icon(Icons.shopping_cart_outlined,color: Colors.grey,size: 27,),
                  ),
                ),
              )
            ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
          ),
        );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(String label,String? toolTip,IconData icon) {
    return BottomNavigationBarItem(
          label: label,
          tooltip: toolTip,
          icon: Icon(icon),
        );
  }

  Widget _buildSearchBar() {

    //*****************************For moving the search bar along with the toolbar(ANIMATION)***********************
    final double defaultTopMargin = kToolbarHeight*2.6;
    double top = defaultTopMargin;
    if(_scrollController.hasClients){
      double offset = _scrollController.offset;
      top -=offset;
    }
    return Positioned(
      top: top,
      left: 28,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width*0.85,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ),
            hintText: 'Brand,fashion,trend,hand bag shoes...',
            suffixIcon: Icon(Icons.search_outlined,color: Colors.white,)
          ),
        ),
      ),
    );


  }
}
