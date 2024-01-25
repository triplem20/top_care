import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_care/controllers/homeController.dart';
import 'package:top_care/models/serviceModel.dart';
import 'package:top_care/views/request.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var stream = FirebaseFirestore.instance.collection('services').snapshots();
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: const CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot == null) {
            return Center(child: const CircularProgressIndicator());
          }
          var data = snapshot.data;

          return Scaffold(
              body: SafeArea(
                  child: SizedBox(
            height: 1000.h,
            child: ListView(children: [
              Container(
                height: 250.h,
                width: 480.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/cleaning.jpeg'))),
              ),
              const Text(
                "                   Home Services",
                style: TextStyle(fontFamily: 'primary', fontSize: 24),
              ),
              const Text(
                "                 Home Services are available",
                style: TextStyle(
                    fontFamily: 'primary', fontSize: 18, color: Colors.grey),
              ),
              Container(
                height: 300.h,
                width: 700.w,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => Request(
                            serviceModel: ServiceModel(
                                id: data.docs[index]['id'],
                                title: data.docs[index]['title'],
                                image: data.docs[index]['image'],
                                description: data.docs[index]['Description'],
                                price: data.docs[index]['Price'],
                                category: data.docs[index]['category'])));
                      },
                      child: Container(
                        width: 200.w,
                        margin: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: 200.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        data.docs[index]['image'])),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      '${data.docs[index]['Price']} SDG',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'primary',
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 48.w,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: const Icon(
                                      Icons.add_circle,
                                      size: 37,
                                      color: Colors.teal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              data.docs[index]['title'],
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'primary'),
                            ),
                            const SizedBox(height: 4.0),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          )));
        });
  }
}
