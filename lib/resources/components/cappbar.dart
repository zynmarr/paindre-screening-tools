part of 'components.dart';

AppBar cAppBar({String title = "App Bar Title", List<Widget>? actions, bool centerTitle = false, Widget? leading}) {
  return AppBar(
    title: Text(title.toUpperCase(), style: Get.textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    backgroundColor: Colors.blue[900],
    excludeHeaderSemantics: true,
    automaticallyImplyLeading: false,
    centerTitle: centerTitle,
    leading: leading,
    actions: actions,
  );
}
