import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/scoring_result/scoring_result.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class DetailPatientPage extends StatefulWidget {
  const DetailPatientPage({super.key});

  @override
  State<DetailPatientPage> createState() => _DetailPatientPageState();
}

class _DetailPatientPageState extends State<DetailPatientPage> {
  String idPatient = Get.arguments['id_patient'];

  // late Patient? item;

  List<String> listScoringResult = [];
  String textResult =
      "Tidak ditemukan nyeri specifik, mohon lakukan pemeriksaan ulang kembali.";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cAppBar(
        context,
        title: "Informasi Pasien",
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            MdiIcons.chevronLeft,
            size: 20,
          ),
        ),
      ),
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: cGradient(context),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              StreamBuilder(
                  stream:
                      PatientController().patients.doc(idPatient).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Utils.paindreShowLoading();
                      Utils.errorToast(
                          message: "Terjadi kesalahan, silahkan coba lagi");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      Utils.paindreShowLoading();
                    }

                    if (snapshot.hasData) {
                      BotToast.closeAllLoading();

                      Patient patient = Patient.fromMap(
                          snapshot.data!.data() as Map<String, dynamic>);

                      return Container(
                        width: context.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!,
                              spreadRadius: 0.2,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textKeyWithValue(context,
                                key: "Nama: ", value: patient.name),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3)),
                            textKeyWithValue(context,
                                key: "Umur: ", value: "${patient.age} Tahun"),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3)),
                            textKeyWithValue(context,
                                key: "Jenis Kelamin: ",
                                value: patient.gender == 'male'
                                    ? 'Laki'
                                    : 'Perempuan'),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3)),
                            textKeyWithValue(context,
                                key: "Nomor Telepon: ", value: patient.phone),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3)),
                            textKeyWithValue(context,
                                key: "Pemeriksa: ",
                                value: patient.responsiblePerson),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3)),
                            textKeyWithValue(context,
                                key: "Waktu Pemeriksaan: ",
                                value: Utils.ymdFormat(
                                    dateTime:
                                        DateTime.tryParse(patient.createdAt))),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3)),
                            StreamBuilder(
                              stream: ScoringResultController()
                                  .scoringResults
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }

                                if (snapshot.hasData) {
                                  return textKeyWithValue(
                                    context,
                                    key: "Hasil Pemeriksaan: ",
                                    maxLines: 3,
                                    value: snapshot.data!.docs
                                        .where(
                                            (p) => p['id_patient'] == idPatient)
                                        .map((p) => ScoringResult.fromMap(p
                                                .data() as Map<String, dynamic>)
                                            .type)
                                        .toString(),
                                  );
                                } else {
                                  return textKeyWithValue(context,
                                      key: "Hasil Pemeriksaan: ",
                                      maxLines: 3,
                                      value: textResult);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
              SizedBox(
                width: context.width,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  onPressed: () => cDialog(
                    context,
                    title: "Pemberitahuan",
                    middleText: "Apakah anda yakin ingin menghapus data ini?",
                    onSucces: () async {
                      // await context
                      //     .read<PatientController>()
                      //     .delete(item)
                      //     .then((value) {
                      //   Get.offAllNamed('home-page');
                      // });
                    },
                    onCancel: () async {
                      Get.back();
                    },
                  ),
                  child: Text(
                    'Hapus',
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
