// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iqra_app/constant/font_color.dart';
import 'package:provider/provider.dart';
import 'package:iqra_app/modules/detailhijaiyah/controller/detail_huruf_controller.dart';
import 'package:iqra_app/data/models/detailhijaiyah.dart' as detail;

class DetailHuruf extends StatelessWidget {
  int id;
  DetailHuruf({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      appBar: AppBar(
        title: const Text("Detail Huruf"),
        titleTextStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w900, fontFamily: "Beachday"),
        backgroundColor: bluegrey,
      ),
      body: ChangeNotifierProvider(
        create: (context) => DetailHijaiyahController(),
        child: Consumer<DetailHijaiyahController>(
          builder: (context, detailHijaiyahC, _) {
            return FutureBuilder<detail.DetailHijaiyah>(
              future: detailHijaiyahC.getDetailHijaiyah(id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: bluegrey,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
                detail.DetailHijaiyah detailHijaiyah = snapshot.data!;
                List<detail.Harkat> harkats = detailHijaiyah.harkats;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 9.5,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Positioned(
                          //   bottom: 0,
                          //   child: Opacity(
                          //     opacity: 0.5,
                          //     child: Image.asset(

                          //       "assets/img/detail1.png",
                          //       width: 100,
                          //       fit: BoxFit.contain,
                          //     ),
                          //   ),
                          // ),
                          if (detailHijaiyahC.selectedHarkatIndex != -1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 150,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/huruf1.png"))),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "${harkats[detailHijaiyahC.selectedHarkatIndex].tulisan_latin}",
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/huruf1.png"))),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "${harkats[detailHijaiyahC.selectedHarkatIndex].tulisan_arab}",
                                        style: const TextStyle(
                                            fontSize: 50,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(23),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: harkats.asMap().entries.map((entry) {
                          int index = entry.key;
                          detail.Harkat harkat = entry.value;

                          return ElevatedButton(
                            onPressed: () {
                              detailHijaiyahC.selectHarkat(index);
                              // detailHijaiyahC.playAudio(harkat.audio);
                            },
                            child: Text(
                              "${harkat.harkat}",
                              style: TextStyle(
                                color:
                                    detailHijaiyahC.selectedHarkatIndex == index
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  detailHijaiyahC.selectedHarkatIndex == index
                                      ? Colors.white
                                      : bluegrey,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 9.5,
                              )
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            // gradient: LinearGradient(colors: [
                            //   bluegrey,
                            //   Color(0xffa7c4d2),
                            // ]),
                            color: bluegrey),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Cara Pengucapan",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${detailHijaiyah.pengucapan}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                "Contoh Pengucapan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              IconButton(
                                onPressed: () {
                                  detailHijaiyahC.playAudio(
                                      "https://ba6b-103-190-47-99.ngrok-free.app${harkats[detailHijaiyahC.selectedHarkatIndex].audio}");
                                  print(
                                      "https://ba6b-103-190-47-99.ngrok-free.app${harkats[detailHijaiyahC.selectedHarkatIndex].audio}");
                                },
                                icon: const Icon(
                                  Icons.play_circle,
                                  color: Colors.white,
                                ),
                                iconSize: 80,
                              ),
                              Text(
                                "Putar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
