import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vortez_supermarket_app/screens/cart_screen.dart';
import 'package:vortez_supermarket_app/screens/category_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vortez_supermarket_app/screens/item_view_screen.dart';
import 'package:vortez_supermarket_app/widgets/category_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.orange,
        ),
        home: Homescreen(),
      ),
      designSize: Size(414, 896),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LOGO',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.orange,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 35.w, right: 35.w, top: 29.h, bottom: 26.h),
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search anything.'),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 180.h,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("slider")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange),
                        );
                      }

                      return CarouselSlider.builder(
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index, ind) {
                          DocumentSnapshot sliderImage =
                              stramSnapshot.data!.docs[index];
                          Object? getImage = sliderImage.data();
                          return Image.network(
                            stramSnapshot.data!.docs[index]['image'],
                            fit: BoxFit.fill,
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          initialPage: 0,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Flash Sale',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 220.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("FlashSaleList")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemViewScreen(
                                          prodectImage: stramSnapshot.data!
                                              .docs[index]['productImage'],
                                          productName: stramSnapshot
                                              .data!.docs[index]['productName'],
                                          productPrice: stramSnapshot.data!
                                              .docs[index]['productPrice'],
                                          productsubtitle: 'productsubtitle')));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: stramSnapshot.data!.docs[index]
                                      ['productPrice'],
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    alignment: Alignment.topRight,
                                    height: 134.h,
                                    width: 127.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(stramSnapshot
                                            .data!.docs[index]['productImage']),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stramSnapshot.data!.docs[index]
                                            ['productName'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'AED ${stramSnapshot.data!.docs[index]['productPrice']}'
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.purple,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'categories',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 80.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("categories")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return CategoryList(
                            image: stramSnapshot.data!.docs[index]
                                ['categoryImage'],
                            categoryName: stramSnapshot.data!.docs[index]
                                ['categoryName'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                    colloection: stramSnapshot.data!.docs[index]
                                        ['categoryName'],
                                    id: stramSnapshot.data!.docs[index].id,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Best Deals',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 220.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("FlashSaleList")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemViewScreen(
                                          prodectImage: stramSnapshot.data!
                                              .docs[index]['productImage'],
                                          productName: stramSnapshot
                                              .data!.docs[index]['productName'],
                                          productPrice: stramSnapshot.data!
                                              .docs[index]['productPrice'],
                                          productsubtitle: 'productsubtitle')));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  alignment: Alignment.topRight,
                                  height: 134.h,
                                  width: 127.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(stramSnapshot
                                          .data!.docs[index]['productImage']),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stramSnapshot.data!.docs[index]
                                            ['productName'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'AED ${stramSnapshot.data!.docs[index]['productPrice']}'
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.purple,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 180.h,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("slider")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple),
                        );
                      }

                      return CarouselSlider.builder(
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index, ind) {
                          DocumentSnapshot sliderImage =
                              stramSnapshot.data!.docs[index];
                          Object? getImage = sliderImage.data();
                          return Image.network(
                            stramSnapshot.data!.docs[index]['image'],
                            fit: BoxFit.fill,
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          initialPage: 0,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Top Sellers',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 220.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("TopSellers")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemViewScreen(
                                      prodectImage: stramSnapshot
                                          .data!.docs[index]['productImage'],
                                      productName: stramSnapshot
                                          .data!.docs[index]['productName'],
                                      productPrice: stramSnapshot
                                          .data!.docs[index]['productPrice'],
                                      productsubtitle: 'productsubtitle'),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  alignment: Alignment.topRight,
                                  height: 134.h,
                                  width: 127.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(stramSnapshot
                                          .data!.docs[index]['productImage']),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stramSnapshot.data!.docs[index]
                                            ['productName'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'AED ${stramSnapshot.data!.docs[index]['productPrice']}'
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            stramSnapshot.data!.docs[index]
                                                ['productOffer'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'People also search for',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  height: 220.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("BestDeals")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> stramSnapshot) {
                      if (!stramSnapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: stramSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemViewScreen(
                                          prodectImage: stramSnapshot.data!
                                              .docs[index]['productImage'],
                                          productName: stramSnapshot
                                              .data!.docs[index]['productName'],
                                          productPrice: stramSnapshot.data!
                                              .docs[index]['productPrice'],
                                          productsubtitle: 'productsubtitle')));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  alignment: Alignment.topRight,
                                  height: 134.h,
                                  width: 127.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(stramSnapshot
                                          .data!.docs[index]['productImage']),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stramSnapshot.data!.docs[index]
                                            ['productName'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'AED ${stramSnapshot.data!.docs[index]['productPrice']}'
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            stramSnapshot.data!.docs[index]
                                                ['productOffer'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
