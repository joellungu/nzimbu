import 'package:get_storage/get_storage.dart';
import 'package:nzimbu/pages/journal/journal_filtre_resultat.dart';
import 'package:nzimbu/pages/saisies/saisie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nzimbu/utils/langi.dart';
import 'bilan/bilan.dart';
import 'compte_resultat.dart/compte_resultat.dart';
import 'comptes/comptes.dart';
import 'comptes/comptes_controller.dart';
import 'etats/balance/balance.dart';
import 'etats/etats.dart';
import 'etats/grand_livre/apercu_grand_livre.dart';
import 'journal/apercu_journal.dart';
import 'journal/journal.dart';
import 'parametres/code_comptable/code_comptable_controller.dart';
import 'parametres/exercice_comptable/exercice_comptable_controller.dart';
import 'parametres/parametres.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> with TickerProviderStateMixin {
  late final TabController _tabController;
  //
  //

  //

  //
  //
  // HoraireController horaireController = Get.put(HoraireController());
  // //
  // InfosController infosController = Get.put(InfosController());
  // //
  // LiveController liveController = Get.put(LiveController());
  // //
  // NiveauController niveauController = Get.put(NiveauController());
  //
  //Horaire//Calendrier//Evenement//Utilisateur//Infos//Live/
  Rx<Widget> vue = Rx(Comptes()); //
  RxInt choix = 0.obs;
  //"Encaissement", "Décaissement"
  List angles = [
    {"titre": "Liste de comptes", "icon": "CarbonPiggyBankSlot"},
    {"titre": "Journals", "icon": "CarbonPiggyBankSlot"},
    {"titre": "Saisie", "icon": "CarbonPiggyBankSlot"},
    //{"titre": "Banque", "icon": "IcBaselineDoorBack"},
    //{"titre": "Op. diverses", "icon": "PhCalendarCheckFill"},
    {"titre": "Etats", "icon": "JamNewspaperF"},

    {"titre": "Parametres", "icon": "PhUserDuotone"},
    // {"titre": "Etat", "icon": "BasilBookOpenSolid"},
    // {"titre": "Clients & Fournisseurs", "icon": "IonPeople"},
    // {"titre": "Parametres", "icon": "SolarSettingsMinimalisticBold"},
  ];
  //
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Langi.base1,
      child: SafeArea(
        child: Scaffold(
          body: Obx(() => vue.value),
          bottomNavigationBar: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(angles.length, (index) {
                Map e = angles[index];
                return InkWell(
                  onTap: () {
                    //
                    choix.value = index;
                    //
                    if (choix.value == 0) {
                      vue.value = Comptes();
                    } else if (choix.value == 1) {
                      vue.value = Journal();
                    } else if (choix.value == 2) {
                      vue.value = Saisie();
                    } else if (choix.value == 3) {
                      vue.value = Etats();
                    } else if (choix.value == 4) {
                      vue.value = Parametres();
                    } else if (choix.value == 5) {
                      vue.value = Bilan();
                    } else {
                      vue.value = Parametres();
                    }
                  },
                  child: Obx(
                    () => SizedBox(
                      //flex: 1,
                      //width: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/${e["icon"]}.svg",
                            colorFilter: index == choix.value
                                ? ColorFilter.mode(Langi.base2, BlendMode.srcIn)
                                : const ColorFilter.mode(
                                    Colors.grey, BlendMode.srcIn),
                            semanticsLabel: e["titre"],
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            e["titre"],
                            style: TextStyle(
                              fontSize: 10,
                              color: index == choix.value
                                  ? Langi.base2
                                  : Colors.grey,
                              fontWeight: index == choix.value
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
