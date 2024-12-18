import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class CreatePatientPage extends StatefulWidget {
  const CreatePatientPage({super.key});

  @override
  State<CreatePatientPage> createState() => _CreatePatientPageState();
}

class _CreatePatientPageState extends State<CreatePatientPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController ageC = TextEditingController();
  TextEditingController phoneC = TextEditingController(text: '0');
  TextEditingController genderC = TextEditingController();
  TextEditingController resPersonC = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode genderFocus = FocusNode();
  FocusNode resPersonFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: Size(context.width, context.height / 2.6),
              painter: RPSCustomPainter(),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: cAppBar(
            //   context,
            //   title: "Tambah Pasien Baru",
            //   centerTitle: true,
            //   leading: GestureDetector(
            //     onTap: () => Get.back(),
            //     child: Icon(
            //       MdiIcons.chevronLeft,
            //       size: 20,
            //     ),
            //   ),
            // ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      width: context.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Create new patient'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: context.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Lengkap",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4)),
                              TextFormField(
                                controller: nameC,
                                focusNode: nameFocus,
                                style: context.textTheme.bodyMedium,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama lengkap tidak boleh kosong';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: cInputDecoration(context,
                                    hintText: 'Masukkan nama lengkap'),
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Umur",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                              ),
                              TextFormField(
                                controller: ageC,
                                focusNode: ageFocus,
                                style: context.textTheme.bodyMedium,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Umur tidak boleh kosong';
                                  } else if (value.isNumericOnly) {
                                    return null;
                                  } else {
                                    return 'Umur harus angka';
                                  }
                                },
                                decoration: cInputDecoration(context,
                                    hintText: 'Masukkan Umur'),
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No Telepon",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                              ),
                              TextFormField(
                                controller: phoneC,
                                focusNode: phoneFocus,
                                style: context.textTheme.bodyMedium,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  } else {
                                    if (value.isNumericOnly) {
                                      return null;
                                    } else {
                                      return 'No telepon harus angka';
                                    }
                                  }
                                },
                                decoration: cInputDecoration(context,
                                    hintText: 'Masukkan no telepon'),
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jenis Kelamin",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                              ),
                              DropdownButtonFormField(
                                value: genderC.text,
                                dropdownColor: Colors.white,
                                items: [
                                  DropdownMenuItem(
                                      value: '',
                                      child: Text('Pilih jenis kelamin',
                                          style: context.textTheme.bodyMedium)),
                                  DropdownMenuItem(
                                      value: 'male',
                                      child: Text('Laki',
                                          style: context.textTheme.bodyMedium)),
                                  DropdownMenuItem(
                                      value: 'female',
                                      child: Text('Perempuan',
                                          style: context.textTheme.bodyMedium)),
                                ],
                                validator: (value) {
                                  if (value == '') {
                                    return 'Pilih jenis kelamin';
                                  }
                                  return null;
                                },
                                decoration: cInputDecoration(context,
                                    hintText: "Jenis Kelamin"),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      genderC.text = val;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Pemeriksa",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4)),
                              TextFormField(
                                controller: resPersonC,
                                focusNode: resPersonFocus,
                                style: context.textTheme.bodyMedium,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama pemeriksa tidak boleh kosong';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: cInputDecoration(context,
                                    hintText: 'Masukkan nama pemeriksa'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  SizedBox(
                    width: context.width / 3,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          cDialog(
                            context,
                            middleText: "Apakah anda yakin menyimpan data ini?",
                            onSucces: () {
                              Get.back();
                              Patient data = Patient(
                                  id: "1",
                                  name: nameC.text,
                                  age: ageC.text,
                                  gender: genderC.text,
                                  phone: phoneC.text,
                                  responsiblePerson: resPersonC.text,
                                  createdAt: DateTime.now().toString());

                              PatientController().create(data).then(
                                    (value) => Get.offNamed(
                                      'question-page',
                                      arguments: {
                                        'questioName': 'Nyeri Nosiseptif',
                                        'id_patient': value.id
                                      },
                                    ),
                                  );
                            },
                            onCancel: () => Get.back(),
                          );
                        }
                      },
                      child: Text(
                        'Simpan'.toUpperCase(),
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0008083, size.height * 0.6668000);
    path_0.quadraticBezierTo(size.width * 0.0883083, size.height * 0.4908917,
        size.width * 0.2094333, size.height * 0.5242083);
    path_0.cubicTo(
        size.width * 0.3584667,
        size.height * 0.5569583,
        size.width * 0.3254833,
        size.height * 0.3965750,
        size.width * 0.4970917,
        size.height * 0.2371417);
    path_0.cubicTo(
        size.width * 0.5751000,
        size.height * 0.1720167,
        size.width * 0.6197083,
        size.height * 0.2181083,
        size.width * 0.7156833,
        size.height * 0.2309167);
    path_0.cubicTo(
        size.width * 0.8009250,
        size.height * 0.2538917,
        size.width * 0.7792667,
        size.height * 0.2206167,
        size.width * 0.8350833,
        size.height * 0.1545583);
    path_0.quadraticBezierTo(size.width * 0.8976583, size.height * 0.0880500,
        size.width, size.height * 0.0822000);
    path_0.lineTo(size.width * 1.0008333, size.height * 1.0016667);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.9983333);
    path_0.lineTo(size.width * -0.0008083, size.height * 0.6668000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      // ..color = Colors.green
      ..shader = ui.Gradient.linear(
        Offset(size.width / 1, 2),
        Offset(0, size.height / 1.4),
        [
          const Color.fromARGB(255, 20, 112, 187),
          Colors.blue[800]!,
        ],
      )
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0002250, size.height * 0.2984600);
    path_0.quadraticBezierTo(
        size.width * -0.0002250, size.height * 0.8617100, 0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.quadraticBezierTo(size.width * 1.0008333, size.height * 0.3357500,
        size.width * 1.0008333, size.height * 0.0980000);
    path_0.cubicTo(
        size.width * 0.8303833,
        size.height * 0.0811500,
        size.width * 0.6094583,
        size.height * 0.0033600,
        size.width * 0.4998500,
        size.height * 0.1008400);
    path_0.cubicTo(
        size.width * 0.3566167,
        size.height * 0.2435400,
        size.width * 0.3990000,
        size.height * 0.2509500,
        size.width * -0.0002250,
        size.height * 0.2984600);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(204, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
