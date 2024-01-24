import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:top_care/controllers/homeController.dart';
import 'package:top_care/models/serviceModel.dart';

class Request extends StatefulWidget {
  Request({super.key, required this.serviceModel});
  ServiceModel serviceModel;

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  String dropVal = '';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeViewModel());
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              width: 700,
              height: 300,
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  widget.serviceModel.price.toString(),
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'primary', color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(widget.serviceModel.image.toString()))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              SizedBox(
                width: 20,
              ),
              Text(
                widget.serviceModel.title.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'primary'),
              ),
              SizedBox(
                width: 60,
              ),
              DropdownButton<String>(
                items: <String>['Today', 'Tommorrow', 'This week']
                    .map((String value) {
                  dropVal = value;
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropVal = newValue.toString();
                    print(dropVal);
                  });
                },
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            const Text("     description:",
                style: TextStyle(fontFamily: 'primary', fontSize: 19)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.serviceModel.description.toString(),
                  style: TextStyle(
                      fontFamily: 'primary', fontSize: 16, color: Colors.grey)),
            ),
            SizedBox(
              height: 80,
            ),
            RoundedLoadingButton(
                color: Colors.teal,
                controller: controller.btnCNTL,
                onPressed: () {
                  controller.addRequest(widget.serviceModel, dropVal);
                },
                child: Text(
                  "Request",
                  style: TextStyle(
                      fontFamily: 'primary', fontSize: 18, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
