import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'comptes_controller.dart';

class NouveauCompte extends StatelessWidget {
  //
  var box = GetStorage();
  //
  CompteController controller = Get.find();
  //
  RxInt indexCompteDefaut = 0.obs;
  RxInt indexTypeCompte = 0.obs;
  //
  RxList classes = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
  ].obs;
  RxInt indexClasse = 0.obs;
  //
  TextEditingController nom = TextEditingController();
  TextEditingController classe = TextEditingController();
  TextEditingController intitule = TextEditingController();
  TextEditingController soldeSignale = TextEditingController();
  TextEditingController information = TextEditingController();
  Rx<TextEditingController> pays =
      Rx<TextEditingController>(TextEditingController());
  TextEditingController compteAuxilier = TextEditingController();
  String compteDefaut = "";
  String typeJournal = "";
  TextEditingController nTva = TextEditingController();
  //
  List codes = [];
  //
  NouveauCompte() {
    codes = box.read("codes") ?? [];
    compteDefaut = codes.isNotEmpty ? codes[0]['code'] : "";
  }

  /*
  TextEditingController textCode = TextEditingController();
  TextEditingController labelCode = TextEditingController();
  */
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Nouveau compte",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          controller: nom,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Numero de compte",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
              const Text("Classe"),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: DropdownButtonHideUnderline(
                  child: Obx(
                    () => DropdownButton(
                      value: indexClasse.value,
                      onChanged: (c) {
                        //
                        indexClasse.value = c as int;
                        //compteDefaut = codes[c as int]['code'];
                      },
                      items: List.generate(classes.length, (index) {
                        return DropdownMenuItem(
                          value: index,
                          child: Text("${classes[index]}"),
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
        TextField(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          controller: intitule,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Intitule",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          controller: soldeSignale,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Solde signalé",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          controller: information,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Information",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () {
                  //
                  Map code = {
                    "classe": classes[indexClasse.value],
                    "numero_de_compte": nom.text,
                    "intitule": intitule.text,
                    "solde_signale": soldeSignale.text,
                    "information": information.text,
                  };
                  //
                  controller.enregistrerClient(code);
                  //
                  Get.back();
                  //
                },
                child: const Text("Enregistrer"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () {
                  //
                  Get.back();
                  //
                },
                child: Text(
                  "Annuler",
                  style: TextStyle(color: Colors.red.shade700),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
