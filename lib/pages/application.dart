import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/pages/accueil.dart';
import 'package:uuid/uuid.dart';
import 'dart:io' as io;
import 'parametres/exercice_comptable/exercice_comptable_controller.dart';

class Application extends GetView<ExerciceComptableController> {
  //
  var uuid = Uuid();
  //
  var box = GetStorage();
  //
  RxString exe = RxString("");

  String titre = "";
  //
  Application() {
    List exercices = box.read("exercices") ?? [];
    //
    controller.tousLesCodes();
    //"id": uuid.v4(),
    //exe.value = box.read("exercice") ?? "";
    //List exercices = box.read("exercices") ?? [];
    //

    //
    String exe = box.read("exercice") ?? "";
    setIdaTous(exe);
    setTauxUneFois(exe);
    //annee
    //label
    for (var element in exercices) {
      if (element["annee"] == exe) {
        titre = "${element["label"]} ${element["annee"]}";
        break;
      }
    }
    //
    //
  }
  //
  setIdaTous(String exercice) async {
    List saisies = box.read("saisies$exercice") ?? [];
    saisies.forEach((element) {
      element['id'] = uuid.v4();
    });
    //
    box.write("saisies$exercice", saisies);
  }

  //
  setTauxUneFois(String exercice) async {
    List saisies = box.read("saisies$exercice") ?? [];
    bool v = box.read("setTauxUneFois") ?? true;
    //
    String usd_cdf = box.read("usd_cdf") ?? "0.0";
    String usd_eur = box.read("usd_eur") ?? "0.0";
    String eur_cdf = box.read("eur_cdf") ?? "0.0";
    //
    if (v) {
      saisies.forEach((element) {
        element['usd_cdf'] = usd_cdf;
        element['usd_eur'] = usd_eur;
        element['eur_cdf'] = eur_cdf;
      });
      //
      box.write("saisies$exercice", saisies);
    }
    //
    box.write("setTauxUneFois", false);
    //
  }
  /**
   * usd_cdf.text = e['usd_cdf'] ?? 0.0;
    usd_eur.text = e['usd_eur'] ?? 0.0;
    eur_cdf.text = e['eur_cdf'] ?? 0.0;
   */

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Vos dossiers",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: controller.obx(
                        (state) {
                          List exercices = state!;
                          RxString text = "".obs;
                          RxBool pass = true.obs;
                          //
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  style: const TextStyle(fontSize: 10),
                                  onChanged: (t) {
                                    text.value = t;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Obx(
                                  () => pass.value
                                      ? ListView(
                                          padding: EdgeInsets.all(10),
                                          children: List.generate(
                                              exercices.length, (index) {
                                            Map exercice = exercices[index];
                                            if ("${exercice['annee']}"
                                                    .toLowerCase()
                                                    .contains(text.value
                                                        .toLowerCase()) ||
                                                "${exercice['label']}"
                                                    .toLowerCase()
                                                    .contains(text.value
                                                        .toLowerCase())) {
                                              //

                                              //
                                              return Obx(
                                                () => ListTile(
                                                  onTap: () {
                                                    //
                                                    bool v =
                                                        box.read("testfinal") ??
                                                            true;

                                                    //
                                                    box.write(
                                                        "testfinal", false);
                                                    //
                                                    box.write("exercice",
                                                        exercice['annee']);
                                                    //
                                                    exe.value =
                                                        box.read("exercice");
                                                    //
                                                    if (v) {
                                                      //
                                                      box.write(
                                                          "saisies$exercice",
                                                          []);
                                                      box.write("journaux", []);
                                                      box.write("comptes", []);
                                                    }
                                                    //
                                                    box.write(
                                                        "testfinal", false);
                                                    //
                                                    Get.offAll(const Accueil());
                                                  },
                                                  leading: exe ==
                                                          exercice['annee']
                                                      ? const Icon(
                                                          Icons.check_circle,
                                                          color: Colors.teal,
                                                        )
                                                      : Container(
                                                          height: 1,
                                                          width: 1,
                                                        ),
                                                  title: Text(
                                                      "${exercice['annee']}"),
                                                  subtitle: Text(
                                                      "${exercice['label']}"),
                                                  trailing: PopupMenuButton(
                                                      onSelected: (e) async {
                                                    if (e == 1) {
                                                      String? outputFile =
                                                          await FilePicker
                                                              .platform
                                                              .saveFile(
                                                                  dialogTitle:
                                                                      'Save Your File to desired location',
                                                                  fileName:
                                                                      "SAUVEGARDE - $titre.compta-pro");

                                                      try {
                                                        //
                                                        List saisies = box.read(
                                                                "saisies${exercice['annee']}") ??
                                                            [];
                                                        //
                                                        DateTime d =
                                                            DateTime.now();
                                                        //
                                                        String data =
                                                            jsonEncode({
                                                          "raison":
                                                              "Jesus-Christ est Seigneur à la Gloire de Dieu le Père",
                                                          "date":
                                                              "${d.day}-${d.month}-${d.year}",
                                                          "journaux": box
                                                              .read("journaux"),
                                                          "compte": box
                                                              .read("comptes"),
                                                          "exercice":
                                                              exercice['annee'],
                                                          "saisies": saisies
                                                        });
                                                        List<int> cc =
                                                            data.codeUnits;
                                                        List<int> cs = [];
                                                        for (var ee in cc) {
                                                          //
                                                          //cs.add(0);
                                                          cs.add(ee + 1);
                                                          //
                                                        }
                                                        //
                                                        print("data: $cs");
                                                        //
                                                        final file = io.File(
                                                            "$outputFile");
                                                        await file
                                                            .writeAsBytes(cs);
                                                        //io.File returnedFile = io.File('$outputFile');
                                                        //await returnedFile.writeAsString("Salut bro");
                                                      } catch (e) {
                                                        Get.snackbar("Erreur",
                                                            "Un problème d'enregistrement ($e)");
                                                      }
                                                    } else if (e == 2) {
                                                      try {
                                                        FilePickerResult? file =
                                                            await FilePicker
                                                                .platform
                                                                .pickFiles(
                                                          withData: true,
                                                          allowMultiple: false,
                                                        );
                                                        List<String?> reps =
                                                            file!.paths;
                                                        String? rep = reps[0];
                                                        List noms =
                                                            rep!.split('.');
                                                        print(
                                                            "rep: ${noms[noms.length - 1]}");
                                                        if (noms[noms.length -
                                                                1] ==
                                                            "compta-pro") {
                                                          print("Cool...");
                                                          PlatformFile cc =
                                                              file.files[0];
                                                          //print(
                                                          //  "bytes: ${cc.bytes}");
                                                          Uint8List? ccs =
                                                              cc.bytes;
                                                          List<int> vv = [];
                                                          ccs?.forEach(
                                                              (element) {
                                                            int d = element - 1;
                                                            vv.add(d);
                                                          });

                                                          String data = String
                                                              .fromCharCodes(
                                                                  vv);
                                                          //print("data: $vv");
                                                          print(String
                                                              .fromCharCodes(
                                                                  vv));

                                                          Map sauv =
                                                              jsonDecode(data);
                                                          print(
                                                              "annee: s:${sauv['exercice']} == e:${exercice['annee']}");
                                                          //
                                                          if ("${sauv['exercice']}" ==
                                                              "${exercice['annee']}") {
                                                            List saisieN = box.read(
                                                                    "saisies${exercice['annee']}") ??
                                                                [];
                                                            if (saisieN
                                                                .isEmpty) {
                                                              box.write(
                                                                  "saisies${exercice['annee']}",
                                                                  sauv[
                                                                      'saisies']);
                                                              //
                                                              box.write(
                                                                  "journaux",
                                                                  sauv[
                                                                      "journaux"]);
                                                              //_____________________
                                                              box.write(
                                                                  "compte",
                                                                  sauv[
                                                                      "comptes"]);
                                                              //_____________________
                                                              Get.snackbar(
                                                                  "Succès",
                                                                  "Sauvegarde importé avec succès",
                                                                  backgroundColor:
                                                                      Colors
                                                                          .teal,
                                                                  colorText:
                                                                      Colors
                                                                          .white);
                                                            } else {
                                                              Get.snackbar(
                                                                "Erreur",
                                                                "Il existe déjà sauvegarde pour cette exercice! Vous resquez d'écraser ces informations",
                                                                backgroundColor:
                                                                    Colors.red
                                                                        .shade700,
                                                                colorText:
                                                                    Colors
                                                                        .white,
                                                              );
                                                            }
                                                          } else {
                                                            //
                                                            Get.snackbar(
                                                              "Erreur",
                                                              "Date de cette sauvegarde ne correspond pas",
                                                              backgroundColor:
                                                                  Colors.red
                                                                      .shade700,
                                                              colorText:
                                                                  Colors.white,
                                                            );
                                                          }
                                                        } else {
                                                          print("Pas cool");
                                                          Get.snackbar(
                                                            "Erreur",
                                                            "Ce fichier n'est pas une sauvegarde",
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade700,
                                                            colorText:
                                                                Colors.white,
                                                          );
                                                        }
                                                      } catch (e) {
                                                        //
                                                        print(e);
                                                        //
                                                        Get.snackbar(
                                                          "Erreur",
                                                          "Un problème est survenu lors de l'ouverture du fichier",
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade700,
                                                          colorText:
                                                              Colors.white,
                                                        );
                                                      }
                                                    } else {
                                                      box.write(
                                                          "saisies${exercice['annee']}",
                                                          null);
                                                    }
                                                    //
                                                  }, itemBuilder: (c) {
                                                    return [
                                                      const PopupMenuItem(
                                                        value: 1,
                                                        child:
                                                            Text("Sauvegarder"),
                                                      ),
                                                      const PopupMenuItem(
                                                        value: 2,
                                                        child: Text(
                                                            "Restauration"),
                                                      ),
                                                      const PopupMenuItem(
                                                        value: 3,
                                                        child:
                                                            Text("Supprimer"),
                                                      ),
                                                    ];
                                                  }
                                                      // trailing: IconButton(
                                                      //   onPressed: () {
                                                      //     //
                                                      //     exercices.removeAt(index);
                                                      //     box.write("exercices",
                                                      //         exercices);
                                                      //     controller.tousLesCodes();
                                                      //     //
                                                      //   },
                                                      //   icon: Icon(
                                                      //     Icons.delete,
                                                      //     color:
                                                      //         Colors.red.shade700,
                                                      //   ),
                                                      // ),
                                                      ),
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }),
                                        )
                                      : Container(),
                                ),
                              )
                            ],
                          );
                        },
                        onEmpty: Container(),
                        onLoading: const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //
                        TextEditingController textCode =
                            TextEditingController();
                        TextEditingController labelCode =
                            TextEditingController();
                        //
                        Get.dialog(
                          Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Container(
                                height: 300,
                                width: 300,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Align(
                                      alignment: Alignment.topCenter,
                                      child: Text("Nouveau dossier"),
                                    ),
                                    TextField(
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      controller: textCode,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Annee",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      controller: labelCode,
                                      decoration: InputDecoration(
                                        labelText: "Label",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //
                                              Map code = {
                                                "annee": textCode.text,
                                                "label": labelCode.text,
                                              };
                                              //
                                              controller.enregistrerCode(code);
                                              //
                                              Get.back();
                                              //
                                            },
                                            child: const Text("Enregistrer"),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //
                                              Get.back();
                                              //
                                            },
                                            child: Text(
                                              "Annuler",
                                              style: TextStyle(
                                                  color: Colors.red.shade700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          name: "Ajouter un dossier",
                        );
                      },
                      child: const Text("Ajouter un dossier"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     //
      //     var exercice = box.read("exercice") ?? "";
      //     List balances = [];
      //     box.write("saisies$exercice", null);
      //   },
      //   child: Icon(Icons.class_rounded),
      // ),
    );
  }
}
