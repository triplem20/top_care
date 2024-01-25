import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:top_care/models/serviceModel.dart';

class HomeViewModel extends GetxController {
  RoundedLoadingButtonController btnCNTL = RoundedLoadingButtonController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;
  final CollectionReference _requests =
      FirebaseFirestore.instance.collection('Requests');
  var userDoc;

  addRequest(ServiceModel serviceModel, String date) async {
    try {
      btnCNTL.start();
      userDoc =
          await database.collection('users').doc(auth.currentUser!.uid).get();
      await _requests.doc(DateTime.now().toString().substring(0, 16)).set({
        'id': DateTime.now().toString().substring(0, 16),
        'title': serviceModel.title,
        'Description': serviceModel.description,
        'Price': serviceModel.price,
        'imageUrl': serviceModel.image,
        'category': serviceModel.category,
        'uid': auth.currentUser!.uid,
        'userName': userDoc['name'],
        'email': userDoc['email'],
        'date': date,
        'status': 'in Progress',
        'serviceid': serviceModel.id
      });
      btnCNTL.stop();
      EasyLoading.showSuccess('Request added successfully');
    } catch (e) {
      print(e.toString());
      btnCNTL.stop();
    }
    btnCNTL.reset();
  }
}
