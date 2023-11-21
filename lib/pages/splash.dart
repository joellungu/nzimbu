import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nzimbu/main.dart';
import 'package:nzimbu/pages/accueil.dart';
import 'package:nzimbu/pages/application.dart';

class Splash extends StatelessWidget {
  //
  Splash() {
    //
    Timer(const Duration(seconds: 1), () {
      Get.offAll(Accueil());
    });
  }
  //
  load(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/entite.json");
    print("data: $data");
    entiteAdmin = jsonDecode(data);
    print("data: ${entiteAdmin.length}");
    //
    Get.offAll(Application());
  }

  //
  @override
  Widget build(BuildContext context) {
    //

    //load(context);
    //
    return Scaffold();
  }
}
