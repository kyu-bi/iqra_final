import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';
import 'package:iqra_app/data/models/detailhijaiyah.dart' as detail;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailHijaiyahController extends ChangeNotifier {
  int selectedHarkatIndex = 0; // Initialize with -1
  final AudioPlayer player = AudioPlayer();
  Widget Loading() {
    return LoadingAnimationWidget.inkDrop(
        color: const Color(0xff900C3F), size: 50);
  }

  void selectHarkat(int index) {
    selectedHarkatIndex = index;
    notifyListeners();
  }

  Future<detail.DetailHijaiyah> getDetailHijaiyah(String id) async {
    Uri url =
        Uri.parse("https://81fa-140-213-127-31.ngrok-free.app/hijaiyah/$id");
    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return detail.DetailHijaiyah.fromJson(data);
  }

  Future<void> playAudio(String url) async {
    final audioSource = LockCachingAudioSource(Uri.parse(url));
    await player.setAudioSource(audioSource);
    await player.play();
  }
}
