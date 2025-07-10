part of 'components.dart';

Widget patientIcon({String? gender, bool? sync}) {
  return Container(
    height: 70,
    width: 70,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color:
            sync == true
                ? Colors.blue
                : sync == false
                ? Colors.red
                : Colors.transparent,
        width: 2.5,
      ),
    ),
    child: Image.asset(
      gender == "female"
          ? 'assets/images/gender/female.png'
          : gender == 'male'
          ? 'assets/images/gender/male.png'
          : 'assets/images/paindre-logo.png',
    ),
  );
}

Widget textCard({required BuildContext context, String? title, void Function()? onTap}) {
  return Container(
    width: context.width,
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Text(title!, textAlign: TextAlign.center, style: context.textTheme.bodyMedium),
        if (onTap != null) const SizedBox(height: 5),
        if (onTap != null) ElevatedButton(onPressed: onTap, child: const Text("Buat", style: TextStyle(fontWeight: FontWeight.w400))),
      ],
    ),
  );
}

Widget patientCard(BuildContext context, {required Patient patient}) => GestureDetector(
  onTap: () => Get.toNamed(Routes.detailPatient, arguments: DetailPatientArguments(patient: patient)),
  child: Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [BoxShadow(color: Colors.grey[400]!, spreadRadius: 0.2, blurRadius: 4)],
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 2), child: patientIcon(gender: patient.gender, sync: true)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textKeyWithValue(context, key: '${'name'.tr}: ', value: patient.name),
                const SizedBox(height: 4),
                textKeyWithValue(context, key: '${'age'.tr}: ', value: patient.age),
                const SizedBox(height: 4),
                textKeyWithValue(context, key: '${'examinerName'.tr}: ', value: patient.responsiblePerson),
                const SizedBox(height: 4),
                textKeyWithValue(context, key: '${'dateExamined'.tr}: ', value: Utils.ymdFormat(dateTime: DateTime.tryParse(patient.createdAt))),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
