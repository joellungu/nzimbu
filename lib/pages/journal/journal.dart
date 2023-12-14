import 'package:nzimbu/pages/comptes/nouveau_compte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'journal_controller.dart';
import 'nouveau_journal.dart';

class Journal extends GetView<JournalController> {
  //
  var box = GetStorage();
  //
  Journal() {
    //
    controller.tousLesClients();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: SizedBox(
        width: 700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: controller.obx(
                (state) {
                  List comptes = state!;
                  RxString text = "".obs;
                  RxBool pass = true.obs;
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
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.grey.shade300,
                                  //color: Colors.amber,
                                  child: const Text("Code"),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.grey.shade300,
                                  //color: Colors.red,
                                  child: const Text("Sigle"),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.grey.shade300,
                                  //color: Colors.yellow,
                                  child: const Text("Intitulé"),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.grey.shade300,
                                  child: const Text("Type de journal"),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  //
                                  //
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () => pass.value
                              ? ListView(
                                  padding: const EdgeInsets.all(10),
                                  children:
                                      List.generate(comptes.length, (index) {
                                    Map compte = comptes[index];
                                    if ("${compte['intitule']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase()) ||
                                        "${compte['type']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase())) {
                                      return Card(
                                        elevation: 0,
                                        child: Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  //color: Colors.amber,
                                                  child: Text(
                                                      "${compte['sg'] ?? ''}"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  //color: Colors.red,
                                                  child:
                                                      Text("${compte['code']}"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  //color: Colors.yellow,
                                                  child: Text(
                                                      "${compte['intitule']}"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  //color: Colors.blue,
                                                  child:
                                                      Text("${compte['type']}"),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  //
                                                  controller.supprimer(
                                                      index,
                                                      "${compte['intitule']}",
                                                      comptes);
                                                  //
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      return ListTile(
                                        //isThreeLine: true,
                                        //leading: Icon(Icons.person),
                                        title: Text("${compte['intitule']}"),
                                        subtitle: Text(
                                          "${compte['type']} // ${compte['code']}",
                                          style: const TextStyle(
                                            color: Colors.teal,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            //
                                            comptes.removeAt(index);
                                            box.write("comptes", comptes);
                                            controller.tousLesClients();
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
                Get.dialog(
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        height: 400,
                        width: 600,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: NouveauJournal(),
                      ),
                    ),
                  ),
                  name: "Créer journal",
                );
              },
              child: const Text("Créer journal"),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
  //
}
