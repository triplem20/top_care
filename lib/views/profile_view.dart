import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_care/views/login.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = '';
    String phoneNum = '';
    String address = '';
    String userEmail = '';

    userData() async {
      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userName = doc['name'];
      userEmail = doc['email'];
      phoneNum = doc['phone'];
      address = doc['adress'];
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: userData(),
                builder: (cntx, s) => Container(
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: 400,
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName ?? '',
                                  style: TextStyle(
                                    fontFamily: 'primary',
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      address,
                                      style: TextStyle(
                                        fontFamily: 'primary',
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email_outlined,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      userEmail.toString() ?? '',
                                      style: TextStyle(
                                        fontFamily: 'primary',
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      phoneNum.toString() ?? '',
                                      style: TextStyle(
                                        fontFamily: 'primary',
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 120,
                              width: 120,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/images/profile.png',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.to(() => const LoginView());
                          },
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.exit_to_app),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Sign out",
                                  style: TextStyle(fontFamily: 'primary'),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        )
                      ]),
                ),
              ),
              Text(
                "                        Requests History",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'primary',
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                height: 410,
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
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
      ),
    );
  }
}
