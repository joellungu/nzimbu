import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CaisseController extends GetxController {
  //
  var box = GetStorage();
  //
  tousLesAchats(String nomCaisse) async {
    //
    String exercice = box.read("exercice") ?? "";
    //
    List caisses = box.read("$nomCaisse$exercice") ?? [];
    //
    print("caisses: $caisses");
    //
  }

  enregistrerCaisseEntite(Map code) {
    //
    List codes = box.read("caisseentite") ?? [];
    //
    codes.add(code);
    //
    box.write("caisseentite", codes);
    //
  }

//
  enregistrerAchats(Map code, String nomCaisse) {
    //
    String exercice = box.read("exercice") ?? "";
    //
    List caisses = box.read("$nomCaisse$exercice") ?? [];
    //
    caisses.add(code);
    //
    box.write("$nomCaisse$exercice", caisses);
    //
    tousLesAchats(nomCaisse);
  }
}
