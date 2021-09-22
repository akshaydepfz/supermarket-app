import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  final String image;
  final String productname;
  final double price;

  const CartScreen(
      {required this.image, required this.productname, required this.price});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    int index = 1;
    void launchWhatsapp({required number, required message}) async {
      String url = 'whatsapp://send?phone=$number&text=$message';
      await canLaunch(url) ? launch(url) : print('cant  open Whatsapp');
    }

    void getData() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.get('name');
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launchWhatsapp(
              number: '+919946152058',
              message:
                  'No. $index \n---------------------------------------------\n Product Name : ${widget.productname}  \nPrice : ${widget.price} \nquantity: $quantity \n');
        },
        backgroundColor: Colors.purple,
        label: Text(
          'Go Checkout',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My cart'),
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              Hero(
                tag: widget.price,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.shade100,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: widget.image,
                          child: Text(
                            widget.productname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.fade),
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.remove),
                        ),
                        Text(
                          '1',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120.w,
                        ),
                        Text(
                          'AED ${widget.price}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
