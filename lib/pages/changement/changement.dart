import 'dart:ffi';

import 'package:data_table_2/data_table_2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/pages/changement/changer.dart';

import 'changement_controller.dart';

class Changement extends GetView<ChangementController> {
  //
  var box = GetStorage();
  //
  String searchValue = '';
  List comptes = [];
  String codeCompte = "";
  String libCompte = "";
  RxString dateEnregistrement = "".obs;
  //
  final ScrollController _firstController = ScrollController();

  //

  //
  List listeSaisies = [];
  //
  RxList Devises = ["USD", "CDF", "EUR"].obs;
  RxInt indexDevise = 0.obs;
  //
  Map compte = {};
  //
  RxList journals = [].obs;
  RxInt indexJournal = 0.obs;
  //
  RxString recherche = "".obs;
  //
  Changement() {
    //
    DateTime d = DateTime.now();
    //
    dateEnregistrement.value = "${d.day}-${d.month}-${d.year}";
    //
    // RawKeyboard.instance.addListener((e) {
    //   if (e is RawKeyDownEvent) {
    //     if (e.data.isModifierPressed(ModifierKey.controlModifier) &&
    //         e.logicalKey == LogicalKeyboardKey.keyS) {
    //       //
    //       //
    //       controller.enregistrerSaisie();
    //       //
    //     }
    //   }
    // });
    //
    journals.value = box.read("journaux") ?? [];
    //
    comptes = box.read("comptes") ?? [];
    //
    controller.tousLesSaisie();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Date"),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => Text(dateEnregistrement.value),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                    ).then((d) {
                      if (d != null) {
                        //
                        dateEnregistrement.value =
                            "${d!.day}-${d.month}-${d.year}";
                      }
                    });
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: controller.obx(
                      (state) {
                        List ll = state!;
                        return Scrollbar(
                          thumbVisibility: true,
                          showTrackOnHover: true,
                          //isAlwaysShown: true,
                          thickness: 10,
                          //scrollbarOrientation: ScrollbarOrientation.top,
                          controller: _firstController,
                          child: ListView(
                            controller: _firstController,
                            children: List.generate(ll.length, (index) {
                              Map data = ll[index];
                              print("date: ${data['date_enregistrement']}");
                              return Obx(
                                () => dateEnregistrement.value ==
                                        data['date_enregistrement']
                                    ? Card(
                                        elevation: 1,
                                        color: Colors.blue.shade100
                                            .withOpacity(0.2),
                                        child: Changer(data, index),
                                      )
                                    : Container(),
                              );
                              //return NouveauSaisie(ll[index], index);
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     //
          //     taux.clear();
          //     piece.clear();
          //     //
          //     libelle2.clear();
          //     montantDebit.clear();
          //     montantCredit.clear();
          //     intitule.clear();
          //     reference.clear();
          //     //
          //     controller.enregistrerSaisie();
          //     //
          //   },
          //   child: const Text("ENREGISTRER"),
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //
      //     print("liste ${controller.listesSaisies}");
      //   },
      //   child: Icon(Icons.abc),
      // ),
    );
  }

  //
}
