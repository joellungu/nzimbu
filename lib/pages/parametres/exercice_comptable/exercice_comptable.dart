import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'exercice_comptable_controller.dart';

class ExerciceComptable extends GetView<ExerciceComptableController> {
  //
  var box = GetStorage();
  //
  RxString exe = RxString("");
  //
  ExerciceComptable() {
    //
    controller.tousLesCodes();
    //
    exe.value = box.read("exercice") ?? "";
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Center(
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
                                    children: List.generate(exercices.length,
                                        (index) {
                                      Map exercice = exercices[index];
                                      if ("${exercice['annee']}"
                                              .toLowerCase()
                                              .contains(
                                                  text.value.toLowerCase()) ||
                                          "${exercice['label']}"
                                              .toLowerCase()
                                              .contains(
                                                  text.value.toLowerCase())) {
                                        //

                                        //
                                        return Obx(
                                          () => ListTile(
                                            onTap: () {
                                              //
                                              box.write("exercice",
                                                  exercice['annee']);
                                              //
                                              exe.value = box.read("exercice");
                                            },
                                            leading: exe == exercice['annee']
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.teal,
                                                  )
                                                : Container(
                                                    height: 1,
                                                    width: 1,
                                                  ),
                                            title: Text("${exercice['annee']}"),
                                            subtitle:
                                                Text("${exercice['label']}"),
                                            trailing: IconButton(
                                              onPressed: () {
                                                //
                                                exercices.removeAt(index);
                                                box.write(
                                                    "exercices", exercices);
                                                controller.tousLesCodes();
                                                //
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade700,
                                              ),
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
                  TextEditingController textCode = TextEditingController();
                  TextEditingController labelCode = TextEditingController();
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text("Nouveau code comptable"),
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
                                            BorderRadius.circular(10))),
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
                                    borderRadius: BorderRadius.circular(10),
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
                    name: "Nouvelle exercice",
                  );
                },
                child: const Text("Ajouter un exercice"),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
}
