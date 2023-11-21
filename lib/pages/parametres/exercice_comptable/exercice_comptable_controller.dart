import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ExerciceComptableController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesCodes() async {
    change([], status: RxStatus.loading());
    //
    List exercices = box.read("exercices") ?? [];
    //
    print("codes: $exercices");
    //
    change(exercices, status: RxStatus.success());
  }

//
  enregistrerCode(Map code) {
    //
    List exercices = box.read("exercices") ?? [];
    //
    exercices.add(code);
    //
    box.write("exercices", exercices);
    //
    tousLesCodes();
  }
}
