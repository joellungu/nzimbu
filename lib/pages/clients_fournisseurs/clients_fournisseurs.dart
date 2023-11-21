import 'package:nzimbu/pages/clients_fournisseurs/client/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client/client_controller.dart';
import 'fournisseur/fournisseur.dart';
import 'fournisseur/fournisseur_controller.dart';

class ClientsFournisseurs extends StatelessWidget {
  //
  ClientController clientController = Get.put(ClientController());
  //
  FournisseurController fournisseurController =
      Get.put(FournisseurController());
  //
  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(children: [
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text("Clients"),
              ),
              Tab(
                child: Text("Fournisseurs"),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              children: [
                Clients(),
                Fournisseurs(),
              ],
            ),
          )
        ]),
      ),
    );
  }
  //
}
