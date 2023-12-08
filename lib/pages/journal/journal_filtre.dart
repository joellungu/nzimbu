import 'package:nzimbu/pages/comptes/nouveau_compte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'journal_controller.dart';
import 'journal_filtre_resultat.dart';
import 'nouveau_journal.dart';

class JournalFiltre extends GetView<JournalController> {
  //
  var box = GetStorage();
  RxString dateDebut = "".obs;
  RxString dateFin = "".obs;
  //
  JournalFiltre() {
    //
    journals.value = box.read("journaux") ?? [];
    DateTime d = DateTime.now();
    //controller.tousLesClients();
    dateDebut.value = "${d.day}-${d.month}-${d.year}";
    dateFin.value = "${d.day}-${d.month}-${d.year}";
    //
  }
  //
  RxString text = "".obs;
  //

  RxList journals = [].obs;
  RxList journalSelect = [].obs;
  Set jrs = Set();
  RxInt indexJournal = 0.obs;
  //
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
                                    journalSelect.clear();
                                    jrs.clear();
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
                        const Text("Journal"),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonHideUnderline(
                            child: Obx(
                              () => journals.isNotEmpty
                                  ? DropdownButton(
                                      value: indexJournal.value,
                                      onChanged: (c) {
                                        //
                                        indexJournal.value = c as int;
                                        //compteDefaut = codes[c as int]['code'];
                                        if (Selections[indexSelect.value] !=
                                            "Tout") {
                                          if (jrs.add(
                                              "${journals[c]['intitule']}")) {
                                            journalSelect.add(journals[c]);
                                          }
                                        }
                                      },
                                      items: List.generate(journals.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: index,
                                          child: Text(
                                              "${journals[index]['intitule']} (${journals[index]['code']})"),
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
                        children: List.generate(journalSelect.length, (index) {
                          Map journal = journalSelect[index];
                          if ("${journal['intitule']}"
                                  .toLowerCase()
                                  .contains(text.value.toLowerCase()) ||
                              "${journal['type']}"
                                  .toLowerCase()
                                  .contains(text.value.toLowerCase())) {
                            return ListTile(
                              //isThreeLine: true,
                              //leading: Icon(Icons.person),
                              title: Text("${journal['intitule']}"),
                              subtitle: Text(
                                "${journal['type']}",
                                style: const TextStyle(
                                  color: Colors.teal,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  //
                                  jrs.remove("${journal['intitule']}");
                                  journalSelect.removeAt(index);
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
                        //
                        var exercice = box.read("exercice") ?? "";
                        //saisies
                        List resultats = [];
                        List saisies = box.read("saisies$exercice") ?? [];
                        Set listePieces = Set();
                        saisies.forEach((ss) {
                          //${ss['date_enregistrement']}|${ss['n_piece']}|${ss['journale']['code']}
                          listePieces.add(
                              "${ss['n_piece']}|${ss['date_enregistrement']}");
                        });
                        //saisies
                        if (journalSelect.isEmpty &&
                            Selections[indexSelect.value] == "Tout") {
                          List choix = box.read("journaux") ?? [];

                          //
                          listePieces.forEach((piece) {
                            List infosCellule = "$piece".split("|");
                            //List infosCellule = "$piece".split("|");
                            //

                            //n_piece: infosCellule[1]   journal: s['code']
                            //
                            choix.forEach((s) {
                              //
                              List jrs = [];

                              //
                              double tDebit = 0.0;
                              double tCrebit = 0.0;
                              //
                              Map jr = {};
                              //
                              //List infosCellule = "$piece".split("|");

                              //Date d'écriture${ss['date_enregistrement']} Piece N° ${ss['n_piece']}

                              //
                              saisies.forEach((r) {
                                //print(
                                //  "La valeur: ${(infosCellule[1] == r['n_piece']) && (s['code'] == r['journale']['code']) && (infosCellule[2] == r['journale']['code'])} ");
                                //Seulement si
                                if ((infosCellule[0] == r['n_piece']) &&
                                    (s['code'] == r['journale']['code']) &&
                                    infosCellule[1] ==
                                        r['date_enregistrement']) {
                                  double debitTotal = 0;
                                  double creditTotal = 0;
                                  /**
                                       * (infosCellule[2] ==
                                        r['journale']['code'])
                                       */
                                  //
                                  //jr['date_enregistrement'] = infosCellule[0];
                                  //jr['n_piece'] = infosCellule[1];
                                  //
                                  print("cool test: ${r['n_piece']}");
                                  //____________________________________________

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

                                    //
                                    print(
                                        "égalité ${r['devise']} -- ${r['montant_debit']} -- ${r['montant_credit']} \n $s");
                                    ////n_piece: infosCellule[1]   journal: s['code']
                                    if (r['journale']["code"] == s["code"] &&
                                        r['n_piece'] == infosCellule[0]) {
                                      //[1]

                                      //
                                      jr['intitule'] = s['intitule'];
                                      jr['code'] = s['code'];
                                      jr['type'] = s['type'];
                                      //
                                      String usd_cdf =
                                          box.read("usd_cdf") ?? "0.0";
                                      String usd_eur =
                                          box.read("usd_eur") ?? "0.0";
                                      String eur_cdf =
                                          box.read("eur_cdf") ?? "0.0";
                                      //
                                      jr['n_piece'] = infosCellule[0];
                                      jr['date_enregistrement'] =
                                          r["date_enregistrement"];
                                      //['compte']

                                      //___________________
                                      double mc = r['montant_credit'];
                                      double md = r['montant_debit'];

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
                                                  (md * double.parse(usd_cdf));
                                          //
                                          r['montant_credit_'] =
                                              //
                                              creditTotal = creditTotal +
                                                  (mc * double.parse(usd_cdf));

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
                                      jrs.add(r);
                                      //
                                    }
                                  }
                                }
                              });
                              //
                              jr['jrs'] = jrs;
                              //
                              //double anouveau = calcculeAnouveau(saisies, s);
                              //
                              jr["debitTotal"] = tDebit;
                              jr["creditTotal"] = tCrebit;

                              //
                              double solde_periode = tDebit - tCrebit;
                              //
                              print("resultat: $jr");
                              resultats.add(jr);
                              //
                              //
                              tDebit = 0;
                              tCrebit = 0;
                              //
                            });
                          });

                          //
                        } else {
                          //

                          //print(
                          //  "compteSelect: $compteSelect \n saisies: $saisies");

                          //__________________________________________________
                          listePieces.forEach((piece) {
                            List infosCellule = "$piece".split("|");
                            //.split("|");

                            //

                            //n_piece: infosCellule[1]   journal: s['code']
                            //
                            journalSelect.forEach((s) {
                              //
                              List jrs = [];

                              //
                              double tDebit = 0.0;
                              double tCrebit = 0.0;
                              //
                              Map jr = {};
                              //
                              //List infosCellule = "$piece".split("|");

                              //Date d'écriture${ss['date_enregistrement']} Piece N° ${ss['n_piece']}

                              //
                              saisies.forEach((r) {
                                //print(
                                //  "La valeur: ${(infosCellule[1] == r['n_piece']) && (s['code'] == r['journale']['code']) && (infosCellule[2] == r['journale']['code'])} ");
                                //Seulement si
                                if ((infosCellule[0] == r['n_piece']) &&
                                    (s['code'] == r['journale']['code']) &&
                                    infosCellule[1] ==
                                        r['date_enregistrement']) {
                                  double debitTotal = 0;
                                  double creditTotal = 0;
                                  /**
                                       * (infosCellule[2] ==
                                        r['journale']['code'])
                                       */
                                  //
                                  //jr['date_enregistrement'] = infosCellule[0];
                                  //jr['n_piece'] = infosCellule[1];
                                  //
                                  print("cool test: ${r['n_piece']}");
                                  //____________________________________________

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
                                  print(
                                      "resultats : ${(dateDebut.value == r['date_enregistrement'] || dateTimeSaisie.isAfter(dateTimeDepart)) && (dateFin.value == r['date_enregistrement'] || dateTimeSaisie.isBefore(dateTimeFin))}");
                                  //
                                  print(
                                      "resultats : ${(dateDebut.value == r['date_enregistrement'])}");
                                  //
                                  print(
                                      "resultats : ${(dateTimeSaisie.isAfter(dateTimeDepart))}");
                                  //
                                  print(
                                      "resultats : ${(dateDebut.value)} == ${r['date_enregistrement']} || ${dateTimeSaisie.isAfter(dateTimeDepart)}");
                                  //
                                  print(
                                      "resultats : _____________________________________________________________");
                                  //
                                  print(
                                      "resultats : ${(dateFin.value == r['date_enregistrement'] || dateTimeSaisie.isBefore(dateTimeFin))}");
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

                                    //
                                    print(
                                        "égalité ${r['devise']} -- ${r['montant_debit']} -- ${r['montant_credit']} \n $s");
                                    ////n_piece: infosCellule[1]   journal: s['code']
                                    if (r['journale']["code"] == s["code"] &&
                                        r['n_piece'] == infosCellule[0]) {
                                      //[1]

                                      //
                                      jr['intitule'] = s['intitule'];
                                      jr['code'] = s['code'];
                                      jr['type'] = s['type'];
                                      //
                                      String usd_cdf =
                                          box.read("usd_cdf") ?? "0.0";
                                      String usd_eur =
                                          box.read("usd_eur") ?? "0.0";
                                      String eur_cdf =
                                          box.read("eur_cdf") ?? "0.0";
                                      //
                                      jr['n_piece'] = infosCellule[0];
                                      jr['date_enregistrement'] =
                                          r["date_enregistrement"];
                                      //['compte']

                                      //___________________
                                      double md = r['montant_debit'];
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
                                                  (md * double.parse(usd_cdf));
                                          //
                                          r['montant_credit_'] =
                                              //
                                              creditTotal = creditTotal +
                                                  (mc * double.parse(usd_cdf));

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
                                      jrs.add(r);
                                      //
                                    }
                                  }
                                }
                              });
                              //
                              jr['jrs'] = jrs;
                              //
                              //double anouveau = calcculeAnouveau(saisies, s);
                              //
                              jr["debitTotal"] = tDebit;
                              jr["creditTotal"] = tCrebit;

                              //
                              double solde_periode = tDebit - tCrebit;
                              //
                              print("resultat: $jr");
                              resultats.add(jr);
                              //
                              //
                              tDebit = 0;
                              tCrebit = 0;
                              //
                            });
                          });
                        }
                        //
                        //print(
                        //  "resultats : ${dateDebut.value} : ${dateFin.value} $resultats");
                        //Algo de tri par date...
                        List listeTrie = [];
                        List l0 = dateDebut.split("-");
                        DateTime d0 = DateTime(int.parse(l0[2]),
                            int.parse(l0[1]), int.parse(l0[1]));
                        for (int i = 0; i < resultats.length; i++) {
                          //Map ss = resultats[i];

                          for (int j = 0; j < resultats.length; j++) {
                            //

                            Map ii = resultats[i];
                            Map jj = resultats[j];
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
                                Map tmp = resultats[i];
                                resultats[i] = resultats[j];
                                print(
                                    "la valeur de listeDate[$i] = ${resultats[i]}");
                                resultats[j] = tmp;
                                print(
                                    "et la valeur de listeDate[$j] = ${resultats[j]}");
                              }
                            }
                          }
                        }
                        print("resultats: $resultats");
                        //
                        // for (int i = 0; i < resultats.length; i++) {
                        //   //
                        //   Map ii = resultats[i];
                        //   List li = ii['date_enregistrement'].split("-");
                        //   DateTime d1 = DateTime(li[2], li[1], li[0]);
                        //   if (d0.isBefore(d1)) {
                        //     listeTrie.add(ii);
                        //     //
                        //     //
                        //   } else if (d0.isAfter(d1)) {
                        //     listeTrie.insert(i, ii);
                        //   } else {
                        //     listeTrie.add(ii);
                        //   }
                        // }
                        //

                        Get.back();
                        Get.to(
                          JournalFiltreResultat(
                            0,
                            resultats,
                            dateDebut.value,
                            dateFin.value,
                            Devises[indexDevise.value],
                            journalSelect.isEmpty,
                            journals[indexJournal.value]['intitule'],
                          ),
                        );
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
}
