import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class PopularProductsCard extends StatelessWidget {
  final int index;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const PopularProductsCard({Key? key, required this.index,required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = snapshot.data!.docs[index];

    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(doc['firebaseUrl']),
                fit: BoxFit.contain),
          ),
        ),
        Container(
          height: 140,
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRowOne(doc),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    doc['company'],
                    style: GoogleFonts.acme(
                        fontSize: 17,
                        color: Colors.grey.withOpacity(0.5),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                buildRowTwo(doc)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildRowTwo(QueryDocumentSnapshot<Object?> doc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Rs ${doc['price']}",
          style: GoogleFonts.acme(fontSize: 20, color: Colors.white54),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 20,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 20,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row buildRowOne(QueryDocumentSnapshot<Object?> doc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200,
          height: 30,
          child: Text(
            doc['productName'],
            style: GoogleFonts.acme(
                fontWeight: FontWeight.w500, color: Colors.white54, fontSize: 25),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(
                Icons.star,
                color: Colors.orangeAccent,
              ),
            ),
            Text(
              "(${doc['rating']})",
              style: GoogleFonts.acme(
                  fontWeight: FontWeight.w400, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
