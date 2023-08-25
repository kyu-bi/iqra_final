import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iqra_app/data/models/hijaiyah.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HijaiyahController extends ChangeNotifier {
  List<Hijaiyah> allItem = [];

  Widget Loading() {
    return LoadingAnimationWidget.inkDrop(
        color: const Color(0xff900C3F), size: 50);
  }

  Future<List<Hijaiyah>> getAllItem() async {
    try {
      var response = await http.get(
          Uri.parse("https://81fa-140-213-127-31.ngrok-free.app/hijaiyah"));
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach((element) {
        allItem.add(Hijaiyah.fromJson(element));
      });
      return allItem; // Mengembalikan nilai allItem setelah data dimuat
    } catch (e) {
      print("Terjadi kesalahan");
      print(e);
      return []; // Mengembalikan list kosong jika terjadi kesalahan
    }
  }
}
