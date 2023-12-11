import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangementController extends GetxController with StateMixin<List> {
//
  RxList<Widget> listes = <Widget>[].obs;
  RxList<Map> listesSaisies = <Map>[].obs;
  //
  var box = GetStorage();
  //
  tousLesSaisie() async {
    change([], status: RxStatus.loading());
    //
    var exercice = box.read("exercice") ?? "";
    //
    List saisies = box.read("saisies$exercice") ?? [];
    print("saisies: $saisies");
    //
    change(saisies, status: RxStatus.success());
  }

//
  enregistrerSaisie() {
    //
    var exercice = box.read("exercice") ?? "";
    //
    List saisies = box.read("saisies$exercice") ?? [];
    //
    saisies.addAll(listesSaisies);
    //saisies.add(code);
    //
    box.write("saisies$exercice", saisies);
    //
    listesSaisies.clear();
    //
    tousLesSaisie();
    Get.snackbar("Succès", "Enregistrement éffectué avec succès");
  }

//
  saisieListe(Map d) {
    listesSaisies.add(d);
    //
    tousLesSaisie();
    //
  }

  DeletesaisieListe(int i) {
    listesSaisies.removeAt(i);
    //
    tousLesSaisie();
    //
  }

  //
  miseAjour(Map data) {
    var exercice = box.read("exercice") ?? "";
    //
    List saisies = box.read("saisies$exercice") ?? [];
    saisies.forEach((element) {
      if (element['id'] == data['id']) {
        //
        print("data: $data");
        //
        element = data;
      }
    });

    //
    Get.back();
    //
    box.write("saisies$exercice", saisies);
    change(saisies, status: RxStatus.success());
  }

  //
  supprimer(String id) {
    var exercice = box.read("exercice") ?? "";
    //
    List saisies = box.read("saisies$exercice") ?? [];
    for (int i = 0; i < saisies.length; i++) {
      if (id == saisies[i]['id']) {
        //
        saisies.removeAt(i);
      }
    }

    //
    Get.back();
    //
    box.write("saisies$exercice", saisies);
    change(saisies, status: RxStatus.success());
  }
}
