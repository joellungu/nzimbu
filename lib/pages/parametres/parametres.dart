import 'package:nzimbu/pages/parametres/code_comptable/code_comptable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comptes/comptes.dart';
import '../comptes/comptes_controller.dart';
import 'code_comptable/code_comptable_controller.dart';
import 'exercice_comptable/exercice_comptable.dart';
import 'exercice_comptable/exercice_comptable_controller.dart';
import 'taux/taux.dart';

class Parametres extends StatelessWidget {
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
              // Tab(
              //   child: Text("Codes comptable"),
              // ),
              // Tab(
              //   child: Text("Dossiers"),
              // ),
              Tab(
                child: Text("Taux"),
              ),
              Tab(
                child: Text("À propos"),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              children: [
                // CodeComptable(),
                // ExerciceComptable(),
                Taux(),
                Container(),
              ],
            ),
          )
        ]),
      ),
    );
  }
  //
}
