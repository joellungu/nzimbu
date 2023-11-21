import 'package:nzimbu/pages/comptes/nouveau_compte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/pages/etats/balance/balance_controller.dart';

import 'balance.dart';

class BalanceFiltre extends GetView<BalanceController> {
  //
  var box = GetStorage();
  RxString dateDebut = "".obs;
  RxString dateFin = "".obs;
  //
  BalanceFiltre() {
    //
    comptes.value = box.read("comptes") ?? [];
    DateTime d = DateTime.now();
    //controller.tousLesClients();
    dateDebut.value = "${d.day}-${d.month}-${d.year}";
    dateFin.value = "${d.day}-${d.month}-${d.year}";
    //
  }

  //
  RxString text = "".obs;
  //

  RxList comptes = [].obs;
  RxList compteSelect = [].obs;
  Set cmps = Set();
  RxInt indexCompte = 0.obs;
  //
  RxList Selections = ["Particulier", "Tout"].obs;
  RxInt indexSelect = 0.obs;
  //
  //
  RxList Devises = ["USD", "CDF", "EUR"].obs;
  RxInt indexDevise = 0.obs;
  TextEditingController taux = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: SizedBox(
        width: 900,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
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
                        const Text("Selection "),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonHideUnderline(
                            child: Obx(
                              () => DropdownButton(
                                value: indexSelect.value,
                                onChanged: (c) {
                                  //
                                  indexSelect.value = c as int;
                                  if (Selections[indexSelect.value] == "Tout") {
                                    compteSelect.clear();
                                    cmps.clear();
                                  }
                                  //compteDefaut = codes[c as int]['code'];
                                },
                                items:
                                    List.generate(Selections.length, (index) {
                                  return DropdownMenuItem(
                                    value: index,
                                    child: Text("${Selections[index]}"),
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
                        const Text("Comptes"),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonHideUnderline(
                            child: Obx(
                              () => comptes.isNotEmpty
                                  ? DropdownButton(
                                      value: indexCompte.value,
                                      onChanged: (c) {
                                        //
                                        indexCompte.value = c as int;
                                        //compteDefaut = codes[c as int]['code'];
                                        if (Selections[indexSelect.value] !=
                                            "Tout") {
                                          if (cmps.add(
                                              "${comptes[c]['intitule']}")) {
                                            compteSelect.add(comptes[c]);
                                          }
                                        }
                                      },
                                      items: List.generate(comptes.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: index,
                                          child: Text(
                                              "${comptes[index]['intitule']} (${comptes[index]['numero_de_compte']})"),
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
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => ListView(
                        padding: const EdgeInsets.all(10),
                        children: List.generate(compteSelect.length, (index) {
                          Map journal = compteSelect[index];
                          if ("${journal['intitule']}"
                                  .toLowerCase()
                                  .contains(text.value.toLowerCase()) ||
                              "${journal['numero_de_compte']}"
                                  .toLowerCase()
                                  .contains(text.value.toLowerCase())) {
                            return ListTile(
                              //isThreeLine: true,
                              //leading: Icon(Icons.person),
                              title: Text("${journal['intitule']}"),
                              subtitle: Text(
                                "${journal['numero_de_compte']}",
                                style: const TextStyle(
                                  color: Colors.teal,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  //
                                  cmps.remove("${journal['intitule']}");
                                  compteSelect.removeAt(index);
                                  //box.write("comptes", comptes);
                                  //controller.tousLesClients();
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          const Text("  date debut"),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(
                                dateDebut.value,
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
                                lastDate: DateTime(2050),
                              ).then((d) {
                                //
                                dateDebut.value =
                                    "${d!.day}-${d.month}-${d.year}";
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
                          const Text("  date fin"),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => Text(dateFin.value),
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
                                //
                                dateFin.value =
                                    "${d!.day}-${d.month}-${d.year}";
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
                    ElevatedButton(
                      onPressed: () {
                        //
                        Get.dialog(
                          const Material(
                            color: Colors.transparent,
                            child: Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        );
                        //saisies

                        var exercice = box.read("exercice") ?? "";
                        List balances = [];
                        List saisies = box.read("saisies$exercice") ?? [];
                        //saisies
                        if (compteSelect.isEmpty) {
                          List choix = box.read("comptes") ?? [];
                          choix.forEach((s) {
                            //
                            double tDebit = 0.0;
                            double tCrebit = 0.0;
                            //
                            String usd_cdf = box.read("usd_cdf") ?? "0.0";
                            String usd_eur = box.read("usd_eur") ?? "0.0";
                            String eur_cdf = box.read("eur_cdf") ?? "0.0";
                            //
                            saisies.forEach((r) {
                              //
                              //print(
                              //  "numero_de_compte: ${s["numero_de_compte"]}");
                              //
                              List dateSaisieText =
                                  r['date_enregistrement'].split("-");
                              List dateDebutText = dateDebut.value.split("-");
                              List dateFinText = dateFin.value.split("-");

                              //
                              DateTime dateTimeSaisie = DateTime(
                                  int.parse(dateSaisieText[0]),
                                  int.parse(dateSaisieText[1]),
                                  int.parse(dateSaisieText[2]));
                              //
                              DateTime dateTimeDepart = DateTime(
                                  int.parse(dateDebutText[0]),
                                  int.parse(dateDebutText[1]),
                                  int.parse(dateDebutText[2]));
                              //
                              DateTime dateTimeFin = DateTime(
                                  int.parse(dateFinText[0]),
                                  int.parse(dateFinText[1]),
                                  int.parse(dateFinText[2]));
                              //
                              if ((dateDebut.value ==
                                          r['date_enregistrement'] ||
                                      dateTimeSaisie.isAfter(dateTimeDepart)) &&
                                  (dateFin.value == r['date_enregistrement'] ||
                                      dateTimeSaisie.isBefore(dateTimeFin))) {
                                //
                                print(
                                    "égalité ${r['devise']} -- ${r['montant_debit']} -- ${r['montant_credit']} \n $s");
                                //
                                if (r['compte']["numero_de_compte"] ==
                                    s["numero_de_compte"]) {
                                  double md = r['montant_debit'].isNotEmpty
                                      ? double.parse(r['montant_debit'])
                                      : 0;
                                  //___________________
                                  double mc = r['montant_credit'].isNotEmpty
                                      ? double.parse(r['montant_credit'])
                                      : 0;
                                  //___________________
                                  //"USD", "CDF", "EUR"
                                  if (r['devise'] == "USD") {
                                    //USD
                                    if (Devises[indexDevise.value] == "USD") {
                                      //
                                      tDebit = tDebit + md;
                                      tCrebit = tCrebit + mc;
                                    }
                                    if (Devises[indexDevise.value] == "CDF") {
                                      tDebit =
                                          tDebit + (md * double.parse(usd_cdf));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(usd_cdf));
                                    }
                                    if (Devises[indexDevise.value] == "EUR") {
                                      tDebit =
                                          tDebit + (md * double.parse(usd_eur));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(usd_eur));
                                    }
                                  }
                                  if (r['devise'] == "CDF") {
                                    if (Devises[indexDevise.value] == "USD") {
                                      tDebit =
                                          tDebit + (md / double.parse(usd_cdf));
                                      tCrebit = tCrebit +
                                          (mc / double.parse(usd_cdf));
                                    }
                                    if (Devises[indexDevise.value] == "CDF") {
                                      //
                                      tDebit = tDebit + md;
                                      tCrebit = tCrebit + mc;
                                    }
                                    if (Devises[indexDevise.value] == "EUR") {
                                      tDebit =
                                          tDebit + (md / double.parse(eur_cdf));
                                      tCrebit = tCrebit +
                                          (mc / double.parse(eur_cdf));
                                    }
                                  }
                                  if (r['devise'] == "EUR") {
                                    if (Devises[indexDevise.value] == "USD") {
                                      tDebit =
                                          tDebit + (md * double.parse(usd_eur));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(usd_eur));
                                    }
                                    if (Devises[indexDevise.value] == "CDF") {
                                      tDebit =
                                          tDebit + (md * double.parse(eur_cdf));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(eur_cdf));
                                    }
                                    if (Devises[indexDevise.value] == "EUR") {
                                      //
                                      tDebit = tDebit + md;
                                      tCrebit = tCrebit + mc;
                                    }
                                  }
                                }
                              }
                            });
                            //
                            double anouveau = calcculeAnouveau(saisies, s);
                            //
                            double solde_periode = tDebit - tCrebit;
                            //
                            balances.add({
                              "numero_de_compte": s['numero_de_compte'],
                              "intitule": s['intitule'],
                              "cumul_credit": tCrebit,
                              "cumul_debit": tDebit,
                              "solde_periode": solde_periode,
                            });
                          });

                          //
                        } else {
                          //

                          //print(
                          //  "compteSelect: $compteSelect \n saisies: $saisies");
                          compteSelect.forEach((s) {
                            //
                            double tDebit = 0.0;
                            double tCrebit = 0.0;
                            //
                            String usd_cdf = box.read("usd_cdf") ?? "0.0";
                            String usd_eur = box.read("usd_eur") ?? "0.0";
                            String eur_cdf = box.read("eur_cdf") ?? "0.0";
                            //
                            saisies.forEach((r) {
                              //
                              //print(
                              //  "numero_de_compte: ${s["numero_de_compte"]}");
                              //
                              List dateSaisieText =
                                  r['date_enregistrement'].split("-");
                              List dateDebutText = dateDebut.value.split("-");
                              List dateFinText = dateFin.value.split("-");

                              //
                              DateTime dateTimeSaisie = DateTime(
                                  int.parse(dateSaisieText[0]),
                                  int.parse(dateSaisieText[1]),
                                  int.parse(dateSaisieText[2]));
                              //
                              DateTime dateTimeDepart = DateTime(
                                  int.parse(dateDebutText[0]),
                                  int.parse(dateDebutText[1]),
                                  int.parse(dateDebutText[2]));
                              //
                              DateTime dateTimeFin = DateTime(
                                  int.parse(dateFinText[0]),
                                  int.parse(dateFinText[1]),
                                  int.parse(dateFinText[2]));
                              //
                              print(
                                  "Condition: ${(dateDebut.value == r['date_enregistrement'] || dateTimeSaisie.isAfter(dateTimeDepart))} && ${(dateFin.value == r['date_enregistrement'] || dateTimeSaisie.isBefore(dateTimeFin))}");
                              //
                              if ((dateDebut.value ==
                                          r['date_enregistrement'] ||
                                      dateTimeSaisie.isAfter(dateTimeDepart)) &&
                                  (dateFin.value == r['date_enregistrement'] ||
                                      dateTimeSaisie.isBefore(dateTimeFin))) {
                                //
                                print(
                                    "égalité ${r['devise']} -- ${r['montant_debit']} -- ${r['montant_credit']} \n $s");
                                //
                                if (r['compte']["numero_de_compte"] ==
                                    s["numero_de_compte"]) {
                                  double md = r['montant_debit'].isNotEmpty
                                      ? double.parse(r['montant_debit'])
                                      : 0;
                                  //___________________
                                  double mc = r['montant_credit'].isNotEmpty
                                      ? double.parse(r['montant_credit'])
                                      : 0;
                                  //___________________
                                  //"USD", "CDF", "EUR"
                                  if (r['devise'] == "USD") {
                                    //USD
                                    if (Devises[indexDevise.value] == "USD") {
                                      //
                                      tDebit = tDebit + md;
                                      tCrebit = tCrebit + mc;
                                    }
                                    if (Devises[indexDevise.value] == "CDF") {
                                      tDebit =
                                          tDebit + (md * double.parse(usd_cdf));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(usd_cdf));
                                    }
                                    if (Devises[indexDevise.value] == "EUR") {
                                      tDebit =
                                          tDebit + (md * double.parse(usd_eur));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(usd_eur));
                                    }
                                  }
                                  if (r['devise'] == "CDF") {
                                    if (Devises[indexDevise.value] == "USD") {
                                      tDebit =
                                          tDebit + (md / double.parse(usd_cdf));
                                      tCrebit = tCrebit +
                                          (mc / double.parse(usd_cdf));
                                    }
                                    if (Devises[indexDevise.value] == "CDF") {
                                      //
                                      tDebit = tDebit + md;
                                      tCrebit = tCrebit + mc;
                                    }
                                    if (Devises[indexDevise.value] == "EUR") {
                                      tDebit =
                                          tDebit + (md / double.parse(eur_cdf));
                                      tCrebit = tCrebit +
                                          (mc / double.parse(eur_cdf));
                                    }
                                  }
                                  if (r['devise'] == "EUR") {
                                    if (Devises[indexDevise.value] == "USD") {
                                      tDebit =
                                          tDebit + (md * double.parse(usd_eur));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(usd_eur));
                                    }
                                    if (Devises[indexDevise.value] == "CDF") {
                                      tDebit =
                                          tDebit + (md * double.parse(eur_cdf));
                                      tCrebit = tCrebit +
                                          (mc * double.parse(eur_cdf));
                                    }
                                    if (Devises[indexDevise.value] == "EUR") {
                                      //
                                      tDebit = tDebit + md;
                                      tCrebit = tCrebit + mc;
                                    }
                                  }
                                }
                              }
                            });
                            //
                            double anouveau = calcculeAnouveau(saisies, s);
                            //
                            double solde_periode = tDebit - tCrebit;
                            //
                            balances.add({
                              "numero_de_compte": s['numero_de_compte'],
                              "intitule": s['intitule'],
                              "cumul_credit": tCrebit,
                              "cumul_debit": tDebit,
                              "solde_periode": solde_periode,
                            });
                          });
                        }
                        //
                        Get.back();
                        Get.to(
                          Balance(
                            0,
                            balances,
                            dateDebut.value,
                            dateFin.value,
                            Devises[indexDevise.value],
                          ),
                        ); //
                        print("balances: $balances");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        child: const Text("AFFICHER"),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //
  double calcculeAnouveau(List saisies, Map choix) {
    //
    double total = 0;
    //

    return total;
  }
}
