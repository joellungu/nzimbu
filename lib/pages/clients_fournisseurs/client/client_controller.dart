import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesClients() async {
    change([], status: RxStatus.loading());
    //
    List codes = box.read("clients") ?? [];
    //
    print("codes: $codes");
    //
    change(codes, status: RxStatus.success());
  }

//
  enregistrerClient(Map code) {
    //
    List codes = box.read("clients") ?? [];
    //
    codes.add(code);
    //
    box.write("clients", codes);
    //
    tousLesClients();
  }
}
