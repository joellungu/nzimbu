import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompteController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesClients() async {
    change([], status: RxStatus.loading());
    //
    List comptes = box.read("comptes") ?? [];
    //
    print("comptes: $comptes");
    //
    change(comptes, status: RxStatus.success());
  }

//
  enregistrerClient(Map code) {
    //
    List codes = box.read("comptes") ?? [];
    //
    codes.add(code);
    //
    box.write("comptes", codes);
    //
    tousLesClients();
  }
}
