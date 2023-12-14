import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompteController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesClients() async {
    change([], status: RxStatus.loading());
    //
    List comptes = box.read("comptes") ?? [];
    //
    for (int i = 0; i < comptes.length; i++) {
      //Map ss = resultats[i];

      for (int j = 0; j < comptes.length; j++) {
        //

        Map ii = comptes[i];
        Map jj = comptes[j];
        if (ii['numero_de_compte'] != null && jj['numero_de_compte'] != null) {
          //String d = "788";
          //var dx = d[0];
          //print("resultats : dx $dx :: $d");
          int li =
              int.parse(ii['numero_de_compte'][0] + ii['numero_de_compte'][1]);
          //d0.isBefore(d1)

          int lj =
              int.parse(jj['numero_de_compte'][0] + jj['numero_de_compte'][1]);
          //d1.isBefore(d2)
          if (li < lj) {
            //resultats[i] < resultats[j]
            Map tmp = comptes[i];
            comptes[i] = comptes[j];
            print("la valeur de listeDate[$i] = ${comptes[i]}");
            comptes[j] = tmp;
            print("et la valeur de listeDate[$j] = ${comptes[j]}");
          }
        }
      }
    }
    //
    print("comptes: $comptes");
    //
    change(comptes, status: RxStatus.success());
  }

//
  supprimer(int index, String intitule, List comptes) {
    change([], status: RxStatus.loading());
    //
    var exercice = box.read("exercice") ?? "";
    //
    List saisies = box.read("saisies$exercice") ?? [];
    bool supp = true;
    saisies.forEach((element) {
      //
      if (element['comptes']['intitule'] == intitule) {
        supp = false;
      }
    });
    //
    if (supp) {
      comptes.removeAt(index);
      box.write("comptes", comptes);
      tousLesClients();
    } else {
      Get.snackbar(
        "Erreur",
        "Ce journal a déjà des enregistrement",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    change(comptes, status: RxStatus.success());
  }

//
  enregistrerClient(Map code) {
    //
    List codes = box.read("comptes") ?? [];
    //
    codes.add(code);
    //
    box.write("comptes", codes);
    //
    tousLesClients();
  }
}
