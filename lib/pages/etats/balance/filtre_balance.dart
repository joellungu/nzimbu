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
  RxList Selections = ["Tout"].obs;
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
                        // Expanded(
                        //   flex: 1,
                        //   child: DropdownButtonHideUnderline(
                        //     child: Obx(
                        //       () => comptes.isNotEmpty
                        //           ? DropdownButton(
                        //               value: indexCompte.value,
                        //               onChanged: (c) {
                        //                 //
                        //                 indexCompte.value = c as int;
                        //                 //compteDefaut = codes[c as int]['code'];
                        //                 if (Selections[indexSelect.value] !=
                        //                     "Tout") {
                        //                   if (cmps.add(
                        //                       "${comptes[c]['intitule']}")) {
                        //                     compteSelect.add(comptes[c]);
                        //                   }
                        //                 }
                        //               },
                        //               items: List.generate(comptes.length,
                        //                   (index) {
                        //                 return DropdownMenuItem(
                        //                   value: index,
                        //                   child: Text(
                        //                       "${comptes[index]['intitule']} (${comptes[index]['numero_de_compte']})"),
                        //                 );
                        //               }),
                        //             )
                        //           : Container(),
                        //     ),
                        //   ),
                        // ),
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
                                if (d != null) {
                                  //
                                  dateDebut.value =
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
                                if (d != null) {
                                  //
                                  dateFin.value =
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
                        //double anouveau = 0;
                        //saisies
                        List choix = box.read("comptes") ?? [];
                        choix.forEach((s) {
                          //

                          //
                          double tDebit = 0.0;
                          double tCrebit = 0.0;
                          //
                          //String usd_cdf = box.read("usd_cdf") ?? "0.0";
                          //String usd_eur = box.read("usd_eur") ?? "0.0";
                          //String eur_cdf = box.read("eur_cdf") ?? "0.0";
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
                            if ((dateDebut.value == r['date_enregistrement'] ||
                                    dateTimeSaisie.isAfter(dateTimeDepart)) ||
                                (dateFin.value == r['date_enregistrement'] ||
                                    dateTimeSaisie.isBefore(dateTimeFin))) {
                              //
                              String usd_cdf = r["usd_cdf"] ?? "0.0";
                              String usd_eur = r["usd_eur"] ?? "0.0";
                              String eur_cdf = r["eur_cdf"] ?? "0.0";
                              //
                              print(
                                  "égalité ${r['devise']} -- ${r['montant_debit']} -- ${r['montant_credit']} \n $s");
                              //
                              if (r['compte']["numero_de_compte"] ==
                                  s["numero_de_compte"]) {
                                double md = r['montant_debit'];
                                //

                                //___________________
                                double mc = r['montant_credit'];

                                //___________________
                                //"USD", "CDF", "EUR"
                                if (r['devise'] == "USD") {
                                  //USD
                                  if (Devises[indexDevise.value] == "USD") {
                                    //
                                    r['montant_debit_'] = md;
                                    r['montant_credit_'] = mc;
                                    //
                                    tDebit = tDebit + md;
                                    tCrebit = tCrebit + mc;
                                  }
                                  if (Devises[indexDevise.value] == "CDF") {
                                    //
                                    r['montant_debit_'] =
                                        (md * double.parse(usd_cdf));
                                    r['montant_credit_'] =
                                        (mc * double.parse(usd_cdf));
                                    //
                                    tDebit =
                                        tDebit + (md * double.parse(usd_cdf));
                                    tCrebit =
                                        tCrebit + (mc * double.parse(usd_cdf));
                                  }
                                  if (Devises[indexDevise.value] == "EUR") {
                                    //
                                    r['montant_debit_'] =
                                        (md * double.parse(usd_eur));
                                    r['montant_credit_'] =
                                        (mc * double.parse(usd_eur));
                                    //
                                    tDebit =
                                        tDebit + (md * double.parse(usd_eur));
                                    tCrebit =
                                        tCrebit + (mc * double.parse(usd_eur));
                                  }
                                }
                                if (r['devise'] == "CDF") {
                                  if (Devises[indexDevise.value] == "USD") {
                                    //
                                    r['montant_debit_'] =
                                        (md / double.parse(usd_cdf));
                                    r['montant_credit_'] =
                                        (mc / double.parse(usd_cdf));
                                    //
                                    tDebit =
                                        tDebit + (md / double.parse(usd_cdf));
                                    tCrebit =
                                        tCrebit + (mc / double.parse(usd_cdf));
                                  }
                                  if (Devises[indexDevise.value] == "CDF") {
                                    //
                                    r['montant_debit_'] = md;
                                    r['montant_credit_'] = mc;
                                    //
                                    //
                                    tDebit = tDebit + md;
                                    tCrebit = tCrebit + mc;
                                  }
                                  if (Devises[indexDevise.value] == "EUR") {
                                    //
                                    r['montant_debit_'] =
                                        (md / double.parse(eur_cdf));
                                    r['montant_credit_'] =
                                        (mc / double.parse(eur_cdf));
                                    //
                                    tDebit =
                                        tDebit + (md / double.parse(eur_cdf));
                                    tCrebit =
                                        tCrebit + (mc / double.parse(eur_cdf));
                                  }
                                }
                                if (r['devise'] == "EUR") {
                                  if (Devises[indexDevise.value] == "USD") {
                                    //
                                    r['montant_debit_'] =
                                        (md * double.parse(usd_eur));
                                    r['montant_credit_'] =
                                        (mc * double.parse(usd_eur));
                                    //
                                    tDebit =
                                        tDebit + (md * double.parse(usd_eur));
                                    tCrebit =
                                        tCrebit + (mc * double.parse(usd_eur));
                                  }
                                  if (Devises[indexDevise.value] == "CDF") {
                                    //
                                    r['montant_debit_'] =
                                        (md * double.parse(eur_cdf));
                                    r['montant_credit_'] =
                                        (mc * double.parse(eur_cdf));
                                    //
                                    tDebit =
                                        tDebit + (md * double.parse(eur_cdf));
                                    tCrebit =
                                        tCrebit + (mc * double.parse(eur_cdf));
                                  }
                                  if (Devises[indexDevise.value] == "EUR") {
                                    //
                                    r['montant_debit_'] = md;
                                    r['montant_credit_'] = mc;
                                    //
                                    //
                                    tDebit = tDebit + md;
                                    tCrebit = tCrebit + mc;
                                  }
                                }
                              }
                            }
                          });
                          //

                          //
                          double solde_periode = tDebit - tCrebit;
                          //
                          //
                          balances.add({
                            "numero_de_compte": s['numero_de_compte'],
                            "intitule": s['intitule'],
                            "cumul_credit": tCrebit,
                            "cumul_debit": tDebit,
                            "solde_periode": solde_periode,
                            "niveau": 1,
                            "sous-classe": s["numero_de_compte"][0] +
                                s["numero_de_compte"][1],
                            "classe": s["numero_de_compte"][0],
                          });
                          // balances.add({
                          //   "numero_de_compte": s['numero_de_compte'],
                          //   "intitule": s['intitule'],
                          //   "cumul_credit": tCrebit,
                          //   "cumul_debit": tDebit,
                          //   "solde_periode": solde_periode,
                          //   "niveau": 2
                          // });
                          // balances.add({
                          //   "numero_de_compte": s['numero_de_compte'],
                          //   "intitule": s['intitule'],
                          //   "cumul_credit": tCrebit,
                          //   "cumul_debit": tDebit,
                          //   "solde_periode": solde_periode,
                          //   "niveau": 3
                          // });
                        });

                        //
                        for (int i = 0; i < balances.length; i++) {
                          //Map ss = resultats[i];

                          for (int j = 0; j < balances.length; j++) {
                            //

                            Map ii = balances[i];
                            Map jj = balances[j];
                            if (ii['numero_de_compte'] != null &&
                                jj['numero_de_compte'] != null) {
                              //String d = "788";
                              //var dx = d[0];
                              //print("resultats : dx $dx :: $d");
                              int li = int.parse(ii['numero_de_compte'][0] +
                                  ii['numero_de_compte'][1] +
                                  ii['numero_de_compte'][2] +
                                  ii['numero_de_compte'][3]);
                              //d0.isBefore(d1)

                              int lj = int.parse(jj['numero_de_compte'][0] +
                                  jj['numero_de_compte'][1] +
                                  jj['numero_de_compte'][2] +
                                  jj['numero_de_compte'][3]);
                              //d1.isBefore(d2)
                              if (li < lj) {
                                //resultats[i] < resultats[j]
                                Map tmp = balances[i];
                                balances[i] = balances[j];
                                print(
                                    "la valeur de listeDate[$i] = ${comptes[i]}");
                                balances[j] = tmp;
                                print(
                                    "et la valeur de listeDate[$j] = ${comptes[j]}");
                              }
                            }
                          }
                        }
                        //
                        for (var element in balances) {
                          //
                          double anouveau = 0;
                          //
                          for (var x in saisies) {
                            //
                            if (x['compte']["numero_de_compte"] ==
                                element["numero_de_compte"]) {
                              //
                              anouveau = anouveau + calcculeAnouveau(x);
                            }
                          }
                          element["anouveau"] = anouveau;
                        }
                        //
                        Map st10 = getTotalSousClasse(balances, [
                          "10",
                          "11",
                          "12",
                          "13",
                          "14",
                          "15",
                          "16",
                          "17",
                          "18",
                          "19"
                        ]);
                        //
                        balances.add({
                          "niveau": 2,
                          "debit": st10["debit"], //
                          "credit": st10["credit"],
                          "interval": st10["interval"],
                        });
                        Map t1 = getTotalCalsse(balances, "1");
                        balances.add({
                          "niveau": 3,
                          "debit": t1["debit"],
                          "credit": t1["credit"],
                        });
                        //______________________________________________________
                        Map st20 = getTotalSousClasse(balances, [
                          "20",
                          "21",
                          "22",
                          "23",
                          "24",
                          "25",
                          "26",
                          "27",
                          "28",
                          "29"
                        ]);
                        balances.add({
                          "niveau": 2,
                          "debit": st20["debit"],
                          "credit": st20["credit"],
                          "interval": st10["interval"],
                        });
                        Map t2 = getTotalCalsse(balances, "2");
                        balances.add({
                          "niveau": 3,
                          "debit": t2["debit"],
                          "credit": t2["credit"],
                        });
                        //______________________________________________________
                        Map st30 = getTotalSousClasse(balances, [
                          "30",
                          "31",
                          "32",
                          "33",
                          "34",
                          "35",
                          "36",
                          "37",
                          "38",
                          "39"
                        ]);
                        balances.add({
                          "niveau": 2,
                          "debit": st30["debit"],
                          "credit": st30["credit"],
                          "interval": st10["interval"],
                        });
                        Map t3 = getTotalCalsse(balances, "3");
                        balances.add({
                          "niveau": 3,
                          "debit": t3["debit"],
                          "credit": t3["credit"],
                        });
                        //______________________________________________________
                        Map st40 = getTotalSousClasse(balances, [
                          "40",
                          "41",
                          "42",
                          "43",
                          "44",
                          "45",
                          "46",
                          "47",
                          "48",
                          "49"
                        ]);
                        balances.add({
                          "niveau": 2,
                          "debit": st40["debit"],
                          "credit": st40["credit"],
                          "interval": st10["interval"],
                        });
                        Map t4 = getTotalCalsse(balances, "4");
                        balances.add({
                          "niveau": 3,
                          "debit": t4["debit"],
                          "credit": t4["credit"],
                        });
                        //______________________________________________________
                        Map st50 = getTotalSousClasse(balances, [
                          "50",
                          "51",
                          "52",
                          "53",
                          "54",
                          "55",
                          "56",
                          "57",
                          "58",
                          "59"
                        ]);
                        balances.add({
                          "niveau": 2,
                          "debit": st50["debit"],
                          "credit": st50["credit"],
                          "interval": st10["interval"],
                        });
                        Map t5 = getTotalCalsse(balances, "5");
                        balances.add({
                          "niveau": 3,
                          "debit": t5["debit"],
                          "credit": t5["credit"],
                        });
                        //______________________________________________________
                        Map st60 = getTotalSousClasse(balances, [
                          "60",
                          "61",
                          "62",
                          "63",
                          "64",
                          "65",
                          "66",
                          "67",
                          "68",
                          "69"
                        ]);
                        balances.add({
                          "niveau": 2,
                          "debit": st60["debit"],
                          "credit": st60["credit"],
                          "interval": st10["interval"],
                        });
                        Map t6 = getTotalCalsse(balances, "6");
                        balances.add({
                          "niveau": 3,
                          "debit": t6["debit"],
                          "credit": t6["credit"],
                        });
                        //______________________________________________________
                        Map st70 = getTotalSousClasse(balances, [
                          "70",
                          "71",
                          "72",
                          "73",
                          "74",
                          "75",
                          "76",
                          "77",
                          "78",
                          "79"
                        ]);
                        balances.add({
                          "niveau": 2,
                          "debit": st70["debit"],
                          "credit": st70["credit"],
                          "interval": st10["interval"],
                        });
                        Map t7 = getTotalCalsse(balances, "7");
                        balances.add({
                          "niveau": 3,
                          "debit": t7["debit"],
                          "credit": t7["credit"],
                        });
                        //______________________________________________________

                        /*
                        for (var element in balances) {
                          //
                          double total_classe = 0;
                          double total_sous_classe = 0;
                          //
                          for (var x in saisies) {
                            //
                            String ss = x['compte']["numero_de_compte"][0] +
                                x['compte']["numero_de_compte"][1];
                            if (element['sous-classe'] == ss) {
                              //
                              total_sous_classe =
                                  total_sous_classe + calcculeAnouveau(x);
                            }
                            if (element['classe'] ==
                                x['compte']["numero_de_compte"][0]) {
                              //
                              total_classe = total_classe + calcculeAnouveau(x);
                            }
                          }
                          element["total_sous_classe"] = total_sous_classe;

                          element["total_classe"] = total_classe;
                        }
                        */
                        //
                        //List balanceFinal = getBalanceFinal(balances);
                        //
                        Get.back();
                        Get.to(
                          Balance(
                            0,
                            balances,
                            dateDebut.value,
                            dateFin.value,
                            Devises[indexDevise.value],
                            true,
                            "",
                          ),
                        ); //
                        //print("balances: $balances");
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
  double calcculeAnouveau(Map r) {
    //
    String usd_cdf = r["usd_cdf"] ?? "0.0";
    String usd_eur = r["usd_eur"] ?? "0.0";
    String eur_cdf = r["eur_cdf"] ?? "0.0";
    //
    double total = 0;
    double md = r['montant_debit'] ?? 0;
    //___________________
    double mc = r['montant_credit'] ?? 0;
    //
    double tDebit = 0;
    double tCrebit = 0;
    //

    if (r['journale'] != null) {
      //['type']
      print("A-nouveaux: ${r['journale']['type']}");
      if (r['journale']['type'] == "A-nouveaux") {
        //
        if (r['devise'] == "USD") {
          //USD
          if (Devises[indexDevise.value] == "USD") {
            //
            r['montant_debit_'] = md;
            r['montant_credit_'] = mc;
            //
            tDebit = tDebit + md;
            tCrebit = tCrebit + mc;
          }
          if (Devises[indexDevise.value] == "CDF") {
            //
            r['montant_debit_'] = (md * double.parse(usd_cdf));
            r['montant_credit_'] = (mc * double.parse(usd_cdf));
            //
            tDebit = tDebit + (md * double.parse(usd_cdf));
            tCrebit = tCrebit + (mc * double.parse(usd_cdf));
          }
          if (Devises[indexDevise.value] == "EUR") {
            //
            r['montant_debit_'] = (md * double.parse(usd_eur));
            r['montant_credit_'] = (mc * double.parse(usd_eur));
            //
            tDebit = tDebit + (md * double.parse(usd_eur));
            tCrebit = tCrebit + (mc * double.parse(usd_eur));
          }
        }
        if (r['devise'] == "CDF") {
          if (Devises[indexDevise.value] == "USD") {
            //
            r['montant_debit_'] = (md / double.parse(usd_cdf));
            r['montant_credit_'] = (mc / double.parse(usd_cdf));
            //
            tDebit = tDebit + (md / double.parse(usd_cdf));
            tCrebit = tCrebit + (mc / double.parse(usd_cdf));
          }
          if (Devises[indexDevise.value] == "CDF") {
            //
            r['montant_debit_'] = md;
            r['montant_credit_'] = mc;
            //
            //
            tDebit = tDebit + md;
            tCrebit = tCrebit + mc;
          }
          if (Devises[indexDevise.value] == "EUR") {
            //
            r['montant_debit_'] = (md / double.parse(eur_cdf));
            r['montant_credit_'] = (mc / double.parse(eur_cdf));
            //
            tDebit = tDebit + (md / double.parse(eur_cdf));
            tCrebit = tCrebit + (mc / double.parse(eur_cdf));
          }
        }
        if (r['devise'] == "EUR") {
          if (Devises[indexDevise.value] == "USD") {
            //
            r['montant_debit_'] = (md * double.parse(usd_eur));
            r['montant_credit_'] = (mc * double.parse(usd_eur));
            //
            tDebit = tDebit + (md * double.parse(usd_eur));
            tCrebit = tCrebit + (mc * double.parse(usd_eur));
          }
          if (Devises[indexDevise.value] == "CDF") {
            //
            r['montant_debit_'] = (md * double.parse(eur_cdf));
            r['montant_credit_'] = (mc * double.parse(eur_cdf));
            //
            tDebit = tDebit + (md * double.parse(eur_cdf));
            tCrebit = tCrebit + (mc * double.parse(eur_cdf));
          }
          if (Devises[indexDevise.value] == "EUR") {
            //
            r['montant_debit_'] = md;
            r['montant_credit_'] = mc;
            //
            //
            tDebit = tDebit + md;
            tCrebit = tCrebit + mc;
          }
        }
        print("A-nouveaux: $tDebit :: $tCrebit");
      }
    }

    return tDebit + tCrebit;
  }

  Map getTotalSousClasse(List balance, List intervalle) {
    //Je fais la somme
    Map resultat = {};
    //
    String inter = "";
    //
    double debit = 0;
    double credit = 0;
    //
    for (var element in balance) {
      //
      if (intervalle.contains(element['sous-classe'])) {
        inter = element['sous-classe'];
        debit = debit + double.parse("${element['cumul_debit']}");
        credit = credit + double.parse("${element['cumul_credit']}");
      }
    }

    resultat['debit'] = debit;
    resultat['credit'] = credit;
    resultat['interval'] = inter;

    return resultat;
  }

  Map getTotalCalsse(List balance, String classe) {
    Map resultat = {};
    //
    double debit = 0;
    double credit = 0;
    //
    for (var element in balance) {
      //
      if (classe == element['classe']) {
        debit = debit + double.parse("${element['cumul_debit']}");
        credit = credit + double.parse("${element['cumul_credit']}");
      }
    }

    resultat['debit'] = debit;
    resultat['credit'] = credit;

    return resultat;
    //
  }
}
