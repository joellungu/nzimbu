import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JournalController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesClients() async {
    change([], status: RxStatus.loading());
    //
    List journaux = box.read("journaux") ?? [];
    //
    print("journaux: $journaux");
    //
    change(journaux, status: RxStatus.success());
  }

  //
  supprimer(int index, String intitule, List journaux) {
    change([], status: RxStatus.loading());
    //
    var exercice = box.read("exercice") ?? "";
    //
    List saisies = box.read("saisies$exercice") ?? [];
    bool supp = true;
    saisies.forEach((element) {
      //
      if (element['journale']['intitule'] == intitule) {
        supp = false;
      }
    });
    //
    if (supp) {
      journaux.removeAt(index);
      box.write("journaux", journaux);
      tousLesClients();
    } else {
      Get.snackbar(
        "Erreur",
        "Ce journal a déjà des enregistrement",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    change(journaux, status: RxStatus.success());
  }

//
  enregistrerClient(Map code) {
    //
    List journaux = box.read("journaux") ?? [];
    //
    journaux.add(code);
    //
    box.write("journaux", journaux);
    //
    tousLesClients();
  }
}
