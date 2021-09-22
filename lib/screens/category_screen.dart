import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vortez_supermarket_app/screens/item_view_screen.dart';
import 'package:vortez_supermarket_app/widgets/single_product.dart';

class CategoryScreen extends StatelessWidget {
  final String id;
  final String colloection;
  CategoryScreen({required this.id, required this.colloection});

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.orangeAccent.shade100,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.expand_more,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('categories')
                  .doc(id)
                  .collection(colloection)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
                if (!snapshort.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshort.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3.0,
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    var data = snapshort.data!.docs[index];
                    return SingleProduct(
                      image: data['productImage'],
                      price: data['ProductPrice'],
                      offer: data['productOffer'],
                      title: data['productName'],
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemViewScreen(
                                    prodectImage: data['productImage'],
                                    productName: data['productName'],
                                    productPrice: data['ProductPrice'],
                                    productsubtitle: 'productsubtitle')));
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
