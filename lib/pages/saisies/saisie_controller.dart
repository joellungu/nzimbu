import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SaisieController extends GetxController with StateMixin<List> {
//
  RxList<Widget> listes = <Widget>[].obs;
  RxList<Map> listesSaisies = <Map>[].obs;
  //
  var box = GetStorage();
  //
  tousLesSaisie() async {
    change([], status: RxStatus.loading());
    //
    //List saisies = box.read("saisies") ?? [];
    //
    //print("saisies: $saisies");
    //
    change(listesSaisies, status: RxStatus.success());
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
}
