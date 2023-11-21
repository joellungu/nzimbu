import 'package:nzimbu/pages/clients_fournisseurs/fournisseur/nouveau_fournisseur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'fournisseur_controller.dart';

class Fournisseurs extends GetView<FournisseurController> {
  //
  var box = GetStorage();
  //
  Fournisseurs() {
    //
    controller.tousLesFournisseurs();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: controller.obx(
                (state) {
                  List fournisseurs = state!;
                  print(fournisseurs);
                  RxString text = "".obs;
                  RxBool pass = true.obs;
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          style: const TextStyle(fontSize: 10),
                          onChanged: (t) {
                            text.value = t;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () => pass.value
                              ? ListView(
                                  padding: EdgeInsets.all(10),
                                  children: List.generate(fournisseurs.length,
                                      (index) {
                                    Map fournisseur = fournisseurs[index];
                                    if ("${fournisseur['nom_contact']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase()) ||
                                        "${fournisseur['compte_defaut']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase()) ||
                                        "${fournisseur['raison_social']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase())) {
                                      return ListTile(
                                        //isThreeLine: true,
                                        //leading: Icon(Icons.person),
                                        title: Text(
                                            "${fournisseur['raison_social']} (${fournisseur['compte_defaut']})"),
                                        subtitle: Text(
                                            "${fournisseur['nom_contact']}"),
                                        trailing: IconButton(
                                          onPressed: () {
                                            //
                                            fournisseurs.removeAt(index);
                                            box.write(
                                                "fournisseurs", fournisseurs);
                                            controller.tousLesFournisseurs();
                                            //
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                )
                              : Container(),
                        ),
                      )
                    ],
                  );
                },
                onEmpty: Container(),
                onLoading: const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //
                Get.dialog(
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        height: 800,
                        width: 1000,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: NouveauFournisseur(),
                      ),
                    ),
                  ),
                  name: "Nouveau fournisseur",
                );
              },
              child: const Text("Ajouter un fournisseur"),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
  //
}
