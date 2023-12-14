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
  RxList classes = [].obs;
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
        width: Get.size.width / 1.2,
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListView(
                          padding: const EdgeInsets.only(top: 50),
                          children: List.generate(
                            7,
                            (index) {
                              //
                              RxBool choix = false.obs;
                              //
                              return Obx(
                                () => ListTile(
                                  onTap: () {
                                    //
                                    choix.value = !choix.value;
                                    if (choix.value) {
                                      classes.add(index + 1);
                                    } else {
                                      classes.remove(index + 1);
                                    }

                                    print("resultats : $classes");
                                    //
                                  },
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  title: const Text("Classe"),
                                  trailing: choix.value
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.teal,
                                        )
                                      : const SizedBox(
                                          height: 1,
                                          width: 1,
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
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
                            Card(
                              elevation: 0,
                              child: Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.centerLeft,
                                        color: Colors.grey.shade300,
                                        //color: Colors.amber,
                                        child: const Text("Numéro de compte"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.centerLeft,
                                        color: Colors.grey.shade300,
                                        //color: Colors.yellow,
                                        child: const Text("Classe"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.centerLeft,
                                        color: Colors.grey.shade300,
                                        child: const Text("Intitulé"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.centerLeft,
                                        color: Colors.grey.shade300,
                                        child: const Text("Solde assigné"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        alignment: Alignment.centerLeft,
                                        color: Colors.grey.shade300,
                                        //color: Colors.red,
                                        child: const Text("Infos."),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        //
                                        //
                                      },
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
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
                                            //
                                            print(
                                                "resultats : $classes :: ${classes.contains(int.parse(compte['numero_de_compte'][0]))}");
                                            if (classes.contains(int.parse(
                                                compte['numero_de_compte']
                                                    [0]))) {
                                              //
                                              if ("${compte['intitule']}"
                                                      .toLowerCase()
                                                      .contains(text.value
                                                          .toLowerCase()) ||
                                                  "${compte['numero_de_compte']}"
                                                      .toLowerCase()
                                                      .contains(text.value
                                                          .toLowerCase())) {
                                                return Card(
                                                  elevation: 0,
                                                  child: Container(
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            //color: Colors.amber,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                                "${compte['numero_de_compte']}"),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            //color: Colors.yellow,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                                "${compte['classe'] ?? ''}"),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                                "${compte['intitule']}"),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Obx(
                                                              () => Text(
                                                                  "${getSoldeInitial(compte['numero_de_compte'] ?? '')}"),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                            ),
                                                            //color: Colors.red,
                                                            child: Text(
                                                                "${compte['information']}"),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            //
                                                            controller.supprimer(
                                                                index,
                                                                "${compte['intitule']}",
                                                                comptes);
                                                            // comptes.removeAt(
                                                            //     index);
                                                            // box.write("comptes",
                                                            //     comptes);
                                                            // controller
                                                            //     .tousLesClients();
                                                            //
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors
                                                                .red.shade700,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );

                                                return ListTile(
                                                  //isThreeLine: true,
                                                  //leading: Icon(Icons.person),
                                                  title: Text(
                                                      "${compte['intitule']}"),
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
                                                      box.write(
                                                          "comptes", comptes);
                                                      controller
                                                          .tousLesClients();
                                                      //
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color:
                                                          Colors.red.shade700,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
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
  RxDouble getSoldeInitial(String numeroDeCompte) {
    //
    var exercice = box.read("exercice") ?? "";
    List balances = [];
    List saisies = box.read("saisies$exercice") ?? [];
    //
    double tDebit = 0.0;
    double tCrebit = 0.0;
    //
    String usd_cdf = box.read("usd_cdf") ?? "0.0";
    String usd_eur = box.read("usd_eur") ?? "0.0";
    String eur_cdf = box.read("eur_cdf") ?? "0.0";
    //
    for (var r in saisies) {
      if (r["compte"]["numero_de_compte"] == numeroDeCompte) {
        //
        double md = r['montant_debit'];

        //___________________
        double mc = r['montant_credit'];

        //___________________
        //"USD", "CDF", "EUR"
        if (r['devise'] == "USD") {
          //USD
          if (r["devise"] == "USD") {
            //

            //
            tDebit = tDebit + md;
            tCrebit = tCrebit + mc;
          }
          if (r["devise"] == "CDF") {
            //
            //
            tDebit = tDebit + (md * double.parse(usd_cdf));
            tCrebit = tCrebit + (mc * double.parse(usd_cdf));
          }
          if (r["devise"] == "EUR") {
            //
            //
            tDebit = tDebit + (md * double.parse(usd_eur));
            tCrebit = tCrebit + (mc * double.parse(usd_eur));
          }
        }
        if (r['devise'] == "CDF") {
          if (r["devise"] == "USD") {
            //
            //
            tDebit = tDebit + (md / double.parse(usd_cdf));
            tCrebit = tCrebit + (mc / double.parse(usd_cdf));
          }
          if (r["devise"] == "CDF") {
            //
            //
            tDebit = tDebit + md;
            tCrebit = tCrebit + mc;
          }
          if (r["devise"] == "EUR") {
            //
            //
            tDebit = tDebit + (md / double.parse(eur_cdf));
            tCrebit = tCrebit + (mc / double.parse(eur_cdf));
          }
        }
        if (r['devise'] == "EUR") {
          if (r["devise"] == "USD") {
            //
            //
            tDebit = tDebit + (md * double.parse(usd_eur));
            tCrebit = tCrebit + (mc * double.parse(usd_eur));
          }
          if (r["devise"] == "CDF") {
            //
            //
            tDebit = tDebit + (md * double.parse(eur_cdf));
            tCrebit = tCrebit + (mc * double.parse(eur_cdf));
          }
          if (r["devise"] == "EUR") {
            //
            //
            tDebit = tDebit + md;
            tCrebit = tCrebit + mc;
          }
        }
      }
    }
    //
    return (tDebit - tCrebit).obs;
  }
}
