import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AchatsController extends GetxController {
  //
  var box = GetStorage();
  //
  //
  tousLesAchats() async {
    //
    String exercice = box.read("exercice") ?? "";
    //
    List achats = box.read("achats$exercice") ?? [];
    //
    print("codes: $achats");
    //
  }

//
  enregistrerAchats(Map code) {
    //
    String exercice = box.read("exercice") ?? "";
    //
    List codes = box.read("achats$exercice") ?? [];
    //
    codes.add(code);
    //
    box.write("achats$exercice", codes);
    //
    tousLesAchats();
  }
}
