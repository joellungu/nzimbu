import 'dart:io' as io;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApercuGrandLivre extends StatelessWidget {
  int index;
  List resultats;
  String dateDepart;
  String dateFin;
  String devise;
  //
  var box = GetStorage();
  String titre = "";

  ApercuGrandLivre(
      this.index, this.resultats, this.dateDepart, this.dateFin, this.devise) {
    //
    List exercices = box.read("exercices") ?? [];
    //
    String exe = box.read("exercice") ?? "";
    //annee
    //label
    for (var element in exercices) {
      if (element["annee"] == exe) {
        titre = "${element["label"]} ${element["annee"]}";
        break;
      }
    }
  }
  //
  double debit = 0;
  @override
  Widget build(BuildContext context) {
    //
    Set js = Set();
    //

    DateTime d = DateTime.now();
    //
    resultats.forEach((element) {
      Map r = resultats[index];
      //print("le resultats: $r");
      //List l = r["jrs"];

      js.add(r["intitule"]);
    });
    //
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dossier $titre"),
              Text("Brouillard"),
              Text("Le ${d.day}-${d.month}-${d.year}")
            ],
          ),
          Container(
            margin: EdgeInsets.all(1),
            height: 2,
            width: double.maxFinite,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.all(1),
            height: 2,
            width: double.maxFinite,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "EDITION DU GRAND LIVRE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Période du $dateDepart au $dateFin"),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text("Journal: $js".replaceAll("{", "").replaceAll("}", ""))
          //   ],
          // ), //
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Devise: $devise")],
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "N° Mvt",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Journal",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Date",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "N° de pièce",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Libellé de l'écriture",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Montant Débit",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Montant Crédit",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Solde Cumulé",
                      style: entete,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /**
         * "numero_de_compte": s['numero_de_compte'],
                              "intitule": s['intitule'],
                              "cumul_credit": tCrebit,
                              "cumul_debit": tDebit,
                              "solde_periode": solde_periode,
         */
          Expanded(
            flex: 1,
            child: ListView(
              children: List.generate(resultats.length, (index) {
                Map r = resultats[index];
                // r['numero_de_compte']
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      height: 25,
                      child: Text(
                        "${r['numero_de_compte']}    ${r['intitule']}",
                        style: entete,
                      ),
                    ),

                    Column(
                      children: List.generate(r['ssis'].length, (index) {
                        //return Text("Salut");
                        Map s = r['ssis'][index];
                        //
                        print("balances: $s");
                        //

                        if (index == 0) {
                          debit = s['montant_debit'].isNotEmpty
                              ? double.parse(s['montant_debit'])
                              : 0;
                        }
                        double credit = s['montant_credit'].isNotEmpty
                            ? double.parse(s['montant_credit'])
                            : 0;
                        //
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                          ),
                          height: 40,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "N° Mvt",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['journale']['code']} (${s['journale']['code']})",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['date_enregistrement']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['n_piece']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['libelle_enregistrement']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['montant_debit']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['montant_credit']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${debit - credit}",
                                    style: entete,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.teal,
                    //     border: Border(
                    //       bottom: BorderSide(
                    //         color: Colors.black,
                    //         width: 0.5,
                    //       ),
                    //     ),
                    //   ),
                    //   height: 40,
                    //   width: double.maxFinite,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "TOTAL",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 2,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 2,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 2,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 3,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 2,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 3,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 1,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 2,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 2,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "${r['debitTotal']}",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 2,
                    //         color: Colors.black,
                    //       ),
                    //       Expanded(
                    //         flex: 2,
                    //         child: Container(
                    //           color: Colors.grey.shade300,
                    //           width: double.maxFinite,
                    //           height: double.maxFinite,
                    //           child: Text(
                    //             "${r['creditTotal']}",
                    //             style: entete,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //

          //
          final pdf = pw.Document();

          // pdf.addPage(
          //   pw.Page(
          //     pageFormat: PdfPageFormat.a4,
          //     margin: pw.EdgeInsets.all(0),
          //     build: (pw.Context context) {
          //       return pw.Column(children: [
          //         pw.Row(
          //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          //           children: [
          //             pw.Text("Dossier"),
          //             pw.Text("Brouillard"),
          //             pw.Text("Le Lelo")
          //           ],
          //         ),
          //         pw.Row(
          //           mainAxisAlignment: pw.MainAxisAlignment.center,
          //           children: [pw.Text("EDITION DU BROUILLARD")],
          //         ),
          //         pw.Row(
          //           mainAxisAlignment: pw.MainAxisAlignment.start,
          //           children: [
          //             pw.Text("Période du ... à ..."),
          //           ],
          //         ),
          //         pw.Row(
          //           mainAxisAlignment: pw.MainAxisAlignment.start,
          //           children: [pw.Text("Journal: ")],
          //         ),
          //       ]); // Center
          //     },
          //   ),
          // );
          //
          pdf.addPage(
            pw.MultiPage(
              margin: const pw.EdgeInsets.all(3),
              header: (c) {
                //
                return pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Dossier titre"),
                        pw.Text("Brouillard"),
                        pw.Text("Le ${d.day}-${d.month}-${d.year}")
                      ],
                    ),
                    pw.Container(
                      margin: pw.EdgeInsets.all(1),
                      height: 2,
                      width: double.maxFinite,
                      color: PdfColors.black,
                    ),
                    pw.Container(
                      margin: pw.EdgeInsets.all(1),
                      height: 2,
                      width: double.maxFinite,
                      color: PdfColors.black,
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          "EDITION DU GRAND LIVRE",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        )
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text("Période du $dateDepart au $dateFin"),
                      ],
                    ),
                    // pw.Row(
                    //   mainAxisAlignment: pw.MainAxisAlignment.start,
                    //   children: [
                    //     pw.Text("Journal: $js"
                    //         .replaceAll("{", "")
                    //         .replaceAll("}", ""))
                    //   ],
                    // ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [pw.Text("Devise: $devise")],
                    ),
                    //
                    pw.Container(
                      height: 25,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "N° Mvt",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Journal",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Date",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "N° de pièce",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 5,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Libellé de l'écriture",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Montant Débit",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Montant Crédit",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 1,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Solde Cumulé",
                                style: entete1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              build: (c) {
                return List.generate(resultats.length, (index) {
                  Map r = resultats[index];
                  // r['numero_de_compte']
                  return pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.only(left: 10),
                        alignment: pw.Alignment.centerLeft,
                        height: 25,
                        child: pw.Text(
                          "${r['numero_de_compte']}    ${r['intitule']}",
                          style: entete1,
                        ),
                      ),

                      pw.Column(
                        children: List.generate(r['ssis'].length, (index) {
                          //return Text("Salut");
                          Map s = r['ssis'][index];
                          //
                          print("balances: $s");
                          //

                          if (index == 0) {
                            debit = s['montant_debit'].isNotEmpty
                                ? double.parse(s['montant_debit'])
                                : 0;
                          }
                          double credit = s['montant_credit'].isNotEmpty
                              ? double.parse(s['montant_credit'])
                              : 0;
                          //
                          return pw.Container(
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                bottom: pw.BorderSide(
                                  color: PdfColors.black,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            height: 40,
                            width: double.maxFinite,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              children: [
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "N° Mvt",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: PdfColors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['journale']['code']} (${s['journale']['code']})",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['date_enregistrement']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['n_piece']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 5,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['libelle_enregistrement']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['montant_debit']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['montant_credit']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 1,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: Colors.grey.shade300,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${debit - credit}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     color: Colors.teal,
                      //     border: Border(
                      //       bottom: BorderSide(
                      //         color: Colors.black,
                      //         width: 0.5,
                      //       ),
                      //     ),
                      //   ),
                      //   height: 40,
                      //   width: double.maxFinite,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "TOTAL",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 2,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 2,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 2,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 3,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 2,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 3,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 1,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 1,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 2,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "${r['debitTotal']}",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 2,
                      //         color: Colors.black,
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Container(
                      //           color: Colors.grey.shade300,
                      //           width: double.maxFinite,
                      //           height: double.maxFinite,
                      //           child: Text(
                      //             "${r['creditTotal']}",
                      //             style: entete,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                });
              },
            ),
          );
          /**
           * Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Dossier"), Text("Brouillard"), Text("Le Lelo")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("EDITION DU BROUILLARD")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Période du ... à ..."),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Journal: ")],
          ),
           */
          //
          String? outputFile = await FilePicker.platform.saveFile(
              dialogTitle: 'Save Your File to desired location',
              fileName: "GRANDLIVRE - $titre.pdf");

          try {
            //
            final file = io.File("$outputFile");
            await file.writeAsBytes(await pdf.save());
            //io.File returnedFile = io.File('$outputFile');
            //await returnedFile.writeAsString("Salut bro");
          } catch (e) {
            Get.snackbar("Erreur", "Un problème d'enregistrement ($e)");
          }
        },
        child: const Icon(Icons.print_rounded),
      ),
    );
  }

  //
  pw.TextStyle entete1 = pw.TextStyle(
    fontSize: 7,
    fontWeight: pw.FontWeight.normal,
  );
  //
  TextStyle entete = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
}
