import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FournisseurController extends GetxController with StateMixin<List> {
  //
  var box = GetStorage();
  //
  tousLesFournisseurs() async {
    change([], status: RxStatus.loading());
    //
    List codes = box.read("fournisseurs") ?? [];
    //
    print("codes: $codes");
    //
    change(codes, status: RxStatus.success());
  }

//
  enregistrerClient(Map code) {
    //
    List codes = box.read("fournisseurs") ?? [];
    //
    codes.add(code);
    //
    box.write("fournisseurs", codes);
    //
    tousLesFournisseurs();
  }
}
