import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompteResultatCaisse extends StatelessWidget {
  //
  var box = GetStorage();
  //
  Map choixCaisse = {};
  //
  RxList journalsCaisses = [].obs;
  RxDouble caissePayer = 0.0.obs;
  RxDouble caisseNonPayer = 0.0.obs;
  RxDouble totalCaisse = 0.0.obs;
  ///////////////////////////
  String exercice = "";
  //
  CompteResultatCaisse(this.choixCaisse) {
    exercice = box.read("exercice") ?? "";
    journalsCaisses.value = box.read("${choixCaisse['nom']}$exercice") ?? [];
    //
    encaissementDecaissement();
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
          color: Colors.black,
          height: 30,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Text(
            "${choixCaisse['nom']}",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ),
        SizedBox(
          height: Get.size.height / 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        color: Colors.black,
                        child: const Text(
                          "ENCAISSEMENT",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.teal.shade100,
                                child: const Text("Montant"),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                width: double.maxFinite,
                                alignment: Alignment.center,
                                color: Colors.grey.shade300,
                                child: Obx(
                                  () => Text(
                                    "${caissePayer.value}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        color: Colors.black,
                        child: const Text(
                          "DÉCAISSEMENT",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.teal.shade100,
                                child: const Text("Montant"),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                width: double.maxFinite,
                                alignment: Alignment.center,
                                color: Colors.grey.shade300,
                                child: Obx(
                                  () => Text(
                                    "${caisseNonPayer.value}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.teal.shade100,
                  child: const Text("Total"),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  color: Colors.grey.shade300,
                  child: Obx(
                    () => Text(
                      "${totalCaisse.value}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //
  encaissementDecaissement() {
    //
    double mt1 = 00;
    double mt2 = 00;
    //
    for (var e in journalsCaisses) {
      //
      if (e['Encaissement'] == "") {
        //
        caissePayer.value = caissePayer.value + e['totalF'];
        print("mt1: $mt1");
        print("mt11: ${e['totalF']}");
        print("____________________");
      } else {
        //
        List ps = e['produits_services'];
        for (var s in ps) {
          //double.parse(s[''])
          if ("${s['montant_tva']}" != "") {
            caisseNonPayer.value = caisseNonPayer.value +
                (double.parse(s['prix_unitaire']) *
                    double.parse(s['quantite'])) +
                double.parse("${s['montant_tva']}");
          }
        }
        print("mt2: $mt2");
        print("******************");
        //mt2 = mt2 + e['totalF'];
      }
      //
      totalCaisse.value = caissePayer.value - caisseNonPayer.value;
    }
    //*
    //**************
  }
}
