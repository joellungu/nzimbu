import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/utils/langi.dart';
import 'package:excel/excel.dart' as ex;
import 'dart:io' as io;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'apercu_balance.dart';

class Balance extends StatelessWidget {
  int index;
  List resultats;

  String dateDepart;
  String dateFin;
  String devise;
  bool tout;
  //
  //
  String balance;
  //
  var box = GetStorage();
  String titre = "";

  Balance(this.index, this.resultats, this.dateDepart, this.dateFin,
      this.devise, this.tout, this.balance) {
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
      appBar: AppBar(
        actions: [
          IconButton(
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
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
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
                                  "${r['cumul_debit'] == 0.00 ? '' : r['cumul_debit']}",
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
                                  "${r['cumul_credit'] == 0.00 ? '' : r['cumul_credit']}",
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
                                  "${r['solde_periode'] == 0.00 ? '' : r['solde_periode']}",
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
                  fileName:
                      "BALANCE - ${tout ? 'tous' : balance} - $titre.pdf");

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
            icon: SvgPicture.asset(
              "assets/Fa6SolidFilePdf.svg",
              colorFilter: ColorFilter.mode(Langi.base2, BlendMode.srcIn),

              //semanticsLabel: e["titre"],
              height: 30,
              width: 30,
            ),
          ),
          IconButton(
            onPressed: () async {
              //
              // automatically creates 1 empty sheet: Sheet1
              ex.Excel excel = ex.Excel.createExcel();
              //
              // excel.appendRow('SheetName', [
              //   "Nom",
              //   "Post-Nom",
              //   "Prenom",
              //   "Date",
              //   "Age",
              // ]);
              // //
              ex.Sheet sheetObject = excel['SheetName'];

              ex.CellStyle cellStyle = ex.CellStyle(
                  backgroundColorHex: '#1AFF1A',
                  fontFamily: ex.getFontFamily(ex.FontFamily.Calibri));

              cellStyle.underline = ex.Underline.Single; // or Underline.Double

              var cell1 = sheetObject.cell(ex.CellIndex.indexByString('A1'));
              cell1.value = 'N° de Compte'.toUpperCase();
              // dynamic values support provided;
              cell1.cellStyle = cellStyle;
              //
              var cell2 = sheetObject.cell(ex.CellIndex.indexByString('B1'));
              cell2.value = 'Intitulé du compte'.toUpperCase();
              // dynamic values support provided;
              cell2.cellStyle = cellStyle;
              //
              var cell3 = sheetObject.cell(ex.CellIndex.indexByString('C1'));
              cell3.value = 'Solde À-nouveaux'.toUpperCase();
              // dynamic values support provided;
              cell3.cellStyle = cellStyle;
              //
              var cell4 = sheetObject.cell(ex.CellIndex.indexByString('D1'));
              cell4.value = 'Cumul débit'.toUpperCase();
              // dynamic values support provided;
              cell4.cellStyle = cellStyle;
              //
              var cell5 = sheetObject.cell(ex.CellIndex.indexByString("E1"));
              cell5.value = "Cumul crédit".toUpperCase();
              //cell5.value = 8; // dynamic values support provided;
              cell5.cellStyle = cellStyle;
              //
              var cell6 = sheetObject.cell(ex.CellIndex.indexByString('F1'));
              cell6.value = 'Solde période'.toUpperCase();
              // dynamic values support provided;
              cell6.cellStyle = cellStyle;
              //
              var cell7 = sheetObject.cell(ex.CellIndex.indexByString('G1'));
              cell7.value = 'Solde total'.toUpperCase();
              // dynamic values support provided;
              cell7.cellStyle = cellStyle;
              //
              // var cell8 = sheetObject.cell(ex.CellIndex.indexByString('H1'));
              // cell8.value = 'Crédit'.toUpperCase();
              // // dynamic values support provided;
              // cell8.cellStyle = cellStyle;
              // //
              // var cell9 = sheetObject.cell(ex.CellIndex.indexByString('I1'));
              // cell9.value = 'Intitulé'.toUpperCase();
              // // dynamic values support provided;
              // cell9.cellStyle = cellStyle;
              // //
              // var cell10 = sheetObject.cell(ex.CellIndex.indexByString('J1'));
              // cell10.value = "Date d'ecriture".toUpperCase();
              // // dynamic values support provided;
              // cell10.cellStyle = cellStyle;
              // //
              // //
              // var cell11 = sheetObject.cell(ex.CellIndex.indexByString('K1'));
              // cell11.value = 'N° piece'.toUpperCase();
              // //cell9.value = 8; // dynamic values support provided;
              // cell11.cellStyle = cellStyle;
              //
              // var cell12 = sheetObject.cell(ex.CellIndex.indexByString('L1'));
              // cell12.value = 'JOURNAL (CODE)'.toUpperCase();
              // // dynamic values support provided;
              // cell12.cellStyle = cellStyle;
              //________________________________________________________________
              for (Map r in resultats) {
                //
                //
                sheetObject.appendRow([
                  "${r['numero_de_compte']}",
                  "${r['intitule'] ?? ""}",
                  "",
                  "${r['cumul_debit']}",
                  "${r['cumul_credit']}",
                  "${r['solde_periode']}",
                  "${r['solde_periode']}",
                  // "${r['intitule']}",
                  // "${r['date_enregistrement']}",
                  // "${r['n_piece']}",
                  //"${r['numero_de_compte']}",
                ]);
                //
                //
              }

              //
              excel['SheetName'] = sheetObject;

// printing cell-type
              print('CellType: ' + cell1.cellType.toString());

              ///
              /// Inserting and removing column and rows

// insert column at index = 8
              sheetObject.insertColumn(8);

// remove column at index = 18
              sheetObject.removeColumn(18);

// insert row at index = 82
              sheetObject.insertRow(82);

// remove row at index = 80
              sheetObject.removeRow(80);
              excel.appendRow("sheet", []);
              //----------------------------------------------------------------
              String? outputFile = await FilePicker.platform.saveFile(
                  dialogTitle: 'Save Your File to desired location',
                  fileName:
                      "BALANCE - ${tout ? 'tous' : balance} - $titre.xlsx");

              try {
                //
                //final file = io.File("$outputFile");
                //----------------------------------------------------------------
                // when you are in flutter web then save() downloads the excel file.

                // Call function save() to download the file
                List<int>? fileBytes = excel.save(fileName: '$outputFile');
                //print("data: $outputFile");
                //print("data: ${fileBytes}");
                io.File("$outputFile")
                  ..createSync(recursive: true)
                  ..writeAsBytesSync(fileBytes!);
                //
                //await file.writeAsBytes(await pdf.save());
                //io.File returnedFile = io.File('$outputFile');
                //await returnedFile.writeAsString("Salut bro");
              } catch (e) {
                Get.snackbar("Erreur", "Un problème d'enregistrement ($e)");
              }
              //----------------------------------------------------------------
            },
            icon: SvgPicture.asset(
              "assets/Fa6SolidFileExcel.svg",
              colorFilter: ColorFilter.mode(Langi.base2, BlendMode.srcIn),

              //semanticsLabel: e["titre"],
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                return SizedBox(
                  height: 30,
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
                            "${r['cumul_debit'] == 0.00 ? '' : r['cumul_debit']}",
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
                            "${r['cumul_credit'] == 0.00 ? '' : r['cumul_credit']}",
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
                            "${r['solde_periode'] == 0.00 ? '' : r['solde_periode']}",
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
                            "${r['solde_periode'] == 0.00 ? '' : r['solde_periode']}",
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
    fontWeight: FontWeight.bold,
  );
}
