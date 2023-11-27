import 'dart:ffi';

import 'package:data_table_2/data_table_2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'nouveau_saisie.dart';
import 'saisie_controller.dart';

class Saisie extends GetView<SaisieController> {
  //
  var box = GetStorage();
  //
  String searchValue = '';
  List comptes = [];
  String codeCompte = "";
  String libCompte = "";
  //
  final ScrollController _firstController = ScrollController();

  //
  TextEditingController libelle = TextEditingController();
  TextEditingController taux = TextEditingController();
  RxString dateEnregistrement = "".obs;
  RxString dateEcheance = "".obs;
  TextEditingController piece = TextEditingController();
  // TextEditingController mobile = TextEditingController();
  // TextEditingController telephone = TextEditingController();
  //
  TextEditingController libelle2 = TextEditingController();
  TextEditingController montantDebit = TextEditingController();
  TextEditingController montantCredit = TextEditingController();
  TextEditingController intitule = TextEditingController();
  TextEditingController reference = TextEditingController();
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
  Saisie() {
    //
    RawKeyboard.instance.addListener((e) {
      if (e is RawKeyDownEvent) {
        if (e.data.isModifierPressed(ModifierKey.controlModifier) &&
            e.logicalKey == LogicalKeyboardKey.keyS) {
          //
          //
          taux.clear();
          piece.clear();
          //
          libelle2.clear();
          montantDebit.clear();
          montantCredit.clear();
          intitule.clear();
          reference.clear();
          //
          controller.enregistrerSaisie();
          //
        }
      }
    });
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
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                                const Text("Devise"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonHideUnderline(
                                    child: Obx(
                                      () => DropdownButton(
                                        value: indexDevise.value,
                                        onChanged: (c) {
                                          //
                                          indexDevise.value = c as int;
                                          //compteDefaut = codes[c as int]['code'];
                                        },
                                        items: List.generate(Devises.length,
                                            (index) {
                                          return DropdownMenuItem(
                                            value: index,
                                            child: Text(
                                                "${Devises[index]} (${Devises[index]})"),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                const Text("Journal"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonHideUnderline(
                                    child: Obx(
                                      () => journals.isNotEmpty
                                          ? DropdownButton(
                                              value: indexJournal.value,
                                              onChanged: (c) {
                                                //
                                                indexJournal.value = c as int;
                                                //compteDefaut = codes[c as int]['code'];
                                              },
                                              items: List.generate(
                                                  journals.length, (index) {
                                                return DropdownMenuItem(
                                                  value: index,
                                                  child: Text(
                                                      "${journals[index]['intitule']} (${journals[index]['code']})"),
                                                );
                                              }),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                const Text("Libellé"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    onChanged: (t) {
                                      //
                                      libelle2.text = t;
                                    },
                                    controller: libelle,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                                const Text("Taux"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: taux,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                const Text("N° de piece"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: piece,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " N° ",
                          style: entete,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: Colors.red,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "N° de compte",
                            style: entete,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          //color: Colors.blue,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Libellé",
                            style: entete,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: Colors.amber,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Montant débit",
                            style: entete,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: Colors.green,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Montant Crédit",
                            style: entete,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          //color: Colors.orange,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Intitulé",
                            style: entete,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: Colors.cyan,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date d'écheance",
                            style: entete,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: Colors.cyan,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ref",
                            style: entete,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "",
                          style: entete,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  ",
                          style: entete,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SearchAnchor(
                          builder: (BuildContext context,
                              SearchController controller) {
                            return SearchBar(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  side: BorderSide.none,
                                ),
                              ),
                              controller: controller,
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              padding:
                                  const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              onTap: () {
                                controller.openView();
                              },
                              onChanged: (_) {
                                recherche.value = _;
                                print("recherche: ${recherche.value}");
                                controller.openView();
                              },
                              //leading: const Icon(Icons.search),
                              trailing: <Widget>[
                                // Tooltip(
                                //   message: 'Change brightness mode',
                                //   child: IconButton(
                                //     isSelected: isDark,
                                //     onPressed: () {
                                //       // setState(() {
                                //       //   isDark = !isDark;
                                //       // });
                                //     },
                                //     icon: const Icon(Icons.wb_sunny_outlined),
                                //     selectedIcon: const Icon(Icons.brightness_2_outlined),
                                //   ),
                                // )
                              ],
                            );
                          },
                          suggestionsBuilder: (BuildContext context,
                              SearchController controller) {
                            return List<Widget>.generate(
                              comptes.length,
                              (int index) {
                                //
                                recherche.value = controller.text;
                                return Obx(
                                  () {
                                    print("recherche: ${controller.text}");
                                    final String item =
                                        '${comptes[index]['intitule']} ${comptes[index]['numero_de_compte']}';
                                    if (comptes[index]['numero_de_compte']
                                            .contains(recherche.value) ||
                                        comptes[index]['intitule']
                                            .contains(recherche.value)) {
                                      return ListTile(
                                        title: Text(item),
                                        onTap: () {
                                          print("item: ${item}");
                                          //
                                          compte = comptes[index];
                                          codeCompte = comptes[index]
                                              ['numero_de_compte'];
                                          libCompte =
                                              comptes[index]['intitule'];
                                          intitule.text = libCompte;
                                          //
                                          controller.closeView(
                                              '${comptes[index]['numero_de_compte']}');
                                          // setState(() {
                                          //   controller.closeView(item);
                                          // });
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: libelle2,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2))),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: montantDebit,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2))),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: montantCredit,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2))),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          enabled: false,
                          controller: intitule,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2))),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                width: 1,
                              ),
                              Expanded(
                                flex: 1,
                                child: Obx(
                                  () => Text(dateEcheance.value),
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
                                      dateEcheance.value =
                                          "${d!.day}-${d.month}-${d.year}";
                                    }
                                  });
                                },
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          enabled: false,
                          controller: piece,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: InkWell(
                          onTap: () {
                            var exe = box.read("exercice") ?? "";
                            //
                            controller.listesSaisies.add({
                              "exercice": "$exe",
                              "devise": Devises[indexDevise.value],
                              "journale": journals[indexJournal.value],
                              "libelle": libelle.text,
                              "taux": taux.text,
                              "date_enregistrement": dateEnregistrement.value,
                              "n_piece": piece.text,
                              "compte": compte,
                              "libelle_enregistrement": libelle2.text,
                              "montant_debit": montantDebit.text == ""
                                  ? 0.0
                                  : double.parse(montantDebit.text),
                              "montant_credit": montantCredit.text == ""
                                  ? 0.0
                                  : double.parse(montantCredit.text),
                              "intitule": libCompte,
                              "date_echeance": dateEcheance.value,
                              "reference": reference.text,
                            });
                            controller.tousLesSaisie();
                            //
                            montantDebit.clear();
                            montantCredit.clear();
                          },
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                              return NouveauSaisie(ll[index], index);
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
          ElevatedButton(
            onPressed: () {
              //
              taux.clear();
              piece.clear();
              //
              libelle2.clear();
              montantDebit.clear();
              montantCredit.clear();
              intitule.clear();
              reference.clear();
              //
              controller.enregistrerSaisie();
              //
            },
            child: const Text("ENREGISTRER"),
          ),
          const SizedBox(
            height: 5,
          ),
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
  TextStyle entete = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );
}
