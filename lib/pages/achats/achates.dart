import 'package:nzimbu/pages/achats/achats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Achats extends StatelessWidget {
  //
  Map fournisseur = {};
  RxInt indexFournisseur = 0.obs;
  //
  RxString tauxLabel = "".obs;
  RxInt indexTaux = 0.obs;
  TextEditingController taux = TextEditingController();
  //
  AchatsController controller = Get.find();
  //
  var box = GetStorage();
  //
  TextEditingController article = TextEditingController();
  TextEditingController quantite = TextEditingController();
  TextEditingController prixUnitaire = TextEditingController();
  TextEditingController tauxTva = TextEditingController();
  //calculé
  Rx<TextEditingController> montantTva = Rx(TextEditingController());
  Rx<TextEditingController> total = Rx(TextEditingController());
  //
  TextEditingController referenceFac = TextEditingController();
  TextEditingController noteFac = TextEditingController();
  //
  RxList fournisseurs = [].obs;
  String codeGrandLivre = "";
  RxInt indexCodeGrandLivre = 0.obs;
  //
  RxString dateFacture = "".obs;
  RxString dateEcheance = "".obs;
  //
  String operation = "";
  RxList operations = ["Facture", "décaissement"].obs;
  RxInt indexOperation = 0.obs;

  //
  List codes = [];
  //
  RxList produitsServices = [].obs;
  //
  Achats() {
    //
    taux.text = "0";
    //
    fournisseurs.value = box.read("fournisseurs") ?? [];
    codes = box.read("codes") ?? [];
    codeGrandLivre = codes.isNotEmpty ? codes[0]['code'] : "";
    print("fournisseurs: $fournisseurs");
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Nouvelle facture d'achat",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   height: 45,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     border: Border.all(
                        //       color: Colors.grey,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       const Text("   Type d'opération"),
                        //       const SizedBox(
                        //         width: 10,
                        //       ),
                        //       Expanded(
                        //         flex: 1,
                        //         child: DropdownButtonHideUnderline(
                        //           child: Obx(
                        //             () => DropdownButton(
                        //               value: indexOperation.value,
                        //               onChanged: (c) {
                        //                 //
                        //                 indexOperation.value = c as int;
                        //                 operation = operations[c as int];
                        //               },
                        //               items: List.generate(operations.length,
                        //                   (index) {
                        //                 return DropdownMenuItem(
                        //                   value: index,
                        //                   child: Text(
                        //                     "${operations[index]}",
                        //                   ),
                        //                 );
                        //               }),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),

                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("   Fournisseur"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton(
                                      value: indexFournisseur.value,
                                      onChanged: (c) {
                                        //
                                        indexFournisseur.value = c as int;
                                        print(
                                            "indexFournisseur: $indexFournisseur");
                                        fournisseur = fournisseurs[c as int];
                                      },
                                      items: List.generate(fournisseurs.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: index,
                                          child: Text(
                                            "${fournisseurs[index]['nom_contact']} (${fournisseurs[index]['raison_social']})",
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("Date de facture: "),
                                      Obx(
                                        () => Text(
                                          dateFacture.value,
                                          style: TextStyle(
                                            color: Colors.teal.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          //
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2030))
                                              .then((d) {
                                            //
                                            dateFacture.value =
                                                "${d!.day}-${d.month}-${d.year}";
                                          });
                                        },
                                        icon: Icon(Icons.calendar_month),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("Date d'échéance"),
                                      Obx(
                                        () => Text(
                                          dateEcheance.value,
                                          style: TextStyle(
                                            color: Colors.teal.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          //
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2030))
                                              .then((d) {
                                            //
                                            dateEcheance.value =
                                                "${d!.day}-${d.month}-${d.year}";
                                          });
                                        },
                                        icon: Icon(Icons.calendar_month),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: referenceFac,
                                  decoration: InputDecoration(
                                    label:
                                        const Text("Référence de la facture"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  controller: noteFac,
                                  decoration: const InputDecoration(
                                    label: Text("Libellé"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Produits & Services",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: article,
                                  decoration: InputDecoration(
                                    label: const Text("Article"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("   Code"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(
                                          () => DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: indexCodeGrandLivre.value,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              onChanged: (c) {
                                                //
                                                indexCodeGrandLivre.value =
                                                    c as int;
                                                codeGrandLivre =
                                                    codes[c as int]['code'];
                                              },
                                              items: List.generate(codes.length,
                                                  (index) {
                                                return DropdownMenuItem(
                                                  value: index,
                                                  child: Text(
                                                    "${codes[index]['code']} (${codes[index]['label']})",
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: quantite,
                                  decoration: InputDecoration(
                                    label: const Text("Quantité"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: prixUnitaire,
                                  decoration: InputDecoration(
                                    label: const Text("Prix Unitaire"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: tauxTva,
                                  decoration: const InputDecoration(
                                    label: Text("Taux TVA (%)"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(flex: 4, child: Container()),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("   Devise"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(
                                          () => DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: indexTaux.value,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              onChanged: (c) {
                                                //
                                                indexTaux.value = c as int;
                                                //
                                                tauxLabel.value = [
                                                  "USD",
                                                  "CDF",
                                                  "EUR"
                                                ][c as int];
                                              },
                                              items: List.generate(3, (index) {
                                                return DropdownMenuItem(
                                                  value: index,
                                                  child: Text(
                                                    "${[
                                                      "USD",
                                                      "CDF",
                                                      "EUR"
                                                    ][index]} (${[
                                                      "USD",
                                                      "CDF",
                                                      "EUR"
                                                    ][index]})",
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  controller: taux,
                                  decoration: const InputDecoration(
                                    label: Text("Montant Taux"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Obx(
                                  () => TextField(
                                    controller: montantTva.value,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      label: Text("Montant du TVA"),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 4,
                                child: Obx(
                                  () => TextField(
                                    controller: total.value,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      label: Text("Total"),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 4,
                                child: ElevatedButton(
                                  onPressed: () {
                                    //(%) = 100 x Valeur partielle/Valeur totale
                                    //(%)*Valeur totale = 100 x Valeur partielle
                                    String tx =
                                        taux.text.isEmpty ? "0" : taux.text;
                                    //
                                    if ([
                                          "USD",
                                          "CDF",
                                          "EUR"
                                        ][indexTaux.value] ==
                                        "USD") {
                                      try {
                                        double mt = pourcent(
                                            double.parse(tauxTva.text),
                                            int.parse(quantite.text) *
                                                double.parse(
                                                    prixUnitaire.text));

                                        Map ps = {
                                          "article": article.text,
                                          "code": codeGrandLivre,
                                          "taux_tva": tauxTva.text,
                                          "quantite": quantite.text,
                                          "prix_unitaire": prixUnitaire.text,
                                          "devise": [
                                            "USD",
                                            "CDF",
                                            "EUR"
                                          ][indexTaux.value],
                                          "taux": double.parse(tx),

                                          //
                                          "montant_tva": mt,
                                          "total": mt +
                                              (int.parse(quantite.text) *
                                                  double.parse(
                                                      prixUnitaire.text)),
                                        };
                                        //
                                        produitsServices.add(ps);
                                      } catch (e) {
                                        Get.snackbar(
                                          "Erreur",
                                          "Un problème est survenu, veuilliez inserer des chiffres et non des lettres",
                                          backgroundColor: Colors.red.shade700,
                                          colorText: Colors.white,
                                        );
                                      }
                                    } else {
                                      //Conversion...

                                      //
                                      try {
                                        double pu =
                                            double.parse(prixUnitaire.text) /
                                                double.parse(tx);
                                        print("le pourcentage vaut: pu = $pu");
                                        //
                                        double mt = pourcent(
                                            double.parse(tauxTva.text),
                                            int.parse(quantite.text) * pu);

                                        Map ps = {
                                          "article": article.text,
                                          "code": codeGrandLivre,
                                          "taux_tva": tauxTva.text,
                                          "quantite": quantite.text,
                                          "prix_unitaire": prixUnitaire.text,
                                          "devise": [
                                            "USD",
                                            "CDF",
                                            "EUR"
                                          ][indexTaux.value],
                                          "taux": double.parse(tx),

                                          //
                                          "montant_tva": mt,
                                          "total": mt +
                                              (int.parse(quantite.text) * pu),
                                        };
                                        //
                                        produitsServices.add(ps);
                                      } catch (e) {
                                        Get.snackbar(
                                          "Erreur",
                                          "Un problème est survenu, veuilliez inserer des chiffres et non des lettres",
                                          backgroundColor: Colors.red.shade700,
                                          colorText: Colors.white,
                                        );
                                      }
                                    }
                                  },
                                  child: Text("Ajouter"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Liste de produits & services",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => ListView(
                              padding: const EdgeInsets.all(10),
                              children: List.generate(
                                produitsServices.length,
                                (index) {
                                  Map ps = produitsServices[index];
                                  //
                                  return Container(
                                    height: 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 30,
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 10),
                                            color: Colors.black,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Produit & Service N° ${index + 1}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    //
                                                    produitsServices
                                                        .removeAt(index);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child:
                                                              Text("Article"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['article']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "Compte Liv. Compte"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['code']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child:
                                                              Text("Quantité"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['quantite']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "Prix Unitaire"),
                                                          color: Colors
                                                              .grey.shade100,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "${ps['prix_unitaire']}"),
                                                          color: Colors
                                                              .grey.shade100,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text("TVA"),
                                                          color: Colors
                                                              .grey.shade100,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "${ps['taux_tva']}"),
                                                          color: Colors
                                                              .grey.shade100,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "Montant TVA"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['montant_tva']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text("Total"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['total']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 2,
                                                  color: Colors.teal,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text("DEVISE"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['devise']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text("TAUX"),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Text(
                                                              "${ps['taux']}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              //
              DateTime d = DateTime.now();
              //

              //
              Map fac = {
                "date_enregistrement": "${d.day}-${d.month}-${d.year}",
                "taux": taux.text,
                "taux_montant": tauxLabel.value,
                "solder": 0,
                "exercice": box.read("exercice") ?? "",
                "fournisseur": fournisseur,
                "date_facture": dateFacture.value,
                "date_echeance": dateEcheance.value,
                "reference": referenceFac.text,
                "note": noteFac.text,
                "produits_services": produitsServices,
              };
              //
              controller.enregistrerAchats(fac);
              //
              Get.snackbar("Succes", "La facture a bien été enregistré");
              //
            },
            child: const Text("Enregistrer"),
          )
        ],
      ),
    );
  }

  //
  double pourcent(double pr, double vt) {
    //
    //(%) = 100 x Valeur partielle/Valeur totale
    //double prct = (5 * montant) / 100;
    double prct = (100 * 5) / 100;
    //prct * Valeur totale = (100 * Valeur partielle)
    //(prct * Valeur totale) / 100 = Valeur partielle
    double vp = (pr * vt) / 100;
    print("le pourcentage vaut: 1 = $prct");
    print("le pourcentage vaut: 2 = $vp");
    return vp;
  }
}
