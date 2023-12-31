import 'dart:io' as io;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApercuJournal extends StatelessWidget {
  int index;
  List resultats;
  String dateDepart;
  String dateFin;
  String devise;
//
  var box = GetStorage();
  String titre = "";

  ApercuJournal(
      this.index, this.resultats, this.dateDepart, this.dateFin, this.devise) {
    List exercices = box.read("exercices") ?? [];
    //
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
                "EDITION DU BROUILLARD",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Journal: $js".replaceAll("{", "").replaceAll("}", ""))
            ],
          ), //
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
                      "JL",
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
                      "Date écheance",
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
                      "N° de compte",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Intitulé du compte",
                      style: entete,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  color: Colors.black,
                ),
                Expanded(
                  flex: 3,
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
                      "Debit",
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
                      "Crédit",
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
                      child: Text("${r['intitule']}"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      height: 25,
                      child: Text(
                          "Date d'écriture: ${r['date_enregistrement']} Piece N° ${r['n_piece']}"),
                    ),
                    Column(
                      children: List.generate(r['jrs'].length, (index) {
                        //return Text("Salut");
                        Map s = r['jrs'][index];
                        //
                        return Container(
                          decoration: BoxDecoration(
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
                                    "${s['journale']['type']}",
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
                                    "${s['date_echeance'] ?? ""}",
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
                                    "${s['compte']['numero_de_compte']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  child: Text(
                                    "${s['compte']['intitule']}",
                                    style: entete,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 3,
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
                                width: 1,
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
                            ],
                          ),
                        );
                      }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade300,
                        border: const Border(
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
                                "TOTAL",
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
                            flex: 3,
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
                            flex: 3,
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
                            width: 1,
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
                                "${r['debitTotal']}",
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
                                "${r['creditTotal']}",
                                style: entete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        pw.Text("Dossier $titre"),
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
                          "EDITION DU BROUILLARD",
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
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text("Journal: $js"
                            .replaceAll("{", "")
                            .replaceAll("}", ""))
                      ],
                    ),
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
                                "JL",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 2,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Date écheance",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 2,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "N° de compte",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 2,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Intitulé du compte",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 2,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 3,
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
                            width: 2,
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
                            width: 2,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Debit",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 2,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Crédit",
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
                        child: pw.Text("${r['intitule']}"),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.only(left: 10),
                        height: 25,
                        child: pw.Text(
                            "Date d'écriture: ${r['date_enregistrement']} Piece N° ${r['n_piece']}"),
                      ),
                      pw.Column(
                        children: List.generate(r['jrs'].length, (index) {
                          //return Text("Salut");
                          Map s = r['jrs'][index];
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
                            height: 25,
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
                                      "${s['journale']['type']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 2,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['date_echeance'] ?? ""}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 2,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['compte']['numero_de_compte']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 2,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 3,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['compte']['intitule']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 2,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 3,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
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
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 2,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['montant_debit']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 2,
                                  color: PdfColors.black,
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Container(
                                    //color: PdfColors.grey,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: pw.Text(
                                      "${s['montant_credit']}",
                                      style: entete1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.teal,
                          border: const pw.Border(
                            bottom: pw.BorderSide(
                              color: PdfColors.black,
                              width: 0.5,
                            ),
                          ),
                        ),
                        height: 20,
                        width: double.maxFinite,
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
                                  "TOTAL",
                                  style: entete1,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 2,
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
                              width: 2,
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
                              width: 2,
                              color: PdfColors.black,
                            ),
                            pw.Expanded(
                              flex: 3,
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
                              width: 2,
                              color: PdfColors.black,
                            ),
                            pw.Expanded(
                              flex: 3,
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
                              width: 2,
                              color: PdfColors.black,
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                color: PdfColors.grey,
                                width: double.maxFinite,
                                height: double.maxFinite,
                                child: pw.Text(
                                  "${r['debitTotal']}",
                                  style: entete1,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 2,
                              color: PdfColors.black,
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                color: PdfColors.grey,
                                width: double.maxFinite,
                                height: double.maxFinite,
                                child: pw.Text(
                                  "${r['creditTotal']}",
                                  style: entete1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
              fileName: "JOURNAUX - $titre.pdf");

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
