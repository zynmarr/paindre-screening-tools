part of 'components.dart';

AppBar cAppBar(BuildContext context, {String? title, List<Widget>? actions, bool centerTitle = false, Widget? leading}) {
  return AppBar(
    title: title != null
        ? Text(
            title.toUpperCase(),
            style: context.textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        : null,
    backgroundColor: Colors.blue[900],
    excludeHeaderSemantics: true,
    automaticallyImplyLeading: false,
    centerTitle: centerTitle,
    leading: leading,
    actions: actions,
  );
}
