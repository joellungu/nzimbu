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

import 'apercu_journal.dart';

class JournalFiltreResultat extends StatelessWidget {
  int index;
  List resultats;

  String dateDepart;
  String dateFin;
  String devise;
  bool tout;
  //
  //
  String journal;
  //
  var box = GetStorage();
  String titre = "";
  //

  JournalFiltreResultat(
    this.index,
    this.resultats,
    this.dateDepart,
    this.dateFin,
    this.devise,
    this.tout,
    this.journal,
  ) {
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
    //
    resultats.forEach((e) {
      //
      if (e['date_enregistrement'] != null) {
        List dates = e['date_enregistrement'].split("-");
        String d = dates[1];
        //
        filtre.add(d);
      }
    });
    //
    filtre.forEach((d) {
      //

      //
      resultats.forEach((r) {
        //
        if (r['date_enregistrement'] != null) {
          List dff = r['date_enregistrement'].split("-");
          String df = dff[1];
          // ignore: unrelated_type_equality_checks
          print("filtre: $d == $df :: ${d == df && (df == "1" || df == "01")}");

          if (d == df && (df == "1" || df == "01")) {
            //debitTotal//creditTotal//
            jDebit = jDebit + r['debitTotal'];
            jCredit = jCredit + r['creditTotal'];
            //
            listJ.add(r);
            //
          } //
          if (d == df && (df == "2" || df == "02")) {
            //
            fDebit = fDebit + r['debitTotal'];
            fCredit = fCredit + r['creditTotal'];
            //
            listF.add(r);
          } //
          if (d == df && (df == "3" || df == "03")) {
            //
            mDebit = mDebit + r['debitTotal'];
            mCredit = mCredit + r['creditTotal'];
            //
            listM.add(r);
          } //
          if (d == df && (df == "4" || df == "04")) {
            //
            aDebit = aDebit + r['debitTotal'];
            aCredit = aCredit + r['creditTotal'];
            //
            listA.add(r);
          } //
          if (d == df && (df == "5" || df == "05")) {
            //
            maDebit = maDebit + r['debitTotal'];
            maCredit = maCredit + r['creditTotal'];
            //
            listMa.add(r);
          } //
          if (d == df && (df == "6" || df == "06")) {
            //
            juDebit = juDebit + r['debitTotal'];
            juCredit = juCredit + r['creditTotal'];
            //
            listJu.add(r);
          } //
          if (d == df && (df == "7" || df == "07")) {
            //
            jiDebit = jiDebit + r['debitTotal'];
            jiCredit = jiCredit + r['creditTotal'];
            //
            listJi.add(r);
          } //
          if (d == df && (df == "8" || df == "08")) {
            //
            oDebit = oDebit + r['debitTotal'];
            oCredit = oCredit + r['creditTotal'];
            //
            listO.add(r);
          } //
          if (d == df && (df == "9" || df == "09")) {
            //
            sDebit = sDebit + r['debitTotal'];
            sCredit = sCredit + r['creditTotal'];
            //
            listS.add(r);
          } //
          if (d == df && (df == "10" || df == "10")) {
            //
            ocDebit = ocDebit + r['debitTotal'];
            ocCredit = ocCredit + r['creditTotal'];
            //
            listOc.add(r);
          } //
          if (d == df && (df == "11" || df == "11")) {
            //
            nDebit = nDebit + r['debitTotal'];
            nCredit = nCredit + r['creditTotal'];
            //
            listN.add(r);
          } //
          if (d == df && (df == "12" || df == "12")) {
            //
            dDebit = dDebit + r['debitTotal'];
            dCredit = dCredit + r['creditTotal'];
            //
            listD.add(r);
          } //
          // if (d == d && (d == "12" || d == "12")) {
          //   //
          //   dDebit = dDebit + r['debitTotal'];
          //   dCredit = dCredit + r['creditTotal'];
          //   //
          //   listJ.add(r);
          // } //
        }
      });
    });
    //
    longueur = resultats.length * 5;
    print("le total vaut: ${resultats.length} // $longueur");
  }
  //
  double debit = 0;
  //________________________________
  //
  double jDebit = 0;
  double jCredit = 0;
  List listJ = [];

  //
  double fDebit = 0;
  double fCredit = 0;
  List listF = [];
  //
  double mDebit = 0;
  double mCredit = 0;
  List listM = [];
  //
  double aDebit = 0;
  double aCredit = 0;
  List listA = [];
  //
  double maDebit = 0;
  double maCredit = 0;
  List listMa = [];
  //
  double juDebit = 0;
  double juCredit = 0;
  List listJu = [];
  //
  double jiDebit = 0;
  double jiCredit = 0;
  List listJi = [];
  //
  double oDebit = 0;
  double oCredit = 0;
  List listO = [];
  //
  double sDebit = 0;
  double sCredit = 0;
  List listS = [];
  //
  double ocDebit = 0;
  double ocCredit = 0;
  List listOc = [];
  //
  double nDebit = 0;
  double nCredit = 0;
  List listN = [];
  //
  double dDebit = 0;
  double dCredit = 0;
  List listD = [];
  //____________________________
  Set filtre = {};
  //____________________________
  int longueur = 0;

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
              final pdf = pw.Document();

              pw.Widget vue = pw.Column(
                children: [
                  //List.generate(filtre.toList().length, (index) {
                  //  List l = filtre.toList();
                  //String d = l[index];
                  //
                  listJ.isNotEmpty
                      ? pw.Column(
                          children: [
                            pwGetVue(listJ),
                            pwGrandTotal(jDebit, jCredit, "JANVIER")
                          ],
                        )
                      : pw.Container(),
                  //
                  listF.isNotEmpty
                      ? pw.Column(
                          children: [
                            pwGetVue(listF),
                            pwGrandTotal(fDebit, fCredit, "FEVRIER")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listM.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listM),
                            pwGrandTotal(mDebit, mCredit, "MARS")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listA.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listA),
                            pwGrandTotal(aDebit, aCredit, "AVRIL")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listMa.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listMa),
                            pwGrandTotal(maDebit, maCredit, "MAI")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listJu.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listJu),
                            pwGrandTotal(juDebit, juCredit, "JUIN")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listJi.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listJi),
                            pwGrandTotal(jiDebit, jiCredit, "JUILLET")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listO.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listO),
                            pwGrandTotal(oDebit, oCredit, "AOUT")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listS.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listS),
                            pwGrandTotal(sDebit, sCredit, "SEPTEMBRE")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listOc.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listOc),
                            pwGrandTotal(ocDebit, ocCredit, "OCTOBRE")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listN.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listN),
                            pwGrandTotal(nDebit, nCredit, "NOVEMBRE")
                          ],
                        )
                      : pw.Container(),
                  //
                  (listD.isNotEmpty)
                      ? pw.Column(
                          children: [
                            pwGetVue(listD),
                            pwGrandTotal(dDebit, dCredit, "DECEMBRE")
                          ],
                        )
                      : pw.Container(),
                  //
                ],
              );

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
                  maxPages: longueur,
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
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text("Journal: ${js ?? 'Tous'}"
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
                    return [
                      //List.generate(filtre.toList().length, (index) {
                      //  List l = filtre.toList();
                      //String d = l[index];
                      //
                      pwGetVue(listJ),
                      listJ.isNotEmpty
                          ? pwGrandTotal(jDebit, jCredit, "JANVIER")
                          : pw.Container(),
                      //
                      pwGetVue(listF),
                      listF.isNotEmpty
                          ? pwGrandTotal(fDebit, fCredit, "FEVRIER")
                          : pw.Container(),
                      //
                      pwGetVue(listM),
                      listM.isNotEmpty
                          ? pwGrandTotal(mDebit, mCredit, "MARS")
                          : pw.Container(),
                      //
                      pwGetVue(listA),
                      listA.isNotEmpty
                          ? pwGrandTotal(aDebit, aCredit, "AVRIL")
                          : pw.Container(),
                      //
                      pwGetVue(listMa),
                      listMa.isNotEmpty
                          ? pwGrandTotal(maDebit, maCredit, "MAI")
                          : pw.Container(),
                      //
                      pwGetVue(listJu),
                      listJu.isNotEmpty
                          ? pwGrandTotal(juDebit, juCredit, "JUIN")
                          : pw.Container(),
                      //
                      pwGetVue(listJi),
                      listJi.isNotEmpty
                          ? pwGrandTotal(jiDebit, jiCredit, "JUILLET")
                          : pw.Container(),
                      //
                      pwGetVue(listO),
                      listO.isNotEmpty
                          ? pwGrandTotal(oDebit, oCredit, "AOUT")
                          : pw.Container(),
                      //
                      pwGetVue(listS),
                      listS.isNotEmpty
                          ? pwGrandTotal(sDebit, sCredit, "SEPTEMBRE")
                          : pw.Container(),
                      //
                      pwGetVue(listOc),
                      listOc.isNotEmpty
                          ? pwGrandTotal(ocDebit, ocCredit, "OCTOBRE")
                          : pw.Container(),
                      //
                      pwGetVue(listN),
                      listN.isNotEmpty
                          ? pwGrandTotal(nDebit, nCredit, "NOVEMBRE")
                          : pw.Container(),
                      //
                      pwGetVue(listD),
                      listD.isNotEmpty
                          ? pwGrandTotal(dDebit, dCredit, "DECEMBRE")
                          : pw.Container(),
                      //
                    ];
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
                  dialogTitle: 'Sauvegarder votre fichier',
                  fileName:
                      "JOURNAL - ${tout ? 'tous' : journal} - $titre.pdf");

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
              cell1.value = 'JL'.toUpperCase();
              // dynamic values support provided;
              cell1.cellStyle = cellStyle;
              //
              var cell2 = sheetObject.cell(ex.CellIndex.indexByString('B1'));
              cell2.value = 'Date écheance'.toUpperCase();
              // dynamic values support provided;
              cell2.cellStyle = cellStyle;
              //
              var cell3 = sheetObject.cell(ex.CellIndex.indexByString('C1'));
              cell3.value = 'N° de compte'.toUpperCase();
              // dynamic values support provided;
              cell3.cellStyle = cellStyle;
              //
              var cell4 = sheetObject.cell(ex.CellIndex.indexByString('D1'));
              cell4.value = 'Intitulé du compte'.toUpperCase();
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
              cell7.value = 'Debit'.toUpperCase();
              // dynamic values support provided;
              cell7.cellStyle = cellStyle;
              //
              var cell8 = sheetObject.cell(ex.CellIndex.indexByString('H1'));
              cell8.value = 'Crédit'.toUpperCase();
              // dynamic values support provided;
              cell8.cellStyle = cellStyle;
              //
              var cell9 = sheetObject.cell(ex.CellIndex.indexByString('I1'));
              cell9.value = 'Intitulé'.toUpperCase();
              // dynamic values support provided;
              cell9.cellStyle = cellStyle;
              //
              var cell10 = sheetObject.cell(ex.CellIndex.indexByString('J1'));
              cell10.value = "Date d'ecriture".toUpperCase();
              // dynamic values support provided;
              cell10.cellStyle = cellStyle;
              //
              //
              var cell11 = sheetObject.cell(ex.CellIndex.indexByString('K1'));
              cell11.value = 'N° piece'.toUpperCase();
              //cell9.value = 8; // dynamic values support provided;
              cell11.cellStyle = cellStyle;
              //
              // var cell12 = sheetObject.cell(ex.CellIndex.indexByString('L1'));
              // cell12.value = 'JOURNAL (CODE)'.toUpperCase();
              // // dynamic values support provided;
              // cell12.cellStyle = cellStyle;
              //________________________________________________________________
              for (Map r in resultats) {
                List.generate(r['jrs'].length, (index) {
                  Map s = r['jrs'][index];
                  //
                  double credit = s['montant_credit_'];

                  //
                  sheetObject.appendRow([
                    "${s['journale']['type']}",
                    "${s['date_echeance'] ?? ""}",
                    "${s['compte']['numero_de_compte']}",
                    "${s['compte']['intitule']}",
                    "${s['libelle_enregistrement']}",
                    "",
                    "${s['montant_debit_']}",
                    "${s['montant_credit_']}",
                    "${r['intitule']}",
                    "${r['date_enregistrement']}",
                    "${r['n_piece']}",
                    //"${r['numero_de_compte']}",
                  ]);
                  //
                });
                //
              }

              //
              excel['JOURNAUX'] = sheetObject;

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
                      "JOURNAUX - ${tout ? 'tous' : journal} - $titre.xlsx");

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
            child: Container(
              alignment: Alignment.topCenter,
              //color: Colors.teal,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //List.generate(filtre.toList().length, (index) {
                    //  List l = filtre.toList();
                    //String d = l[index];
                    //
                    listJ.isNotEmpty
                        ? Column(
                            children: [
                              getVue(listJ),
                              GrandTotal(jDebit, jCredit, "JANVIER")
                            ],
                          )
                        : Container(),
                    //
                    listF.isNotEmpty
                        ? Column(
                            children: [
                              getVue(listF),
                              GrandTotal(fDebit, fCredit, "FEVRIER")
                            ],
                          )
                        : Container(),
                    //
                    (listM.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listM),
                              GrandTotal(mDebit, mCredit, "MARS")
                            ],
                          )
                        : Container(),
                    //
                    (listA.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listA),
                              GrandTotal(aDebit, aCredit, "AVRIL")
                            ],
                          )
                        : Container(),
                    //
                    (listMa.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listMa),
                              GrandTotal(maDebit, maCredit, "MAI")
                            ],
                          )
                        : Container(),
                    //
                    (listJu.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listJu),
                              GrandTotal(juDebit, juCredit, "JUIN")
                            ],
                          )
                        : Container(),
                    //
                    (listJi.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listJi),
                              GrandTotal(jiDebit, jiCredit, "JUILLET")
                            ],
                          )
                        : Container(),
                    //
                    (listO.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listO),
                              GrandTotal(oDebit, oCredit, "AOUT")
                            ],
                          )
                        : Container(),
                    //
                    (listS.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listS),
                              GrandTotal(sDebit, sCredit, "SEPTEMBRE")
                            ],
                          )
                        : Container(),
                    //
                    (listOc.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listOc),
                              GrandTotal(ocDebit, ocCredit, "OCTOBRE")
                            ],
                          )
                        : Container(),
                    //
                    (listN.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listN),
                              GrandTotal(nDebit, nCredit, "NOVEMBRE")
                            ],
                          )
                        : Container(),
                    //
                    (listD.isNotEmpty)
                        ? Column(
                            children: [
                              getVue(listD),
                              GrandTotal(dDebit, dCredit, "DECEMBRE")
                            ],
                          )
                        : Container(),
                    //
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getVue(List resultats) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        resultats.length,
        (index) {
          Map r = resultats[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              r['date_enregistrement'] != null
                  ? Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      height: 25,
                      child: Text("${r['intitule'] ?? ''}"),
                    )
                  : Container(),
              r['date_enregistrement'] != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      height: 25,
                      child: r['date_enregistrement'] != null
                          ? Text(
                              "Date d'écriture: ${r['date_enregistrement'] ?? ''} Piece N° ${r['n_piece'] ?? ''}")
                          : const Text(""),
                    )
                  : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  r['jrs'].length,
                  (index) {
                    //return Text("Salut");
                    Map s = r['jrs'][index];
                    double mnt1 = s['montant_debit_'];
                    mnt1.toStringAsFixed(2);
                    //
                    double mnt2 = s['montant_credit_'];
                    mnt2.toStringAsFixed(2);
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
                                s['montant_debit_'] != 0.00
                                    ? s['montant_debit_'].toStringAsFixed(2)
                                    : "",
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
                                s['montant_credit_'] != 0.00
                                    ? s['montant_credit_'].toStringAsFixed(2)
                                    : "",
                                style: entete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              r['date_enregistrement'] != null
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      height: 25,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              //color: Colors.grey.shade300,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: Text(
                                r['debitTotal'] != 0.00
                                    ? "${r['debitTotal'].toStringAsFixed(2)}"
                                    : "",
                                style: entete,
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            //color: Colors.black,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              //color: Colors.grey.shade300,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: Text(
                                r['creditTotal'] != 0.00
                                    ? "${r['creditTotal'].toStringAsFixed(2)}"
                                    : "",
                                style: entete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget GrandTotal(double debit, double credit, String mois) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      height: 25,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              //color: Colors.grey.shade300,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Text(
                "GRAND TOTAL $mois",
                style: entete,
              ),
            ),
          ),
          Container(
            width: 2,
            //color: Colors.black,
          ),
          Expanded(
            flex: 3,
            child: Container(
              //color: Colors.grey.shade300,
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
            //color: Colors.black,
          ),
          Expanded(
            flex: 3,
            child: Container(
              //color: Colors.grey.shade300,
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
            //color: Colors.black,
          ),
          Expanded(
            flex: 1,
            child: Container(
              //color: Colors.grey.shade300,
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
            //color: Colors.black,
          ),
          Expanded(
            flex: 2,
            child: Container(
              //color: Colors.grey.shade300,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Text(
                "$debit",
                style: entete,
              ),
            ),
          ),
          Container(
            width: 2,
            //color: Colors.black,
          ),
          Expanded(
            flex: 2,
            child: Container(
              //color: Colors.grey.shade300,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Text(
                "$credit",
                style: entete,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //_____________________________
  pw.Container pwGrandTotal(double debit, double credit, String mois) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: PdfColors.teal,
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
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Container(
              //color: Colors.grey.shade300,
              width: double.maxFinite,
              height: double.maxFinite,
              child: pw.Text(
                "GRAND TOTAL $mois",
                style: entete1,
              ),
            ),
          ),
          pw.Container(
            width: 2,
            //color: Colors.black,
          ),
          pw.Expanded(
            flex: 3,
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
            width: 2,
            //color: Colors.black,
          ),
          pw.Expanded(
            flex: 3,
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
            //color: Colors.black,
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
            width: 2,
            //color: Colors.black,
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              //color: Colors.grey.shade300,
              width: double.maxFinite,
              height: double.maxFinite,
              child: pw.Text(
                "$debit",
                style: entete1,
              ),
            ),
          ),
          pw.Container(
            width: 2,
            //color: Colors.black,
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              //color: Colors.grey.shade300,
              width: double.maxFinite,
              height: double.maxFinite,
              child: pw.Text(
                "$credit",
                style: entete1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Column pwGetVue(List resultats) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: List.generate(
        resultats.length,
        (index) {
          Map r = resultats[index];
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              r['date_enregistrement'] != null
                  ? pw.Container(
                      padding: const pw.EdgeInsets.only(left: 10),
                      alignment: pw.Alignment.centerLeft,
                      height: 25,
                      child: pw.Text("${r['intitule'] ?? ''}"),
                    )
                  : pw.Container(),
              r['date_enregistrement'] != null
                  ? pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      padding: const pw.EdgeInsets.only(left: 10),
                      height: 25,
                      child: r['date_enregistrement'] != null
                          ? pw.Text(
                              "Date d'écriture: ${r['date_enregistrement'] ?? ''} Piece N° ${r['n_piece'] ?? ''}")
                          : pw.Text(""),
                    )
                  : pw.Container(),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: List.generate(
                  r['jrs'].length,
                  (index) {
                    //return Text("Salut");
                    Map s = r['jrs'][index];
                    double mnt1 = s['montant_debit_'];
                    mnt1.toStringAsFixed(2);
                    //
                    double mnt2 = s['montant_credit_'];
                    mnt2.toStringAsFixed(2);
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
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
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
                                "${s['date_echeance'] ?? ""}",
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
                                "${s['compte']['numero_de_compte']}",
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
                              //color: Colors.grey.shade300,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                "${s['compte']['intitule']}",
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
                                s['montant_debit_'] != 0.00
                                    ? s['montant_debit_'].toStringAsFixed(2)
                                    : "",
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
                                s['montant_credit_'] != 0.00
                                    ? s['montant_credit_'].toStringAsFixed(2)
                                    : "",
                                style: entete1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              r['date_enregistrement'] != null
                  ? pw.Container(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.green,
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
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              //color: Colors.grey.shade300,
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
                            //color: Colors.black,
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
                            width: 2,
                            //color: Colors.black,
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
                            width: 2,
                            //color: Colors.black,
                          ),
                          pw.Expanded(
                            flex: 3,
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
                            width: 2,
                            //color: Colors.black,
                          ),
                          pw.Expanded(
                            flex: 3,
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
                            //color: Colors.black,
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
                            width: 2,
                            //color: Colors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              //color: Colors.grey.shade300,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                r['debitTotal'] != 0.00
                                    ? "${r['debitTotal'].toStringAsFixed(2)}"
                                    : "",
                                style: entete1,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 2,
                            //color: Colors.black,
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              //color: Colors.grey.shade300,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: pw.Text(
                                r['creditTotal'] != 0.00
                                    ? "${r['creditTotal'].toStringAsFixed(2)}"
                                    : "",
                                style: entete1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : pw.Container(),
            ],
          );
        },
      ),
    );
  }

  //_____________________________

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

/**
 *   Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              height: 25,
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //color: Colors.grey.shade300,
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
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //color: Colors.grey.shade300,
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
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //color: Colors.grey.shade300,
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
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      //color: Colors.grey.shade300,
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
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      //color: Colors.grey.shade300,
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
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //color: Colors.grey.shade300,
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
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      //color: Colors.grey.shade300,
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      child: Text(
                                        r['debitTotal'] != 0.00
                                            ? "${r['debitTotal'].toStringAsFixed(2)}"
                                            : "",
                                        style: entete,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    //color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      //color: Colors.grey.shade300,
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      child: Text(
                                        r['creditTotal'] != 0.00
                                            ? "${r['creditTotal'].toStringAsFixed(2)}"
                                            : "",
                                        style: entete,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          
 */
