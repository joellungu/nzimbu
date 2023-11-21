import 'package:nzimbu/pages/comptes/nouveau_compte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../comptes/comptes_controller.dart';
import 'bilan_caisse.dart';

class Bilan extends GetView<CompteController> {
  //
  var box = GetStorage();
  //
  Bilan() {
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
                                  padding: const EdgeInsets.all(10),
                                  children:
                                      List.generate(comptes.length, (index) {
                                    Map compte = comptes[index];
                                    if ("${compte['nom']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase()) ||
                                        "${compte['compteDefaut']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase())) {
                                      return ListTile(
                                        //isThreeLine: true,
                                        //CarbonPiggyBankSlot
                                        leading: SvgPicture.asset(
                                          "assets/CarbonPiggyBankSlot.svg",
                                          colorFilter: const ColorFilter.mode(
                                              Colors.grey, BlendMode.srcIn),
                                          semanticsLabel: "",
                                          height: 30,
                                          width: 30,
                                        ),
                                        onTap: () {
                                          //
                                          Get.to(BilanCaisse(compte));
                                          //
                                        },
                                        title: Text("${compte['nom']}"),
                                        subtitle: Text(
                                          "${compte['compteDefaut']}",
                                          style: const TextStyle(
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
                        height: 400,
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
                  name: "Nouveau compte",
                );
              },
              child: const Text("Ajouter un compte"),
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
