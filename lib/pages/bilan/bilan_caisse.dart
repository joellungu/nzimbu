import 'dart:convert';

import 'package:nzimbu/utils/caisse_entite.dart';
import 'package:nzimbu/utils/vente_entite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BilanCaisse extends StatefulWidget {
  //
  Map choixCaisse = {};
  //
  BilanCaisse(this.choixCaisse);
  //
  @override
  State<StatefulWidget> createState() {
    //
    return _BilanCaisse();
  }
}

class _BilanCaisse extends State<BilanCaisse> {
  //
  var box = GetStorage();
  //
  //Map choixCaisse = {};
  //
  RxList journalsCaisses = [].obs;
  String exercice = "";
  RxString totalVide = "".obs;
  //
  RxString recherche = "".obs;
  //
  List typeCaisses = ["Encaissement", "Décaissement"];
  RxString typeCaisse = "Encaissement".obs;
  RxInt indexTypeCaisse = 0.obs;
  //
  RxDouble totalDebit = 0.0.obs;
  RxDouble totalCredit = 0.0.obs;
  //
  Rx<TextEditingController> ddepart = Rx(TextEditingController());
  Rx<TextEditingController> dfin = Rx(TextEditingController());

//

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    exercice = box.read("exercice") ?? "";
    journalsCaisses.value =
        box.read("${widget.choixCaisse['nom']}$exercice") ?? [];
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.choixCaisse['nom']}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            child: SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 200,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: indexTypeCaisse.value,
                          onChanged: (c) {
                            //
                            exercice = box.read("exercice") ?? "";
                            journalsCaisses.value = box.read(
                                    "${widget.choixCaisse['nom']}$exercice") ??
                                [];
                            //
                            //setState(() {
                            indexTypeCaisse.value = c as int;
                            typeCaisse.value =
                                typeCaisses[indexTypeCaisse.value];
                            //});
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          dropdownColor: Colors.black,
                          items: List.generate(
                            typeCaisses.length,
                            (index) => DropdownMenuItem(
                              value: index,
                              child: Text(
                                "${typeCaisses[index]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      onChanged: (t) {
                        //
                        //recherche.value = "";
                        recherche.value = t;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        //
                        //DateTime d = DateTime.now();
                        //
                        //recherche.value = "${d.day}-${d.month}-${d.year}";
                        //
                      },
                      icon: const Icon(
                        Icons.print_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => TextField(
                              controller: ddepart.value,
                              decoration: const InputDecoration(
                                label: Text(
                                  "1-1-2000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: 55,
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              //
                              //DateTime d = DateTime.now();
                              //
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030))
                                  .then((d) {
                                if (d != null) {
                                  //
                                  totalCredit.value = 0.0;
                                  totalDebit.value = 0.0;
                                  //
                                  exercice = box.read("exercice") ?? "";
                                  journalsCaisses.value = box.read(
                                          "${widget.choixCaisse['nom']}$exercice") ??
                                      [];
                                  //
                                  ddepart.value.text =
                                      "${d!.day}-${d.month}-${d.year}";
                                  //

                                  print("depart_${ddepart.value.text}__");
                                  //
                                }
                              });
                              //recherche.value = "${d.day}-${d.month}-${d.year}";
                              //
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => TextField(
                              controller: dfin.value,
                              decoration: const InputDecoration(
                                label: Text(
                                  "31-12-2000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: 55,
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              //
                              //DateTime d = DateTime.now();
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030))
                                  .then((d) {
                                if (d != null) {
                                  //
                                  totalCredit.value = 0.0;
                                  totalDebit.value = 0.0;
                                  //
                                  exercice = box.read("exercice") ?? "";
                                  journalsCaisses.value = box.read(
                                          "${widget.choixCaisse['nom']}$exercice") ??
                                      [];
                                  //
                                  dfin.value.text =
                                      "${d!.day}-${d.month}-${d.year}";
                                }
                              });
                              //recherche.value = "${d.day}-${d.month}-${d.year}";
                              //
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      totalCredit.value = 0.0;
                      totalDebit.value = 0.0;
                      //testDate();
                      setState(() {});
                    },
                    child: Container(
                      height: 55,
                      //width: 55,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        " Afficher ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black,
            width: double.maxFinite,
            height: 40,
            padding: EdgeInsets.only(left: 35, right: 35),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: const Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        "Débit\n${totalDebit.value}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        "Crédit\n${totalCredit.value}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
              children: List.generate(journalsCaisses.length, (index) {
                //

                //
                Map caisse = journalsCaisses[index];
                //
                RxDouble totalF = 0.0.obs;
                //
                caisse["totalF"] = caisse["totalF"] ?? totalF.value;
                //
                totalVide.value = "";
                //date_enregistrement
                /////////:Pour les intervals de temps...
                RxList depart_ = ddepart.value.text.split("-").obs;
                RxList enregistrer_ =
                    "${caisse['date_enregistrement']}".split("-").obs;
                RxList fin_ = dfin.value.text.split("-").obs;
                //______________________________________________
                print("depart_${depart_}__");
                print("enregistrer_${enregistrer_}__");
                print("fin_${fin_}__");
                //______________________________________________
                DateTime depart = DateTime.now();
                DateTime enregistrer = DateTime.now();
                DateTime fin = DateTime.now();
                //______________________________________________
                if ((depart_.length > 2) &&
                    (enregistrer_.length > 2) &&
                    (fin_.length > 2)) {
                  depart = DateTime(int.parse(depart_[2]),
                      int.parse(depart_[1]), int.parse(depart_[0]));
                  enregistrer = DateTime(int.parse(enregistrer_[2]),
                      int.parse(enregistrer_[1]), int.parse(enregistrer_[0]));
                  fin = DateTime(int.parse(fin_[2]), int.parse(fin_[1]),
                      int.parse(fin_[0]));
                }
                //______________________________________________
                ///
                if ((depart.isBefore(enregistrer) ||
                        ddepart.value.text ==
                            "${caisse['date_enregistrement']}") &&
                    (fin.isAfter(enregistrer) ||
                        dfin.value.text ==
                            "${caisse['date_enregistrement']}")) {
                  print("vente: ${jsonEncode(caisse)}");
                  //////////:Pour le type d'opération////////
                  if (("${caisse['date_enregistrement']}"
                              .toLowerCase()
                              .contains(recherche.value.toLowerCase()) ||
                          "${caisse['note']}"
                              .toLowerCase()
                              .contains(recherche.value.toLowerCase())) &&
                      typeCaisse.value == "${caisse['operation']}") {
                    //

                    //
                    return Container(
                      padding: const EdgeInsets.all(5),
                      //height: 200,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ///////////////////////////////////////////////////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${caisse['date_enregistrement'] ?? '12-12-2023'} -> ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${caisse['note']}  ",
                                        style: TextStyle(
                                          color: Colors.teal.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Débit",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Crédit",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          ),

                          ////////////////////////////////////////////////////////

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "${caisse['caisseentite']['compte_defaut']}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "${caisse[''] ?? ''}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${caisse['operation']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: Obx(() {
                                    RxString st = "${caisse["totalF"]}".obs;
                                    return Text(
                                      "${caisse['operation']}" == "Encaissement"
                                          ? "${totalF.value}"
                                          : totalVide.value,
                                      //
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  //
                                  child: Obx(
                                    () => Text(
                                      "${caisse['operation']}" == "Décaissement"
                                          ? "${totalF.value}" //
                                          : totalVide.value,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    //color: Colors.grey.shade300,
                                    // alignment: Alignment.center,
                                    // child: caisse['solder'] == 1
                                    //     ? InkWell(
                                    //         onTap: () {
                                    //           //
                                    //           TextEditingController libelle =
                                    //               TextEditingController();
                                    //           //
                                    //           TextEditingController montant =
                                    //               TextEditingController();
                                    //           //
                                    //           //
                                    //           Get.dialog(
                                    //             Material(
                                    //               color: Colors.transparent,
                                    //               child: Center(
                                    //                 child: Container(
                                    //                   padding:
                                    //                       const EdgeInsets.all(10),
                                    //                   height: 300,
                                    //                   width: 300,
                                    //                   decoration: BoxDecoration(
                                    //                     color: Colors.white,
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(10),
                                    //                   ),
                                    //                   child: Column(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment
                                    //                             .spaceBetween,
                                    //                     children: [
                                    //                       const Align(
                                    //                         alignment:
                                    //                             Alignment.topCenter,
                                    //                         child: Text("Paiement"),
                                    //                       ),
                                    //                       Align(
                                    //                         alignment:
                                    //                             Alignment.topCenter,
                                    //                         child: Text(
                                    //                           "${caisse['note']}",
                                    //                           style: TextStyle(
                                    //                             fontWeight:
                                    //                                 FontWeight.bold,
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       const SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       TextField(
                                    //                         controller: libelle,
                                    //                         decoration:
                                    //                             InputDecoration(
                                    //                           label: Text(
                                    //                               "Résumé paiement"),
                                    //                           border:
                                    //                               OutlineInputBorder(
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(10),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       const SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       TextField(
                                    //                         controller: montant,
                                    //                         decoration:
                                    //                             InputDecoration(
                                    //                           label: Text(
                                    //                               "Montant payé"),
                                    //                           border:
                                    //                               OutlineInputBorder(
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(10),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       const SizedBox(
                                    //                         height: 10,
                                    //                       ),
                                    //                       Row(
                                    //                         mainAxisAlignment:
                                    //                             MainAxisAlignment
                                    //                                 .spaceAround,
                                    //                         children: [
                                    //                           Expanded(
                                    //                             flex: 4,
                                    //                             child: ElevatedButton(
                                    //                               onPressed: () {
                                    //                                 //
                                    //                                 CaisseEntite aPrime = CaisseEntite(
                                    //                                     totalF: caisse[
                                    //                                         'totalF'],
                                    //                                     date_enregistrement:
                                    //                                         caisse[
                                    //                                             'date_enregistrement'],
                                    //                                     taux: caisse[
                                    //                                         'taux'],
                                    //                                     taux_montant:
                                    //                                         caisse[
                                    //                                             'taux_montant'],
                                    //                                     solder: caisse[
                                    //                                         'solder'],
                                    //                                     exercice: caisse[
                                    //                                         'exercice'],
                                    //                                     caisseentite:
                                    //                                         caisse[
                                    //                                             'caisseentite'],
                                    //                                     date_facture:
                                    //                                         caisse[
                                    //                                             'date_facture'],
                                    //                                     date_echeance:
                                    //                                         caisse[
                                    //                                             'date_echeance'],
                                    //                                     reference: caisse[
                                    //                                         'reference'],
                                    //                                     note: caisse[
                                    //                                         'note'],
                                    //                                     produits_services:
                                    //                                         caisse[
                                    //                                             'produits_services']);
                                    //                                 //
                                    //                                 aPrime
                                    //                                     .note = caisse[
                                    //                                         'note'] +
                                    //                                     " // ${libelle.text}";
                                    //                                 aPrime.totalF =
                                    //                                     double.parse(
                                    //                                         montant
                                    //                                             .text);
                                    //                                 //
                                    //                                 aPrime.solder = 1;
                                    //                                 journalsCaisses
                                    //                                     .add(aPrime
                                    //                                         .toMap());
                                    //                                 //
                                    //                                 box.write(
                                    //                                     "caisses$exercice",
                                    //                                     journalsCaisses);
                                    //                                 //
                                    //                                 Get.back();
                                    //                                 Get.snackbar(
                                    //                                     "Succès",
                                    //                                     "L'opération a bien été enregistré");
                                    //                               },
                                    //                               child: Text(
                                    //                                   "Enregistrer"),
                                    //                             ),
                                    //                           ),
                                    //                           const SizedBox(
                                    //                             width: 10,
                                    //                           ),
                                    //                           Expanded(
                                    //                             flex: 4,
                                    //                             child: ElevatedButton(
                                    //                               onPressed: () {
                                    //                                 //
                                    //                                 Get.back();
                                    //                               },
                                    //                               child: Text(
                                    //                                 "Annuler",
                                    //                                 style: TextStyle(
                                    //                                   color: Colors
                                    //                                       .red
                                    //                                       .shade700,
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           )
                                    //                         ],
                                    //                       )
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           );
                                    //         },
                                    //         child: Text(
                                    //           "Payer",
                                    //           style: TextStyle(
                                    //             color: Colors.teal.shade700,
                                    //             fontWeight: FontWeight.bold,
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : Container(),

                                    ),
                              ),
                            ],
                          ),
                          Column(
                            children: List.generate(
                                caisse['produits_services'].length, (index) {
                              Map ps = caisse['produits_services'][index];
                              //
                              print(
                                  "ps['montant_tva'] : 1 ${ps['montant_tva']}");
                              print("ps['montant_tva'] : 2 ${ps['total']}");
                              //
                              totalF.value = totalF.value +
                                  (ps['total'].runtimeType == String
                                      ? double.parse("0")
                                      : ps['total']);
                              //GRAND TOTAL DES DEUX SONT EGALAUX
                              totalCredit.value =
                                  totalCredit.value + totalF.value;
                              totalDebit.value =
                                  totalDebit.value + totalF.value;
                              ////////////////////////////////////
                              if (ps['montant_tva'] != 0.0) {
                                double tt = ps['total'].runtimeType == String
                                    ? double.parse("0")
                                    : ps['total'];
                                double montant_tva =
                                    ps['montant_tva'].runtimeType == String
                                        ? double.parse("0")
                                        : ps['montant_tva'];
                                //ps['montant_tva'];
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                              color: Colors.grey.shade300,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "${ps['code']}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${ps['article']}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${caisse['operation']}" ==
                                                      "Décaissement"
                                                  ? "${tt - montant_tva}"
                                                  : "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${caisse['operation']}" ==
                                                      "Encaissement"
                                                  ? "${tt - montant_tva}"
                                                  : "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                              color: Colors.grey.shade300,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "TVA",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${caisse['operation']}" ==
                                                      "Décaissement"
                                                  ? "${ps['montant_tva']}"
                                                  : "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${caisse['operation']}" ==
                                                      "Encaissement"
                                                  ? "${ps['montant_tva']}"
                                                  : "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                //
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          color: Colors.grey.shade300,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  "${ps['code']}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Container(
                                        color: Colors.grey.shade300,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${ps['article']}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.grey.shade300,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${caisse['operation']}" ==
                                                  "Décaissement"
                                              ? "${ps['total']}"
                                              : "",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.grey.shade300,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${caisse['operation']}" ==
                                                  "Encaissement"
                                              ? "${ps['total']}"
                                              : "",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Container(),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }),
                          )
                          ////////////////////////////////////////////////////////
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  testDate() async {
    //
    DateTime depart = DateTime(2023, 11, 14);
    DateTime enregistrer = DateTime(2023, 11, 15);
    DateTime fin = DateTime(2023, 11, 16);

    if (depart.isBefore(enregistrer) && fin.isAfter(enregistrer)) {
      print("la date est bien dans l'intervalle");
    } else {
      print("La date n'est pas dans l'intervalle");
    }

    var d = depart.isBefore(enregistrer);
    print("2023, 11, 14 isAfter 2023, 11, 15 = $d");

    //DateUtils dateUtils = DateUtils.monthDelta(startDate, endDate)
  }
}
