import 'dart:io' as io;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApercuBalance extends StatelessWidget {
  int index;
  List resultats;
  String dateDepart;
  String dateFin;
  String devise;

  //
  var box = GetStorage();
  String titre = "";

  ApercuBalance(
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
                "EDITION DE LA BALANCE",
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
                      "N° de Compte",
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
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade500,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Text(
                      "Solde À-nouveaux",
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
                      "Cumul débit",
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
                      "Cumul crédit",
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
                      "Solde période",
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
                      "Solde total",
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
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                  ),
                  height: 35,
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
                            "${r['numero_de_compte']}",
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
                            "${r['intitule']}",
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
                            "${r['cumul_debit']}",
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
                            "${r['cumul_credit']}",
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
                            "${r['solde_periode']}",
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
                            "${r['solde_periode']}",
                            style: entete,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          "EDITION DE LA BALANCE",
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
                                "N° de Compte",
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
                            flex: 1,
                            child: pw.Container(
                              color: PdfColors.grey,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "Solde À-nouveaux",
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
                                "Cumul débit",
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
                                "Cumul crédit",
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
                                "Solde période",
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
                                "Solde total",
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
                  return pw.Container(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.black,
                          width: 0.5,
                        ),
                      ),
                    ),
                    height: 30,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Container(
                            //color: PdfColors.grey,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: pw.Text(
                              "${r['numero_de_compte']}",
                              style: entete1,
                            ),
                          ),
                        ),
                        pw.Container(
                          width: 1,
                          color: PdfColors.black,
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            //color: PdfColors.grey,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: pw.Text(
                              "${r['intitule']}",
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
                              "${r['cumul_debit']}",
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
                            //color: PdfColors.grey,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: pw.Text(
                              "${r['cumul_credit']}",
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
                              "${r['solde_periode']}",
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
                              "${r['solde_periode']}",
                              style: entete1,
                            ),
                          ),
                        ),
                      ],
                    ),
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
              fileName: "BALANCE - $titre.pdf");

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
