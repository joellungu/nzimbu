import 'package:nzimbu/pages/comptes/nouveau_compte.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'comptes_controller.dart';

class Comptes extends GetView<CompteController> {
  //
  var box = GetStorage();
  //
  Comptes() {
    //
    controller.tousLesClients();
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
                  List comptes = state!;
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
                                  children: List.generate(
                                    comptes.length,
                                    (index) {
                                      Map compte = comptes[index];
                                      if ("${compte['intitule']}"
                                              .toLowerCase()
                                              .contains(
                                                  text.value.toLowerCase()) ||
                                          "${compte['numero_de_compte']}"
                                              .toLowerCase()
                                              .contains(
                                                  text.value.toLowerCase())) {
                                        return ListTile(
                                          //isThreeLine: true,
                                          //leading: Icon(Icons.person),
                                          title: Text("${compte['intitule']}"),
                                          subtitle: Text(
                                            "${compte['numero_de_compte']}",
                                            style: TextStyle(
                                              color: Colors.teal,
                                            ),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              //
                                              comptes.removeAt(index);
                                              box.write("comptes", comptes);
                                              controller.tousLesClients();
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
                                    },
                                  ),
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
                        height: 500,
                        width: 600,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: NouveauCompte(),
                      ),
                    ),
                  ),
                  name: "Créer compte",
                );
              },
              child: const Text("Créer compte"),
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
