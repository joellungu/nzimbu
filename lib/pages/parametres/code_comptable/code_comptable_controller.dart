import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CodeComptableController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesCodes() async {
    change([], status: RxStatus.loading());
    //
    List codes = box.read("codes") ?? [];
    //
    print("codes: $codes");
    //
    change(codes, status: RxStatus.success());
  }

//
  enregistrerCode(Map code) {
    //
    List codes = box.read("codes") ?? [];
    //
    codes.add(code);
    //
    box.write("codes", codes);
    //
    tousLesCodes();
  }
}
