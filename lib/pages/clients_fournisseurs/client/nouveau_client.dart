import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'client_controller.dart';

class NouveauClient extends StatelessWidget {
  //
  var box = GetStorage();
  //
  ClientController controller = Get.find();
  //
  RxInt indexCompteDefaut = 0.obs;
  //
  TextEditingController raisonSocial = TextEditingController();
  TextEditingController nomContact = TextEditingController();
  TextEditingController reference = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController adresse1 = TextEditingController();
  TextEditingController adresse2 = TextEditingController();
  TextEditingController codePostal = TextEditingController();
  TextEditingController ville = TextEditingController();
  Rx<TextEditingController> pays =
      Rx<TextEditingController>(TextEditingController());
  TextEditingController compteAuxilier = TextEditingController();
  String compteDefaut = "";
  TextEditingController nTva = TextEditingController();
  //
  List codes = [];
  //
  NouveauClient() {
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
            "Nouveau client",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: raisonSocial,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Raison sociale",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: nomContact,
                        decoration: InputDecoration(
                            labelText: "Nom du contact",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: reference,
                        decoration: InputDecoration(
                            labelText: "Référence",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: email,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: mobile,
                        decoration: InputDecoration(
                            labelText: "Mobile",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: telephone,
                        decoration: InputDecoration(
                          labelText: "Téléphone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
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
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Détails compte",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: adresse1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Adresse 1",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: adresse2,
                        decoration: InputDecoration(
                            labelText: "Adresse 2",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: codePostal,
                        decoration: InputDecoration(
                            labelText: "Code postal",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: ville,
                        decoration: InputDecoration(
                            labelText: "Ville",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => TextField(
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  controller: pays.value,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      labelText: "Pays",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                //
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode:
                                      true, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    //
                                    pays.value.text = country.displayName;
                                    //
                                    print(
                                        'Select country: ${country.displayName}');
                                  },
                                );
                              },
                              icon: const Icon(Icons.card_membership),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        controller: compteAuxilier,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Compte auxiliere",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
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
                            const Text("Compte auxilier"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButtonHideUnderline(
                                child: Obx(
                                  () => DropdownButton(
                                    value: indexCompteDefaut.value,
                                    onChanged: (c) {
                                      //
                                      indexCompteDefaut.value = c as int;
                                      compteDefaut = codes[c as int]['code'];
                                    },
                                    items: List.generate(codes.length, (index) {
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Text(
                                            "${codes[index]['label']} (${codes[index]['code']})"),
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
                        controller: nTva,
                        decoration: InputDecoration(
                            labelText: "N° de TVA",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: () {
                  //
                  Map code = {
                    "raison_social": raisonSocial.text,
                    "nom_contact": nomContact.text,
                    "reference": reference.text,
                    "email": email.text,
                    "mobile": mobile.text,
                    "telephone": telephone.text,
                    "adresse1": adresse1.text,
                    "adresse2": adresse2.text,
                    "code_postal": codePostal.text,
                    "ville": ville.text,
                    "pays": pays.value.text,
                    "compte_auxilier": compteAuxilier.text,
                    "compte_defaut": compteDefaut,
                    "n_tva": nTva.text,
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
