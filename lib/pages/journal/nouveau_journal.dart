import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/pages/journal/journal_controller.dart';

class NouveauJournal extends StatelessWidget {
  //
  var box = GetStorage();
  //
  JournalController controller = Get.find();
  //
  RxInt indexCompteDefaut = 0.obs;
  RxInt indexTypeCompte = 0.obs;
  //
  TextEditingController code = TextEditingController();
  TextEditingController sg = TextEditingController();
  TextEditingController intitule = TextEditingController();
  TextEditingController soldeSignale = TextEditingController();
  Rx<TextEditingController> pays =
      Rx<TextEditingController>(TextEditingController());
  TextEditingController compteAuxilier = TextEditingController();
  String compteDefaut = "";
  String typeJournal = "";
  TextEditingController nTva = TextEditingController();
  //
  RxList types = [
    "Achats",
    "Ventes",
    "Trésorerie",
    "OD",
    "A-nouveaux",
  ].obs;
  RxInt indexType = 0.obs;
  //
  NouveauJournal() {
    //codes = box.read("codes") ?? [];
    //compteDefaut = codes.isNotEmpty ? codes[0]['code'] : "";
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
            "Nouveau journal",
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
          controller: code,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Code",
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
          controller: sg,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Sigle",
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
              const Text("   Type de journal"),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: DropdownButtonHideUnderline(
                  child: Obx(
                    () => DropdownButton(
                      value: indexType.value,
                      onChanged: (c) {
                        //
                        indexType.value = c as int;
                        //print("indexFournisseur: $indexFournisseur");
                        // = fournisseurs[c as int];
                      },
                      items: List.generate(types.length, (index) {
                        return DropdownMenuItem(
                          value: index,
                          child: Text(
                            "${types[index]} (${types[index]})",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () {
                  //
                  Map journal = {
                    "sg": sg.text,
                    "code": code.text,
                    "intitule": intitule.text,
                    "type": types[indexType.value],
                  };
                  //
                  controller.enregistrerClient(journal);
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
