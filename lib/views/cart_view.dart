import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 5,
        title: const Text(
          "Cart",
          style: TextStyle(
              fontSize: 20, fontFamily: 'primary', color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: 1500,
        child: ListView(
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              height: 1310,
              width: 500,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Requests')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snap) {
                    if (snap.hasError) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    if (!snap.hasData) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    if (snap == null) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snap.data!.size,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 150,
                        width: 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(1, 1),
                                  blurRadius: 5,
                                  spreadRadius: 7),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(snap
                                          .data!.docs[index]['imageUrl']
                                          .toString()))),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  snap.data!.docs[index]['title'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'primary',
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  snap.data!.docs[index]['category'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'primary',
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  snap.data!.docs[index]['Price'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'primary',
                                      color: Colors.teal),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: snap.data!.docs[index]
                                                    ['status'] ==
                                                'in Progress'
                                            ? Colors.yellow.shade900
                                            : snap.data!.docs[index]
                                                        ['status'] ==
                                                    'Accepted'
                                                ? CupertinoColors.activeBlue
                                                : snap.data!.docs[index]
                                                            ['status'] ==
                                                        'Canceled'
                                                    ? Colors.grey
                                                    : Colors.red,
                                      ),
                                      child: Text(
                                        snap.data!.docs[index]['status'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'primary',
                                            fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          Get.dialog(
                                            Center(
                                              child: Container(
                                                height: 150.h,
                                                width: 250.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      'Cancel Request ?',
                                                      style: TextStyle(
                                                          fontFamily: 'primary',
                                                          fontSize: 19),
                                                    ),
                                                    SizedBox(
                                                      height: 35.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10))),
                                                            onPressed:
                                                                () async {
                                                              var id = snap
                                                                  .data!
                                                                  .docs[index]
                                                                      ['id']
                                                                  .toString();
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Requests')
                                                                  .doc(id)
                                                                  .update({
                                                                'status':
                                                                    'Canceled',
                                                              });
                                                            },
                                                            child: Text(
                                                              'Confirm',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red
                                                                      .shade400,
                                                                  fontFamily:
                                                                      'primary',
                                                                  fontSize: 19),
                                                            )),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10))),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                      'primary',
                                                                  fontSize: 19),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.red.shade900,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
