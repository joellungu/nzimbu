import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JournalController extends GetxController with StateMixin<List> {
//
  var box = GetStorage();
  //
  tousLesClients() async {
    change([], status: RxStatus.loading());
    //
    List journaux = box.read("journaux") ?? [];
    //
    print("journaux: $journaux");
    //
    change(journaux, status: RxStatus.success());
  }

//
  enregistrerClient(Map code) {
    //
    List journaux = box.read("journaux") ?? [];
    //
    journaux.add(code);
    //
    box.write("journaux", journaux);
    //
    tousLesClients();
  }
}
