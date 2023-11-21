import 'package:excel/excel.dart' as ex;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/utils/langi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io' as io;

import 'apercu_grand_livre.dart';

class GrandLivre extends StatelessWidget {
  int index;
  List resultats;

  String dateDepart;
  String dateFin;
  String devise;
  //
  var box = GetStorage();
  String titre = "";

  GrandLivre(
      this.index, this.resultats, this.dateDepart, this.dateFin, this.devise) {
    String exe = box.read("exercice") ?? "";
    //
    List exercices = box.read("exercices") ?? [];
    //
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
                        ],
                      );
                    });
                  },
                ),
              );
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
              cell1.value = ''.toUpperCase();
              // dynamic values support provided;
              cell1.cellStyle = cellStyle;
              //
              var cell2 = sheetObject.cell(ex.CellIndex.indexByString('B1'));
              cell2.value = 'JOURNAL'.toUpperCase();
              // dynamic values support provided;
              cell2.cellStyle = cellStyle;
              //
              var cell3 = sheetObject.cell(ex.CellIndex.indexByString('C1'));
              cell3.value = 'DATE'.toUpperCase();
              // dynamic values support provided;
              cell3.cellStyle = cellStyle;
              //
              var cell4 = sheetObject.cell(ex.CellIndex.indexByString('D1'));
              cell4.value = 'N° de pièce'.toUpperCase();
              // dynamic values support provided;
              cell4.cellStyle = cellStyle;
              //
              var cell5 = sheetObject.cell(ex.CellIndex.indexByString("E1"));
              cell5.value = "Libellé de l'écriture".toUpperCase();
              //cell5.value = 8; // dynamic values support provided;
              cell5.cellStyle = cellStyle;
              //
              var cell6 = sheetObject.cell(ex.CellIndex.indexByString('F1'));
              cell6.value = ''.toUpperCase();
              // dynamic values support provided;
              cell6.cellStyle = cellStyle;
              //
              var cell7 = sheetObject.cell(ex.CellIndex.indexByString('G1'));
              cell7.value = 'Montant Débit'.toUpperCase();
              // dynamic values support provided;
              cell7.cellStyle = cellStyle;
              //
              var cell8 = sheetObject.cell(ex.CellIndex.indexByString('H1'));
              cell8.value = ''.toUpperCase();
              // dynamic values support provided;
              cell8.cellStyle = cellStyle;
              //
              var cell9 = sheetObject.cell(ex.CellIndex.indexByString('I1'));
              cell9.value = 'Montant Crédit'.toUpperCase();
              // dynamic values support provided;
              cell9.cellStyle = cellStyle;
              //
              var cell10 = sheetObject.cell(ex.CellIndex.indexByString('J1'));
              cell10.value = 'Solde Cumulé'.toUpperCase();
              // dynamic values support provided;
              cell10.cellStyle = cellStyle;
              //
              //
              var cell11 = sheetObject.cell(ex.CellIndex.indexByString('K1'));
              cell11.value = 'JOURNAL (INT.)'.toUpperCase();
              //cell9.value = 8; // dynamic values support provided;
              cell11.cellStyle = cellStyle;
              //
              var cell12 = sheetObject.cell(ex.CellIndex.indexByString('L1'));
              cell12.value = 'JOURNAL (CODE)'.toUpperCase();
              // dynamic values support provided;
              cell12.cellStyle = cellStyle;
              //________________________________________________________________
              for (Map r in resultats) {
                List.generate(r['ssis'].length, (index) {
                  Map s = r['ssis'][index];
                  //
                  double credit = s['montant_credit'].isNotEmpty
                      ? double.parse(s['montant_credit'])
                      : 0;
                  //
                  sheetObject.appendRow([
                    "",
                    "${s['journale']['code']} (${s['journale']['code']})",
                    "${s['date_enregistrement']}",
                    "${s['n_piece']}",
                    "${s['libelle_enregistrement']}",
                    "",
                    "${s['montant_debit']}",
                    "",
                    "${s['montant_credit']}",
                    "",
                    "${debit - credit}",
                    "${r['intitule']}",
                    "${r['numero_de_compte']}",
                  ]);
                  //
                });
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
                  fileName: "GRANDLIVRE - $titre.xlsx");

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
    );
  }

  //
  TextStyle entete = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  //
  pw.TextStyle entete1 = pw.TextStyle(
    fontSize: 7,
    fontWeight: pw.FontWeight.normal,
  );
}
