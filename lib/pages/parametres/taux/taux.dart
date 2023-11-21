import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Taux extends StatelessWidget {
  //
  var box = GetStorage();
  //
  TextEditingController usd_cdf = TextEditingController();
  TextEditingController usd_eur = TextEditingController();
  TextEditingController eur_cdf = TextEditingController();
  //
  Taux() {
    usd_cdf.text = box.read("usd_cdf") ?? "0.0";
    usd_eur.text = box.read("usd_eur") ?? "0.0";
    eur_cdf.text = box.read("eur_cdf") ?? "0.0";
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("USD", style: entete),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: TextField(
                      controller: usd_cdf,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("CDF", style: entete),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("USD", style: entete),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: TextField(
                      controller: usd_eur,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("EUR", style: entete),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("EUR", style: entete),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: TextField(
                      controller: eur_cdf,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("CDF", style: entete),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                //
                box.write("usd_cdf", usd_cdf.text);
                box.write("usd_eur", usd_eur.text);
                box.write("eur_cdf", eur_cdf.text);
                //
                Get.dialog(
                  const AlertDialog(
                    title: Text("Taux"),
                    content: Text("Fixation du taux éffectué"),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                child: const Text("ENREGISTRER"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  TextStyle entete =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
}
