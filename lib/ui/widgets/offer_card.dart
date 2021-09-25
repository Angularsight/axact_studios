import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class OfferCard extends StatelessWidget {
  final int index;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const OfferCard({Key? key, required this.index,required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = snapshot.data!.docs[index];
    return Stack(children: [

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(doc['imageUrl']),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height:50,
                          width: 120,
                          child: Text(
                            doc['productName'],
                            style: GoogleFonts.acme(
                                fontWeight: FontWeight.w500,
                                color: Colors.white54,
                                fontSize: 20),
                          ),
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildInkWell(Icons.favorite_border, Colors.redAccent,doc),
                        buildInkWell(Icons.shopping_cart_outlined, Colors.orange,doc),
                        buildInkWell(Icons.share_rounded, Colors.blueAccent,doc)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

      Positioned(
        left: 8,
        top: 8,
        child: Badge(
          elevation: 10,
          badgeContent: Text("${doc['offer']} off",style: GoogleFonts.acme(),),
          shape: BadgeShape.square,
          animationDuration: Duration(seconds: 2),
          animationType: BadgeAnimationType.slide,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),

        ),
      )

    ]);
  }

  Padding buildInkWell(IconData icon, Color color, QueryDocumentSnapshot<Object?> doc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          if(icon==Icons.share_rounded ){
            print('Pressed');
            Share.share('Product Name is trending buy it before it gets sold \n\n ${doc['websiteLink']}');
          }
        },
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                offset: Offset(1, 1),
                color: Colors.grey.shade400,
                blurRadius: 2)
          ]),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
