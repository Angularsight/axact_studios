



import 'dart:ui';

import 'package:axact_studios/util/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;
  final List<dynamic> categories;
  const CategoryCard({Key? key,required this.index,required this.snapshot,required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final doc = snapshot.data!.docs[index];

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width*0.4,
      decoration: BoxDecoration(
        color: Util.getColor(index),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(child: Text(categories[index],style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 18),)),
    );
  }
}
