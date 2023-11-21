import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nzimbu/pages/saisies/saisie_controller.dart';

class NouveauSaisie extends StatelessWidget {
  //
  Map e = {};
  //
  SaisieController controller = Get.find();
  //
  TextEditingController libelle2 = TextEditingController();
  TextEditingController montantDebit = TextEditingController();
  TextEditingController montantCredit = TextEditingController();
  TextEditingController intitule = TextEditingController();
  TextEditingController reference = TextEditingController();

  RxString date = "".obs;
  //
  int index;

  NouveauSaisie(this.e, this.index);
  //
  @override
  Widget build(BuildContext context) {
    //
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 50,
          padding: const EdgeInsets.all(3),
          alignment: Alignment.centerLeft,
          child: Text(" ${index + 1} "),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${e['compte']['numero_de_compte']}",
            style: entete,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "${e['libelle_enregistrement']}",
            style: entete,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${e['montant_debit']}",
            style: entete,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${e['montant_credit']}",
            style: entete,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${e['intitule']}",
            style: entete,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${e['date_echeance']}",
            style: entete,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${e['reference']}",
            style: entete,
          ),
        ),
        Container(
          width: 50,
          child: IconButton(
            onPressed: () {
              controller.DeletesaisieListe(index);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade700,
            ),
          ),
        ),
      ],
    );
  }

  //
  //
  TextStyle entete = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
}
