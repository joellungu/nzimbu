import 'dart:ffi';

import 'package:nzimbu/pages/compte_resultat.dart/compte_resultat_caisse.dart';
import 'package:nzimbu/pages/parametres/code_comptable/code_comptable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompteDesResultats extends StatelessWidget {
  //
  var box = GetStorage();
  //Vente
  //
  RxList journalsVentes = [].obs;
  RxDouble ventePayer = 0.0.obs;
  RxDouble venteNonPayer = 0.0.obs;
  RxDouble totalVente = 0.0.obs;
  //
  RxList journalsAchats = [].obs;
  RxDouble achatPayer = 0.0.obs;
  RxDouble achatNonPayer = 0.0.obs;
  RxDouble totalAchat = 0.0.obs;
  //
  RxList journalsCaisses = [].obs;
  RxDouble caissePayer = 0.0.obs;
  RxDouble caisseNonPayer = 0.0.obs;
  RxDouble totalCaisse = 0.0.obs;
  //
  List comptes = [];
  ///////////////////////////
  String exercice = "";
  CompteDesResultats() {
    //Vente
    exercice = box.read("exercice") ?? "";
    journalsVentes.value = box.read("ventes$exercice") ?? [];
    //Calcule de l'argent encaissé par les facture de vente
    factureVentePayer();
    //
    journalsAchats.value = box.read("achats$exercice") ?? [];
    //
    factureAchatPayer();
    //
    comptes = box.read("comptes") ?? [];
    //journalsCaisses.value = box.read("caisses$exercice") ?? [];
    //
    //encaissementDecaissement();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Compt des resultats $exercice",
              style: TextStyle(
                fontSize: 15,
                color: Colors.teal.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.size.height / 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          color: Colors.black,
                          child: const Text(
                            "FACTURE DE VENTE PAYÉ",
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
                                      "${ventePayer.value}",
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          color: Colors.black,
                          child: const Text(
                            "FACTURE DE VENTE NON PAYÉ",
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
                                      "${venteNonPayer.value}",
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
              ],
            ),
          ),
          SizedBox(
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
                        "${totalVente.value}",
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
          SizedBox(
            height: Get.size.height / 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          color: Colors.black,
                          child: const Text(
                            "FACTURE D'ACHAT PAYÉ",
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
                                      "${achatPayer.value}",
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          color: Colors.black,
                          child: const Text(
                            "FACTURE D'ACHAT NON PAYÉ",
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
                                      "${achatNonPayer.value}",
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
                        "${totalAchat.value}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: List.generate(comptes.length,
                (index) => CompteResultatCaisse(comptes[index])),
          ),
          SizedBox(
            height: Get.size.height / 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          color: Colors.black,
                          child: const Text(
                            "TOTAL GÉNÉRAL",
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
                                  color: Colors.teal.shade100,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  color: Colors.grey.shade300,
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
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //
      //     box.write("ventes$exercice", []);
      //     box.write("ventes$exercice", []);
      //   },
      //   child: Icon(Icons.clean_hands),
      // ),
    );
  }

  //
  //Calcule de l'argent encaissé par les facture de vente
  factureVentePayer() {
    //
    double mt1 = 00;
    double mt2 = 00;
    //
    for (var e in journalsVentes) {
      //
      if (e['solder'] == 1) {
        //
        ventePayer.value = ventePayer.value + e['totalF'];
        print("mt1: $mt1");
        print("mt11: ${e['totalF']}");
        print("____________________");
      } else {
        //
        List ps = e['produits_services'];
        for (var s in ps) {
          //double.parse(s[''])
          if ("${s['montant_tva']}" != "") {
            venteNonPayer.value = venteNonPayer.value +
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
      totalVente.value = ventePayer.value - venteNonPayer.value;
    }
  }

//
  //
  factureAchatPayer() {
    //
    double mt1 = 00;
    double mt2 = 00;
    //
    for (var e in journalsAchats) {
      //
      if (e['solder'] == 1) {
        //
        achatPayer.value = achatPayer.value + e['totalF'];
        print("mt1: $mt1");
        print("mt11: ${e['totalF']}");
        print("____________________");
      } else {
        //
        List ps = e['produits_services'];
        for (var s in ps) {
          //double.parse(s[''])
          if ("${s['montant_tva']}" != "") {
            achatNonPayer.value = achatNonPayer.value +
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
      totalAchat.value = achatPayer.value - achatNonPayer.value;
    }
    //*
    //**************
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
