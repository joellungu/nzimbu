import 'package:nzimbu/pages/comptes/nouveau_compte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/pages/etats/balance/balance_controller.dart';
import 'package:nzimbu/pages/etats/grand_livre/grand_livre.dart';

class FiltreGrandLivre extends GetView<BalanceController> {
  //
  var box = GetStorage();
  RxString dateDebut = "".obs;
  RxString dateFin = "".obs;
  //
  FiltreGrandLivre() {
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

                        try {
                          var exercice = box.read("exercice") ?? "";
                          List balances = [];
                          List saisies = box.read("saisies$exercice") ?? [];
                          Set listePieces = Set();
                          saisies.forEach((ss) {
                            print(
                                "t'es quoi toi ? cool test: ${ss['compte']['intitule']}");
                            listePieces.add("${ss['compte']['intitule']}");
                            //listePieces.add(
                            //  "${ss['date_enregistrement']}|${ss['compte']['numero_de_compte']}|${ss['compte']['intitule']}");
                          });
                          //saisies
                          ////////////////////////////////////////////////////////
                          if (compteSelect.isEmpty &&
                              Selections[indexSelect.value] == "Tout") {
                            List choix = box.read("comptes") ?? [];

                            //
                            listePieces.forEach((piece) {
                              String infosCellule = piece;

                              //
                              List jrs = [];

                              Map jr = {};
                              //
                              double tDebit = 0.0;
                              double tCrebit = 0.0;

                              //n_piece: infosCellule[1]   journal: s['code']
                              //
                              choix.forEach((s) {
                                //
                                print("t'es quoi toi ? $s");
                                //jr['intitule'] = s['intitule'];
                                //jr['code'] = s['code'];
                                //jr['type'] = s['type'];
                                //print(
                                //  "balances: èè ${infosCellule[1]} ${infosCellule[1] == s["numero_de_compte"]} == ${s["numero_de_compte"]}");
                                if (infosCellule == s['intitule']) {
                                  //
                                  //String usd_cdf = box.read("usd_cdf") ?? "0.0";
                                  //String usd_eur = box.read("usd_eur") ?? "0.0";
                                  //String eur_cdf = box.read("eur_cdf") ?? "0.0";
                                  //
                                  //List infosCellule = "$piece".split("|");
                                  //jr['intitule'] = infosCellule[2];
                                  //jr['numero_de_compte'] = infosCellule[1];
                                  //jr['date_enregistrement'] = infosCellule[0];
                                  //Date d'écriture${ss['date_enregistrement']} Piece N° ${ss['n_piece']}

                                  //
                                  saisies.forEach((r) {
                                    //print(
                                    //  "La valeur: ${s["numero_de_compte"]} == ${infosCellule[1] == r['n_piece']} == ${r['n_piece']}");
                                    //Seulement si

                                    //infosCellule[1] == r['n_piece']
                                    //

                                    //print(
                                    //  "numero_de_compte: ${s["numero_de_compte"]}");
                                    //
                                    List dateSaisieText =
                                        r['date_enregistrement'].split("-");
                                    List dateDebutText =
                                        dateDebut.value.split("-");
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
                                            dateTimeSaisie
                                                .isAfter(dateTimeDepart)) ||
                                        (dateFin.value ==
                                                r['date_enregistrement'] ||
                                            dateTimeSaisie
                                                .isBefore(dateTimeFin))) {
                                      //
                                      String usd_cdf = r["usd_cdf"] ?? "0.0";
                                      String usd_eur = r["usd_eur"] ?? "0.0";
                                      String eur_cdf = r["eur_cdf"] ?? "0.0";
                                      //
//
                                      double debitTotal = 0;
                                      double creditTotal = 0;
                                      //infosCellule

                                      jr['intitule'] = infosCellule;
                                      // jr['numero_de_compte'] =
                                      //     r['compte']["numero_de_compte"];
                                      // jr['date_enregistrement'] =
                                      //     r['date_enregistrement'];
                                      //
                                      ////n_piece: infosCellule[1]   journal: s['code']
                                      ///r['compte']["numero_de_compte"] ==
                                      //             s["numero_de_compte"]
                                      if (r['compte']["numero_de_compte"] ==
                                          s["numero_de_compte"]) {
                                        //
                                        jr['numero_de_compte'] =
                                            r['compte']["numero_de_compte"];
                                        jr['date_enregistrement'] =
                                            r['date_enregistrement'];
                                        //
                                        //  "balances: èè ${r['compte']['date_enregistrement']} -- ${r['compte']["numero_de_compte"] == s["numero_de_compte"] || r['date_enregistrement'] == infosCellule[0]} \n ${s["numero_de_compte"]}");

                                        //
                                        jrs.add(r);
                                        double md = r['montant_debit'];
                                        //___________________
                                        double mc = r['montant_credit'];

                                        //___________________
                                        //"USD", "CDF", "EUR"
                                        if (r['devise'] == "USD") {
                                          //USD
                                          if (Devises[indexDevise.value] ==
                                              "USD") {
                                            //
                                            r['montant_credit_'] = mc;
                                            r['montant_debit_'] = md;

                                            //
                                            tDebit = tDebit + md;
                                            tCrebit = tCrebit + mc;
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "CDF") {
                                            //
                                            r['montant_debit_'] =
                                                //
                                                debitTotal = debitTotal +
                                                    (md *
                                                        double.parse(usd_cdf));
                                            //
                                            r['montant_credit_'] =
                                                //
                                                creditTotal = creditTotal +
                                                    (mc *
                                                        double.parse(usd_cdf));

                                            creditTotal = creditTotal +
                                                (mc * double.parse(usd_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(usd_cdf));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(usd_cdf));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "EUR") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md * double.parse(usd_eur));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            creditTotal = creditTotal +
                                                (md * double.parse(usd_eur));
                                            creditTotal = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(usd_eur));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(usd_eur));
                                          }
                                        }
                                        if (r['devise'] == "CDF") {
                                          if (Devises[indexDevise.value] ==
                                              "USD") {
                                            //
                                            r['montant_debit_'] = creditTotal +
                                                (md / double.parse(usd_cdf));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc / double.parse(usd_cdf));
                                            //
                                            creditTotal = creditTotal +
                                                (md / double.parse(usd_cdf));
                                            debitTotal = debitTotal +
                                                (mc / double.parse(usd_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md / double.parse(usd_cdf));
                                            tCrebit = tCrebit +
                                                (mc / double.parse(usd_cdf));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "CDF") {
                                            //
                                            r['montant_credit_'] = mc;
                                            r['montant_debit_'] = md;
                                            //
                                            debitTotal = debitTotal + md;
                                            creditTotal = creditTotal + mc;
                                            //
                                            tDebit = tDebit + md;
                                            tCrebit = tCrebit + mc;
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "EUR") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md / double.parse(eur_cdf));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc / double.parse(eur_cdf));
                                            //
                                            debitTotal = debitTotal +
                                                (md / double.parse(eur_cdf));
                                            creditTotal = creditTotal +
                                                (mc / double.parse(eur_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md / double.parse(eur_cdf));
                                            tCrebit = tCrebit +
                                                (mc / double.parse(eur_cdf));
                                          }
                                        }
                                        if (r['devise'] == "EUR") {
                                          if (Devises[indexDevise.value] ==
                                              "USD") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md * double.parse(usd_eur));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            debitTotal = debitTotal +
                                                (md * double.parse(usd_eur));
                                            creditTotal = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(usd_eur));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(usd_eur));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "CDF") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md * double.parse(eur_cdf));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc * double.parse(eur_cdf));
                                            //
                                            debitTotal = debitTotal +
                                                (md * double.parse(eur_cdf));
                                            creditTotal = creditTotal +
                                                (mc * double.parse(eur_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(eur_cdf));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(eur_cdf));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "EUR") {
                                            //
                                            r['montant_credit_'] = mc;
                                            r['montant_debit_'] = md;
                                            //
                                            debitTotal = debitTotal + md;
                                            creditTotal = creditTotal + mc;
                                            //
                                            tDebit = tDebit + md;
                                            tCrebit = tCrebit + mc;
                                          }
                                        }
                                        //
                                      }
                                    }
                                  });
                                  //
                                  jr['ssis'] = jrs;
                                  //
                                  //double anouveau = calcculeAnouveau(saisies, s);
                                  //
                                  jr["debitTotal"] = tDebit;
                                  jr["creditTotal"] = tCrebit;

                                  //
                                  double solde_periode = tDebit - tCrebit;
                                  //
                                  print("resultat: $jr");
                                  balances.add(jr);
                                  //
                                  //
                                  tDebit = 0;
                                  tCrebit = 0;
                                  //
                                }
                              });
                            });

                            //
                          } else {
                            //

                            //print(
                            //  "::: 1 compteSelect: $compteSelect // saisies: $saisies");

                            //__________________________________________________
                            listePieces.forEach((piece) {
                              String infosCellule = piece; //.split("|");
                              //
                              List jrs = [];

                              Map jr = {};
                              //
                              double tDebit = 0.0;
                              double tCrebit = 0.0;
                              //
                              //n_piece: infosCellule[1]   journal: s['code']
                              //
                              compteSelect.forEach((s) {
                                //
                                print(
                                    "::: $infosCellule -- ${infosCellule == s['intitule']} -- ${s['intitule']}");
                                //jr['intitule'] = s['intitule'];
                                //jr['code'] = s['code'];
                                //jr['type'] = s['type'];
                                //print(
                                //  "balances: èè ${infosCellule[1]} ${infosCellule[1] == s["numero_de_compte"]} == ${s["numero_de_compte"]}");
                                if (infosCellule == s['intitule']) {
                                  //
                                  print("::: 3 $infosCellule");
                                  //String usd_cdf = box.read("usd_cdf") ?? "0.0";
                                  //String usd_eur = box.read("usd_eur") ?? "0.0";
                                  //String eur_cdf = box.read("eur_cdf") ?? "0.0";
                                  //
                                  //List infosCellule = "$piece".split("|");
                                  //jr['intitule'] = infosCellule[2];
                                  //jr['numero_de_compte'] = infosCellule[1];
                                  //jr['date_enregistrement'] = infosCellule[0];
                                  //Date d'écriture${ss['date_enregistrement']} Piece N° ${ss['n_piece']}

                                  //
                                  saisies.forEach((r) {
                                    //print(
                                    //  "La valeur: ${s["numero_de_compte"]} == ${infosCellule[1] == r['n_piece']} == ${r['n_piece']}");
                                    //Seulement si

                                    //infosCellule[1] == r['n_piece']
                                    //
                                    print("::: cool je boucle");

                                    //print(
                                    //  "numero_de_compte: ${s["numero_de_compte"]}");
                                    //
                                    List dateSaisieText =
                                        r['date_enregistrement'].split("-");
                                    List dateDebutText =
                                        dateDebut.value.split("-");
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
                                            dateTimeSaisie
                                                .isAfter(dateTimeDepart)) ||
                                        (dateFin.value ==
                                                r['date_enregistrement'] ||
                                            dateTimeSaisie
                                                .isBefore(dateTimeFin))) {
                                      //
                                      print(
                                          "::: ${s["numero_de_compte"]} == ${r['compte']["numero_de_compte"]}");
//
                                      double debitTotal = 0;
                                      double creditTotal = 0;
                                      //
                                      String usd_cdf = r["usd_cdf"] ?? "0.0";
                                      String usd_eur = r["usd_eur"] ?? "0.0";
                                      String eur_cdf = r["eur_cdf"] ?? "0.0";
                                      //infosCellule

                                      jr['intitule'] = infosCellule;

                                      //
                                      ////n_piece: infosCellule[1]   journal: s['code']
                                      ///r['compte']["numero_de_compte"] ==
                                      //             s["numero_de_compte"]
                                      if (r['compte']["numero_de_compte"] ==
                                          s["numero_de_compte"]) {
                                        //
                                        jr['numero_de_compte'] =
                                            r['compte']["numero_de_compte"];
                                        jr['date_enregistrement'] =
                                            r['date_enregistrement'];
                                        //
                                        print(
                                            "::: ${s["numero_de_compte"]} == ${r['compte']["numero_de_compte"]}");
                                        /**
                                               *  ||
                                        r['date_enregistrement'] ==
                                            infosCellule
                                               */
                                        //
                                        //print(
                                        //  "balances: èè ${r['compte']['date_enregistrement']} -- ${r['compte']["numero_de_compte"] == s["numero_de_compte"] || r['date_enregistrement'] == infosCellule[0]} \n ${s["numero_de_compte"]}");

                                        //
                                        jrs.add(r);
                                        double md = r['montant_debit'];
                                        //___________________
                                        double mc = r['montant_credit'];
                                        //___________________
                                        //"USD", "CDF", "EUR"
                                        if (r['devise'] == "USD") {
                                          //USD
                                          if (Devises[indexDevise.value] ==
                                              "USD") {
                                            //
                                            r['montant_credit_'] = mc;
                                            r['montant_debit_'] = md;

                                            //
                                            tDebit = tDebit + md;
                                            tCrebit = tCrebit + mc;
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "CDF") {
                                            //
                                            r['montant_debit_'] =
                                                //
                                                debitTotal = debitTotal +
                                                    (md *
                                                        double.parse(usd_cdf));
                                            //
                                            r['montant_credit_'] =
                                                //
                                                creditTotal = creditTotal +
                                                    (mc *
                                                        double.parse(usd_cdf));

                                            creditTotal = creditTotal +
                                                (mc * double.parse(usd_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(usd_cdf));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(usd_cdf));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "EUR") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md * double.parse(usd_eur));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            creditTotal = creditTotal +
                                                (md * double.parse(usd_eur));
                                            creditTotal = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(usd_eur));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(usd_eur));
                                          }
                                        }
                                        if (r['devise'] == "CDF") {
                                          if (Devises[indexDevise.value] ==
                                              "USD") {
                                            //
                                            r['montant_debit_'] = creditTotal +
                                                (md / double.parse(usd_cdf));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc / double.parse(usd_cdf));
                                            //
                                            creditTotal = creditTotal +
                                                (md / double.parse(usd_cdf));
                                            debitTotal = debitTotal +
                                                (mc / double.parse(usd_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md / double.parse(usd_cdf));
                                            tCrebit = tCrebit +
                                                (mc / double.parse(usd_cdf));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "CDF") {
                                            //
                                            r['montant_credit_'] = mc;
                                            r['montant_debit_'] = md;
                                            //
                                            debitTotal = debitTotal + md;
                                            creditTotal = creditTotal + mc;
                                            //
                                            tDebit = tDebit + md;
                                            tCrebit = tCrebit + mc;
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "EUR") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md / double.parse(eur_cdf));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc / double.parse(eur_cdf));
                                            //
                                            debitTotal = debitTotal +
                                                (md / double.parse(eur_cdf));
                                            creditTotal = creditTotal +
                                                (mc / double.parse(eur_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md / double.parse(eur_cdf));
                                            tCrebit = tCrebit +
                                                (mc / double.parse(eur_cdf));
                                          }
                                        }
                                        if (r['devise'] == "EUR") {
                                          if (Devises[indexDevise.value] ==
                                              "USD") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md * double.parse(usd_eur));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            debitTotal = debitTotal +
                                                (md * double.parse(usd_eur));
                                            creditTotal = creditTotal +
                                                (mc * double.parse(usd_eur));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(usd_eur));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(usd_eur));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "CDF") {
                                            //
                                            r['montant_debit_'] = debitTotal +
                                                (md * double.parse(eur_cdf));
                                            //
                                            r['montant_credit_'] = creditTotal +
                                                (mc * double.parse(eur_cdf));
                                            //
                                            debitTotal = debitTotal +
                                                (md * double.parse(eur_cdf));
                                            creditTotal = creditTotal +
                                                (mc * double.parse(eur_cdf));
                                            //
                                            tDebit = tDebit +
                                                (md * double.parse(eur_cdf));
                                            tCrebit = tCrebit +
                                                (mc * double.parse(eur_cdf));
                                          }
                                          if (Devises[indexDevise.value] ==
                                              "EUR") {
                                            //
                                            r['montant_credit_'] = mc;
                                            r['montant_debit_'] = md;
                                            //
                                            debitTotal = debitTotal + md;
                                            creditTotal = creditTotal + mc;
                                            //
                                            tDebit = tDebit + md;
                                            tCrebit = tCrebit + mc;
                                          }
                                        }
                                        //
                                      }
                                    }
                                  });
                                  //
                                  jr['ssis'] = jrs;
                                  //
                                  //double anouveau = calcculeAnouveau(saisies, s);
                                  //
                                  jr["debitTotal"] = tDebit;
                                  jr["creditTotal"] = tCrebit;

                                  //
                                  double solde_periode = tDebit - tCrebit;
                                  //
                                  print("resultat: $jr");
                                  balances.add(jr);
                                  //
                                  //
                                  tDebit = 0;
                                  tCrebit = 0;
                                  //
                                }
                              });
                            });
                          }
                          //
                          for (int i = 0; i < balances.length; i++) {
                            //Map ss = resultats[i];

                            for (int j = 0; j < balances.length; j++) {
                              //

                              Map ii = balances[i];
                              Map jj = balances[j];
                              if (ii['date_enregistrement'] != null &&
                                  jj['date_enregistrement'] != null) {
                                List li = ii['date_enregistrement'].split("-");
                                DateTime d1 = DateTime(int.parse(li[2]),
                                    int.parse(li[1]), int.parse(li[0]));
                                //d0.isBefore(d1)

                                List lj = jj['date_enregistrement'].split("-");
                                DateTime d2 = DateTime(int.parse(lj[2]),
                                    int.parse(lj[1]), int.parse(lj[0]));
                                //d1.isBefore(d2)
                                if (d1.isBefore(d2)) {
                                  //resultats[i] < resultats[j]
                                  Map tmp = balances[i];
                                  balances[i] = balances[j];
                                  print(
                                      "la valeur de listeDate[$i] = ${balances[i]}");
                                  balances[j] = tmp;
                                  print(
                                      "et la valeur de listeDate[$j] = ${balances[j]}");
                                }
                              }
                            }
                          }
                          //
                          Get.back();
                          Get.to(
                            GrandLivre(
                              0,
                              balances,
                              dateDebut.value,
                              dateFin.value,
                              Devises[indexDevise.value],
                              compteSelect.isEmpty,
                              comptes.isNotEmpty
                                  ? comptes[indexCompte.value]['intitule']
                                  : "",
                            ),
                          );

                          //
                        } catch (e) {
                          Get.back();
                          print("eee $e");
                        }

                        ////////////////////////////////////////////////////////
                        // if (compteSelect.isEmpty) {
                        //   List choix = box.read("comptes") ?? [];
                        //   choix.forEach((s) {
                        //     //
                        //     double tDebit = 0.0;
                        //     double tCrebit = 0.0;
                        //     //
                        //     String usd_cdf = box.read("usd_cdf") ?? "0.0";
                        //     String usd_eur = box.read("usd_eur") ?? "0.0";
                        //     String eur_cdf = box.read("eur_cdf") ?? "0.0";
                        //     //
                        //     saisies.forEach((r) {
                        //       //
                        //       //print(
                        //       //  "numero_de_compte: ${s["numero_de_compte"]}");
                        //       //
                        //       List dateSaisieText =
                        //           r['date_enregistrement'].split("-");
                        //       List dateDebutText = dateDebut.value.split("-");
                        //       List dateFinText = dateFin.value.split("-");

                        //       //
                        //       DateTime dateTimeSaisie = DateTime(
                        //           int.parse(dateSaisieText[0]),
                        //           int.parse(dateSaisieText[1]),
                        //           int.parse(dateSaisieText[2]));
                        //       //
                        //       DateTime dateTimeDepart = DateTime(
                        //           int.parse(dateDebutText[0]),
                        //           int.parse(dateDebutText[1]),
                        //           int.parse(dateDebutText[2]));
                        //       //
                        //       DateTime dateTimeFin = DateTime(
                        //           int.parse(dateFinText[0]),
                        //           int.parse(dateFinText[1]),
                        //           int.parse(dateFinText[2]));
                        //       //
                        //       if ((dateDebut.value ==
                        //                   r['date_enregistrement'] ||
                        //               dateTimeSaisie.isAfter(dateTimeDepart)) &&
                        //           (dateFin.value == r['date_enregistrement'] ||
                        //               dateTimeSaisie.isBefore(dateTimeFin))) {
                        //         //
                        //         print(
                        //             "égalité ${r['devise']} -- ${r['montant_debit']} -- ${r['montant_credit']} \n $s");
                        //         //
                        //         if (r['compte']["numero_de_compte"] ==
                        //             s["numero_de_compte"]) {
                        //           double md = r['montant_debit'].isNotEmpty
                        //               ? double.parse(r['montant_debit'])
                        //               : 0;
                        //           //___________________
                        //           double mc = r['montant_credit'].isNotEmpty
                        //               ? double.parse(r['montant_credit'])
                        //               : 0;
                        //           //___________________
                        //           //"USD", "CDF", "EUR"
                        //           if (r['devise'] == "USD") {
                        //             //USD
                        //             if (Devises[indexDevise.value] == "USD") {
                        //               //
                        //               tDebit = tDebit + md;
                        //               tCrebit = tCrebit + mc;
                        //             }
                        //             if (Devises[indexDevise.value] == "CDF") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(usd_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(usd_cdf));
                        //             }
                        //             if (Devises[indexDevise.value] == "EUR") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(usd_eur));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(usd_eur));
                        //             }
                        //           }
                        //           if (r['devise'] == "CDF") {
                        //             if (Devises[indexDevise.value] == "USD") {
                        //               tDebit =
                        //                   tDebit + (md / double.parse(usd_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc / double.parse(usd_cdf));
                        //             }
                        //             if (Devises[indexDevise.value] == "CDF") {
                        //               //
                        //               tDebit = tDebit + md;
                        //               tCrebit = tCrebit + mc;
                        //             }
                        //             if (Devises[indexDevise.value] == "EUR") {
                        //               tDebit =
                        //                   tDebit + (md / double.parse(eur_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc / double.parse(eur_cdf));
                        //             }
                        //           }
                        //           if (r['devise'] == "EUR") {
                        //             if (Devises[indexDevise.value] == "USD") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(usd_eur));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(usd_eur));
                        //             }
                        //             if (Devises[indexDevise.value] == "CDF") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(eur_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(eur_cdf));
                        //             }
                        //             if (Devises[indexDevise.value] == "EUR") {
                        //               //
                        //               tDebit = tDebit + md;
                        //               tCrebit = tCrebit + mc;
                        //             }
                        //           }
                        //         }
                        //       }
                        //     });
                        //     //
                        //     double anouveau = calcculeAnouveau(saisies, s);
                        //     //
                        //     double solde_periode = tDebit - tCrebit;
                        //     //
                        //     balances.add({
                        //       "numero_de_compte": s['numero_de_compte'],
                        //       "intitule": s['intitule'],
                        //       "cumul_credit": tCrebit,
                        //       "cumul_debit": tDebit,
                        //       "solde_periode": solde_periode,
                        //     });
                        //   });

                        //   //
                        // } else {
                        //   //

                        //   //print(
                        //   //  "compteSelect: $compteSelect \n saisies: $saisies");
                        //   compteSelect.forEach((s) {
                        //     //
                        //     double tDebit = 0.0;
                        //     double tCrebit = 0.0;
                        //     //
                        //     Map ccme = {
                        //       "intitule": s['intitule'],
                        //       "numero_de_compte": s['numero_de_compte'],
                        //     };
                        //     //
                        //     List ssis = [];

                        //     //
                        //     String usd_cdf = box.read("usd_cdf") ?? "0.0";
                        //     String usd_eur = box.read("usd_eur") ?? "0.0";
                        //     String eur_cdf = box.read("eur_cdf") ?? "0.0";
                        //     //
                        //     saisies.forEach((r) {
                        //       //
                        //       //print(
                        //       //  "numero_de_compte: ${s["numero_de_compte"]}");
                        //       //
                        //       List dateSaisieText =
                        //           r['date_enregistrement'].split("-");
                        //       List dateDebutText = dateDebut.value.split("-");
                        //       List dateFinText = dateFin.value.split("-");

                        //       //
                        //       DateTime dateTimeSaisie = DateTime(
                        //           int.parse(dateSaisieText[0]),
                        //           int.parse(dateSaisieText[1]),
                        //           int.parse(dateSaisieText[2]));
                        //       //
                        //       DateTime dateTimeDepart = DateTime(
                        //           int.parse(dateDebutText[0]),
                        //           int.parse(dateDebutText[1]),
                        //           int.parse(dateDebutText[2]));
                        //       //
                        //       DateTime dateTimeFin = DateTime(
                        //           int.parse(dateFinText[0]),
                        //           int.parse(dateFinText[1]),
                        //           int.parse(dateFinText[2]));
                        //       //
                        //       if ((dateDebut.value ==
                        //                   r['date_enregistrement'] ||
                        //               dateTimeSaisie.isAfter(dateTimeDepart)) &&
                        //           (dateFin.value == r['date_enregistrement'] ||
                        //               dateTimeSaisie.isBefore(dateTimeFin))) {
                        //         //
                        //         print(
                        //             "égalité ${r['compte']["numero_de_compte"]} -- ${r['compte']["numero_de_compte"]} -- ${s["numero_de_compte"]} \n $s");
                        //         //
                        //         if (r['compte']["numero_de_compte"] ==
                        //             s["numero_de_compte"] || s["date_enregistrement"] == r["date_enregistrement"]) {
                        //           //
                        //           ssis.add(r);

                        //           double md = r['montant_debit'].isNotEmpty
                        //               ? double.parse(r['montant_debit'])
                        //               : 0;
                        //           //___________________
                        //           double mc = r['montant_credit'].isNotEmpty
                        //               ? double.parse(r['montant_credit'])
                        //               : 0;
                        //           //___________________
                        //           //"USD", "CDF", "EUR"
                        //           if (r['devise'] == "USD") {
                        //             //USD
                        //             if (Devises[indexDevise.value] == "USD") {
                        //               //
                        //               tDebit = tDebit + md;
                        //               tCrebit = tCrebit + mc;
                        //             }
                        //             if (Devises[indexDevise.value] == "CDF") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(usd_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(usd_cdf));
                        //             }
                        //             if (Devises[indexDevise.value] == "EUR") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(usd_eur));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(usd_eur));
                        //             }
                        //           }
                        //           if (r['devise'] == "CDF") {
                        //             if (Devises[indexDevise.value] == "USD") {
                        //               tDebit =
                        //                   tDebit + (md / double.parse(usd_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc / double.parse(usd_cdf));
                        //             }
                        //             if (Devises[indexDevise.value] == "CDF") {
                        //               //
                        //               tDebit = tDebit + md;
                        //               tCrebit = tCrebit + mc;
                        //             }
                        //             if (Devises[indexDevise.value] == "EUR") {
                        //               tDebit =
                        //                   tDebit + (md / double.parse(eur_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc / double.parse(eur_cdf));
                        //             }
                        //           }
                        //           if (r['devise'] == "EUR") {
                        //             if (Devises[indexDevise.value] == "USD") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(usd_eur));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(usd_eur));
                        //             }
                        //             if (Devises[indexDevise.value] == "CDF") {
                        //               tDebit =
                        //                   tDebit + (md * double.parse(eur_cdf));
                        //               tCrebit = tCrebit +
                        //                   (mc * double.parse(eur_cdf));
                        //             }
                        //             if (Devises[indexDevise.value] == "EUR") {
                        //               //
                        //               tDebit = tDebit + md;
                        //               tCrebit = tCrebit + mc;
                        //             }
                        //           }
                        //         }
                        //       }
                        //     });
                        //     //
                        //     double anouveau = calcculeAnouveau(saisies, s);
                        //     //
                        //     double solde_periode = tDebit - tCrebit;
                        //     //
                        //     ccme["ssis"] = ssis;
                        //     //
                        //     balances.add(ccme);
                        //   });
                        // }
                        //
                        //print("balances: $balances");
                        //
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
