import 'package:weather_app_demo/utils/config.dart';

class UiSpacer {
  static Widget hSpace([double space = 20]) =>
      SizedBox(width: space.toDouble());
  static Widget vSpace([double space = 20]) =>
      SizedBox(height: space.toDouble());

  //space between widgets vertically
  static Widget verticalSpace({double space = 20}) => SizedBox(height: space);

  //space between widgets horizontally
  static Widget horizontalSpace({double space = 20}) => SizedBox(width: space);
  static Widget smHorizontalSpace({double space = 5}) => SizedBox(width: space);

  static Widget formVerticalSpace({double space = 15}) =>
      SizedBox(height: space);

  static Widget emptySpace() => const SizedBox(width: 0, height: 0);
  static Widget expandedSpace() => const Expanded(
        child: SizedBox.shrink(),
      );

  static Widget divider({double height = 1, double thickness = 1}) => Divider(
        height: height,
        thickness: thickness,
      );

  static Widget swipeIndicator() => Center(
      child: SizedBox(
          width: 40,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const Divider(height: 16, thickness: 4))));
}
