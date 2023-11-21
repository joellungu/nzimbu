import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VentesController extends GetxController {
  //
  var box = GetStorage();
  //
  tousLesAchats() async {
    //
    String exercice = box.read("exercice") ?? "";
    //
    List ventes = box.read("ventes$exercice") ?? [];
    //
    print("ventes: $ventes");
    //
  }

//
  enregistrerAchats(Map code) {
    //
    String exercice = box.read("exercice") ?? "";
    //
    List codes = box.read("ventes$exercice") ?? [];
    //
    codes.add(code);
    //
    box.write("ventes$exercice", codes);
    //
    tousLesAchats();
  }
}
