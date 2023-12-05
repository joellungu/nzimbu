import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'changement_controller.dart';

class Changer extends StatelessWidget {
  //
  ChangementController changementController = Get.find();
  Map e;
  Changer(this.e, int index) {
    print("e: $e");

    libelle2.text = e['libelle_enregistrement'];
    montantDebit.text = "${e['montant_debit']}";
    montantCredit.text = "${e['montant_credit']}";
    piece.text = "${e['n_piece']}";
    intitule.text = e['intitule'];
    dateEcheance.value = "${e['date_echeance']}";
    dateEnregistrement.value = "${e['date_enregistrement']}";
    recherche.value = "${e['numero_de_compte']}";

    //libelle.text = e[''];
    //
    journals.value = box.read("journaux") ?? [];
    //
    for (int t = 0; t < journals.length; t++) {
      //
      if (journals[t]['intitule'] == e['journale']['intitule']) {
        indexJournal.value = t;
      }
    }
    //
    comptes = box.read("comptes") ?? [];
  }
  //
  SearchController? _controller;

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
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      height: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Container(
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
                              items: List.generate(Devises.length, (index) {
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
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 3,
                child: Container(
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
                                    items:
                                        List.generate(journals.length, (index) {
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
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: Container(
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
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 45,
                width: 130,
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
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
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
                  builder: (BuildContext context, SearchController controller) {
                    Timer(const Duration(seconds: 1), () {
                      //
                      controller.text = '${e['compte']['numero_de_compte']}';
                    });
                    //
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
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
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
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
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
                                  codeCompte =
                                      comptes[index]['numero_de_compte'];
                                  libCompte = comptes[index]['intitule'];
                                  intitule.text = libCompte;
                                  //
                                  controller.text =
                                      comptes[index]['numero_de_compte'];
                                  e['compte'] = comptes[index];
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
                  //enabled: false,
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
                  //enabled: false,
                  controller: piece,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: InkWell(
                  onTap: () async {
                    Get.dialog(
                      Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                    //
                    //e['devise'] = "";
                    e['journale'] = journals[indexJournal.value];
                    e['libelle_enregistrement'] = libelle2.text;
                    e['date_enregistrement'] = dateEnregistrement.value;
                    e['n_piece'] = piece.text;
                    e['compte'] = compte;
                    e['montant_debit'] = montantDebit.text == ""
                        ? 0.0
                        : double.parse(montantDebit.text);
                    e['montant_credit'] = montantCredit.text == ""
                        ? 0.0
                        : double.parse(montantCredit.text);
                    e['intitule'] = libCompte;
                    e['date_echeance'] = dateEcheance.value;
                    e['reference'] = reference.text;
                    changementController.miseAjour(e);
                    //
                  },
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle entete = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );
}
