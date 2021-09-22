import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vortez_supermarket_app/screens/cart_screen.dart';

class ItemViewScreen extends StatelessWidget {
  final String prodectImage;
  final String productName;
  final double productPrice;
  final String productsubtitle;

  const ItemViewScreen(
      {required this.prodectImage,
      required this.productName,
      required this.productPrice,
      required this.productsubtitle});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120.r),
                ),
                color: Color(0xFF2B0B49),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 37.h, left: 20.w, bottom: 30.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Expanded(
                      child: Hero(
                        tag: productPrice,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(prodectImage),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 21.h,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(120.r),
                  ),
                  color: Color(0xFFFFF4E1),
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: prodectImage,
                      child: Text(
                        productName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      productsubtitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '$productPrice AED / KG',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove),
                        ),
                        Text(
                          '1',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 59.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(
                                    image: prodectImage,
                                    productname: productName,
                                    price: productPrice),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  30.r,
                                ),
                                topLeft: Radius.circular(30.r),
                              ),
                              color: Color(0xFF240046),
                            ),
                            height: 85.h,
                            width: 243.w,
                            child: Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      designSize: Size(
        414,
        896,
      ),
    );
  }
}
