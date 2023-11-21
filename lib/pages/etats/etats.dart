import 'package:nzimbu/pages/etats/balance/balance.dart';
import 'package:nzimbu/pages/parametres/code_comptable/code_comptable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comptes/comptes.dart';
import '../comptes/comptes_controller.dart';
import '../journal/journal_filtre.dart';
import 'balance/filtre_balance.dart';
import 'grand_livre/filtre_grand_livre.dart';

class Etats extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    //
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(children: [
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text("Journals"),
              ),
              Tab(
                child: Text("Grand livre"),
              ),
              Tab(
                child: Text("Balance"),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              children: [
                JournalFiltre(),
                FiltreGrandLivre(),
                BalanceFiltre(),
              ],
            ),
          )
        ]),
      ),
    );
  }
  //
}
