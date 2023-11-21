import 'package:flutter/material.dart';

class SaisiEntite extends DataRow {
  int? index;
  String? libelle;
  String? numeroDeCompte;
  double? montantDebit;
  double? montantCredit;
  String? dateEcheance;
  String? reference;
  String? intitule;

  SaisiEntite({required super.cells});
}
