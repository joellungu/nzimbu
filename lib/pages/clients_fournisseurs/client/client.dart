import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'client_controller.dart';
import 'nouveau_client.dart';

class Clients extends GetView<ClientController> {
  //
  var box = GetStorage();
  //
  Clients() {
    //
    controller.tousLesClients();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: controller.obx(
                (state) {
                  List clients = state!;
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
                                      List.generate(clients.length, (index) {
                                    Map client = clients[index];
                                    if ("${client['nom_contact']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase()) ||
                                        "${client['compte_defaut']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase()) ||
                                        "${client['raison_social']}"
                                            .toLowerCase()
                                            .contains(
                                                text.value.toLowerCase())) {
                                      return ListTile(
                                        //isThreeLine: true,
                                        //leading: Icon(Icons.person),
                                        title: Text(
                                            "${client['raison_social']} (${client['compte_defaut']})"),
                                        subtitle:
                                            Text("${client['nom_contact']}"),
                                        trailing: IconButton(
                                          onPressed: () {
                                            //
                                            clients.removeAt(index);
                                            box.write("clients", clients);
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
                        height: 800,
                        width: 1000,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: NouveauClient(),
                      ),
                    ),
                  ),
                  name: "Nouveau client",
                );
              },
              child: const Text("Ajouter un client"),
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
