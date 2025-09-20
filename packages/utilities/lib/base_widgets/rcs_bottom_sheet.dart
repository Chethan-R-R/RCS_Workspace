import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:utilities/app_colors.dart';

import '../text_size.dart';
import '../utils.dart';
import 'common_widgets.dart';

const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

Future<T?> RcsModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color backgroundColor = AppColors.white,
  String? barrierLabel,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  double scrollControlDisabledMaxHeightRatio =
      _defaultScrollControlDisabledMaxHeightRatio,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool showDragHandle = false,
  bool useSafeArea = true,
  RouteSettings? routeSettings,
}) {
  /// A new key is generated for each bottom sheet to prevent key conflicts when multiple bottom sheets are used.
  var newKey = new GlobalKey<ScaffoldMessengerState>();

  ///A list of keys will be maintained and last one will be used to show snack bar.
  UI.bottomSheetScaffoldMessengerKeyList.add(newKey);

  return showModalBottomSheet(
    context: context,
    routeSettings: routeSettings,
    builder: (context) {
      Utils.updateOrientation(context);
      return ScaffoldMessenger(
          key: newKey,
          child: GestureDetector(
            onTap: () {
              if (isDismissible) {
                Navigator.pop(context);
              }
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.transparent,
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTapDown: (details) {},
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(Space.sp(25)))),
                      child: Stack(
                        // mainAxisSize: MainAxisSize.min,
                        alignment: Alignment.topCenter,
                        children: [
                          if (showDragHandle)
                            Container(
                              margin: EdgeInsets.only(top: Space.sp(10)),
                              width: Space.sp(40),
                              height: Space.sp(4),
                              decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius:
                                      BorderRadius.circular(Space.sp(25))),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: showDragHandle ? Space.sp(35) : 0),
                            child: builder(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
    },
    backgroundColor: AppColors.transparent,
    barrierLabel: barrierLabel,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    constraints:
        constraints ?? BoxConstraints(maxWidth: min(Utils.width, Utils.height)),
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    showDragHandle: false,
    useSafeArea: useSafeArea,
  ).then(
    (value) {
      ///Remove the key for the closed bottom sheet.
      UI.bottomSheetScaffoldMessengerKeyList.remove(newKey);
      return value;
    },
  );
}
