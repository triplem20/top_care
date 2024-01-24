import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 5,
        title: const Text(
          "Requests History",
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
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.center,
                                  width: 110,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: snap.data!.docs[index]['status'] ==
                                            'in Progress'
                                        ? Colors.yellow.shade900
                                        : snap.data!.docs[index]['status'] ==
                                                'Accepted'
                                            ? CupertinoColors.activeBlue
                                            : Colors.red,
                                  ),
                                  child: const Text(
                                    'in Progress',
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
