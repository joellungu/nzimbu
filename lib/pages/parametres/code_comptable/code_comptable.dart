import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'code_comptable_controller.dart';

class CodeComptable extends GetView<CodeComptableController> {
  //
  var box = GetStorage();
  //
  CodeComptable() {
    //
    controller.tousLesCodes();
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
                    List codes = state!;
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
                                    children:
                                        List.generate(codes.length, (index) {
                                      Map code = codes[index];
                                      if ("${code['code']}"
                                              .toLowerCase()
                                              .contains(
                                                  text.value.toLowerCase()) ||
                                          "${code['label']}"
                                              .toLowerCase()
                                              .contains(
                                                  text.value.toLowerCase())) {
                                        return ListTile(
                                          title: Text("${code['code']}"),
                                          subtitle: Text("${code['label']}"),
                                          trailing: IconButton(
                                            onPressed: () {
                                              //
                                              codes.removeAt(index);
                                              box.write("codes", codes);
                                              controller.tousLesCodes();
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
                                    labelText: "Code",
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                          "code": textCode.text,
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
                    name: "Nouveau un code",
                  );
                },
                child: const Text("Nouveau un code"),
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
