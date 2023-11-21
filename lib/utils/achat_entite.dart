class AchatEntite {
  late double totalF;
  late String date_enregistrement;
  late String taux;
  late String taux_montant;
  late int solder;
  late String exercice;
  late Map fournisseur;
  late String date_facture;
  late String date_echeance;
  late String reference;
  late String note;
  late List produits_services;
  //
  AchatEntite({
    required this.totalF,
    required this.date_enregistrement,
    required this.taux,
    required this.taux_montant,
    required this.solder,
    required this.exercice,
    required this.fournisseur,
    required this.date_facture,
    required this.date_echeance,
    required this.reference,
    required this.note,
    required this.produits_services,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalF': totalF,
      'date_enregistrement': date_enregistrement,
      'taux': taux,
      'taux_montant': taux_montant,
      'solder': solder,
      'exercice': exercice,
      'fournisseur': fournisseur,
      'date_facture': date_facture,
      'date_echeance': date_echeance,
      'reference': reference,
      'note': note,
      'produits_services': produits_services,
    };
  }
}
