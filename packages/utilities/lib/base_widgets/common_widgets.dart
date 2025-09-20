import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:utilities/extensions/extension_load_asset_image.dart';
import 'package:utilities/network_utility/app_connectivity.dart';
import 'package:utilities/text_size.dart';
import 'package:utilities/utils.dart';

import '../app_colors.dart';
import '../app_images.dart';
import '../strings.dart';
import 'coomon_error_widget.dart';
import 'rcs_bottom_sheet.dart';
import 'rcs_text_widget.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Common widgets used across the applications
 */
class UI {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<ScaffoldMessengerState> bottomSheetScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static List<GlobalKey<ScaffoldMessengerState>>
      bottomSheetScaffoldMessengerKeyList = [];

  static Widget getCommonHeaderBackground({required Widget child}) {
    bool isPortrait = Utils.orientation == Orientation.portrait;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: isPortrait ? Alignment.topCenter : Alignment.centerLeft,
          end: isPortrait ? Alignment.bottomCenter : Alignment.centerRight,
          colors: const [
            AppColors.loginGradientTop,
            AppColors.loginGradientBottom
          ],
        ),
        image: DecorationImage(
            opacity: 0.1,
            image: AppImages.loginBackground.loadImageProviderAsset(),
            // fit: BoxFit.cover,
            repeat: ImageRepeat.repeat),
      ),
      child: child,
    );
  }

  static Widget getCommonTitleText(String title, {int maxLine = 2}) {
    return RcsText(
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      title.trim(),
      size: TextSize.setSp(14),
      // fontWeight: FontWeight.w800,
      color: AppColors.black,
    );
  }

  static Widget getCommonBodyBackground(
      {required Widget child,
      Color colors = AppColors.commonBodyBackgroundColor,
      bool maxHeightRequired = true}) {
    return Container(
      width: double.maxFinite,
      height: maxHeightRequired ? double.maxFinite : null,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: colors,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          image: DecorationImage(
              colorFilter: const ColorFilter.mode(
                  AppColors.loginGradientTop, BlendMode.modulate),
              opacity: 0.15,
              image: AppImages.loginBackground.loadImageProviderAsset(),
              // fit: BoxFit.cover,
              repeat: ImageRepeat.repeat)),
      child: child,
    );
  }


  static Widget getNoData() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          child: Center(
            child: SizedBox(
              height: Utils.height,
              child: AppImages.appNoData.loadAsset(),
            ),
          ),
        ),
      ],
    );
  }




  static Widget getCommonBackIcon(BuildContext context,
      {Function? callback, Color color = Colors.white, FocusNode? nextFocus}) {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.transparent),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child:           InkWell(
          focusColor: AppColors.transparent,
          onTap: () {
            _commonBackIconClick(callback, context);
          },
          child: Padding(
            padding: Utils.isTv
                ? EdgeInsets.all(Space.sp(4))
                : EdgeInsets.all(Space.sp(10)),
            child: Icon(
              Icons.arrow_back,
              color: color,
              size: Space.sp(20),
            ),
          ),
        ),
      ),
    );
  }

  static void _commonBackIconClick(Function? callback, BuildContext context) {
    if (callback == null) {
      Navigator.pop(context);
    } else {
      callback.call();
    }
  }

  static Widget getCommonToolbar(BuildContext context, String title,
      {Function? callback,
      Color iconColor = AppColors.white,
      Color textColor = AppColors.whiteTextColor,
      Widget? tailIcon}) {
    return SizedBox(
        height: Space.sp(50),
        child: Row(
          children: <Widget>[
            getCommonBackIcon(context, color: iconColor, callback: callback),
            Expanded(
                child: getCommonToolbarHeaderText(title, color: textColor)),
            if (tailIcon != null) tailIcon
          ],
        ));
  }

  static Widget getCommonToolbarHeaderText(String text,
      {Color color = AppColors.whiteTextColor}) {
    return RcsText(
      text,
      size: TextSize.setSp(16),
      fontWeight: FontWeight.w400,
      color: color,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }


  static showSnackBar(BuildContext context, String message,
      {int duration = 2500, bool removeCurrentSnackBar = false}) {
    if (bottomSheetScaffoldMessengerKeyList.isNotEmpty &&
        bottomSheetScaffoldMessengerKeyList.last.currentState != null) {
      if (removeCurrentSnackBar) {
        bottomSheetScaffoldMessengerKeyList.last.currentState
            ?.removeCurrentSnackBar();
      }
      return bottomSheetScaffoldMessengerKeyList.last.currentState!
          .showSnackBar(
        _snackBar(message, duration),
      );
    } else {
      if (removeCurrentSnackBar) {
        scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
      }
      scaffoldMessengerKey.currentState!.showSnackBar(
        _snackBar(message, duration),
      );
    }
  }

  static SnackBar _snackBar(String message, int duration) => SnackBar(
        padding: EdgeInsets.symmetric(
            vertical: Space.sp(20), horizontal: Space.sp(5)),
        content: RcsText(message,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            size: TextSize.setSp(16),
            color: AppColors.white),
        duration: Duration(milliseconds: duration),
        backgroundColor: AppColors.darkGrey.withValues(alpha: 0.95),
        behavior: SnackBarBehavior.floating,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      );


  static showGlobalSnackBar(BuildContext context, String message,
      {int duration = 2500}) {
    scaffoldMessengerKey.currentState!
        .showSnackBar(_snackBar(message, duration));
  }




  static Widget getNoNetworkView(Function? callback,
      {bool isRetry = true,
      bool showCloseButton = false,
      BuildContext? context,
      bool isBottomSheet = true}) {
    final FocusNode retryFocusNode = FocusNode();
    final FocusNode closeFocusNode = FocusNode();
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Space.sp(8), Space.sp(8), Space.sp(8), Space.sp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Utils.height > Utils.width
                ? Utils.height * 0.2
                : Utils.height * 0.3,
            width: Utils.width * 0.9,
            child: AppImages.appNoInternet.loadAsset(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Space.sp(20), top: Space.sp(10)),
            child: RcsText(
              Strings.appNoNetworkText,
              size: TextSize.setSp(16),
              fontWeight: FontWeight.bold,
              color: AppColors.blackTextColor,
              textAlign: TextAlign.center,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            if (showCloseButton)
              UI.updatedOutlinedTextButtonWithMinWidth(
                focusNode: closeFocusNode,
                autoFocus: true,
                Strings.appCloseText, // Conditional text
                () {
                  if (context != null) Navigator.pop(context);
                },
              ),
            /*SizedBox(width: Space.sp(5)),*/
            UI.updatedFilledTextButtonWithMinWidth(
              focusNode: retryFocusNode,
              isRetry
                  ? Strings.appRetryText
                  : Strings.appOkText, // Conditional text
              () {
                if (AppConnectivity().isConnected) {
                  if (isBottomSheet && context != null) Navigator.pop(context);
                  callback?.call();
                }
              },
            ),
          ]),
        ],
      ),
    );
  }



  static Widget getServerErrorView(Function? callback,
      {String buttonTitle = Strings.appRetryText,
      bool showCloseButton = false,
      BuildContext? context,
      bool isBottomSheet = false}) {
    final FocusNode closeFocusNode = FocusNode();
    final FocusNode okFocusNode = FocusNode();
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Space.sp(8), Space.sp(8), Space.sp(8), Space.sp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Utils.height > Utils.width
                ? Utils.height * 0.15
                : Utils.height * 0.3,
            width: Utils.width * 0.9,
            child: AppImages.appServerError.loadAsset(),
          ),
          RcsText(
            Strings.serverErrorText1,
            size: TextSize.setSp(19),
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: Utils.width * 0.95,
            child: Padding(
              padding: EdgeInsets.only(bottom: Space.sp(11)),
              child: RcsText(
                Strings.serverErrorText2,
                size: TextSize.setSp(13),
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          /*Padding(
            padding: EdgeInsets.only(bottom: Space.sp(20), top: Space.sp(10)),
            child: EsText(
              Strings.forgotPasswordServerErrorText,
              size: TextSize.setSp(16),
              fontWeight: FontWeight.bold,
              color: AppColors.blackTextColor,
              textAlign: TextAlign.center,
            ),
          ),*/
          // UI.updatedFilledTextButtonWithMinWidth(buttonTitle, () {
          //   callback?.call();
          // }),

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            if (showCloseButton)
              UI.updatedOutlinedTextButtonWithMinWidth(
                focusNode: closeFocusNode,
                autoFocus: true,
                Strings.appCloseText, // Conditional text
                () {
                  if (context != null) Navigator.pop(context);
                },
              ),
            /*SizedBox(width: Space.sp(5)),*/
            UI.updatedFilledTextButtonWithMinWidth(
              focusNode: okFocusNode,
              buttonTitle, // Conditional text
              () {
                if (AppConnectivity().isConnected) {
                  if (isBottomSheet && context != null) Navigator.pop(context);
                  callback?.call();
                }
              },
            ),
          ])
        ],
      ),
    );
  }



  static Widget getLogInNameInputField(TextEditingController controller,
      {bool enabled = true,
      FocusNode? focusNode,
      FocusNode? nextFocusNode,
      required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Space.sp(10), Space.sp(10), Space.sp(10), Space.sp(10)),
      child: TextField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        autofocus: true,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._-]'),
          )
        ],
        onEditingComplete: Utils.isTv
            ? () {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            : null,
        enabled: enabled,
        cursorColor: AppColors.blackTextColor,
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        textAlignVertical: TextAlignVertical.center,
        enableSuggestions: false,
        autocorrect: false,
        contextMenuBuilder: null,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(Space.sp(13)),
          counterText: "",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(Space.sp(6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Space.sp(8)),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          label: RcsText(
            Strings.userNameText,
            size: TextSize.setSp(12),
          ),
          labelStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: TextSize.setSp(15),
              color: AppColors.blackTextColor),
          hintText: Strings.enterUserNameText,
          hintStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: TextSize.setSp(15),
              color: AppColors.lightGrey),
        ),
      ),
    );
  }









  static void executeIfNetworkAvailable(
      BuildContext context, Function? functionToExecute) {
    if (AppConnectivity().isConnected) {
      functionToExecute?.call();
      return;
    }
    RcsModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      constraints: BoxConstraints(maxWidth: min(Utils.width, Utils.height)),
      enableDrag: false,
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: Utils.height * 0.4,
      isScrollControlled: false,
      builder: (context) => getNoNetworkView(functionToExecute,
          showCloseButton: true, context: context, isRetry: true),
    );
  }



  static Widget outlinedTextButtonMaxWidth(
    String text,
    void Function() onClick, {
    Color borderColor = AppColors.buttonColor,
    Color backGroundColor = AppColors.white,
    textColor = AppColors.blackTextColor,
    bool autoFocus = false,
    FocusNode? focusNode,
  }) =>
      Material(
        borderRadius: BorderRadius.circular(Space.sp(17)),
        clipBehavior: Clip.antiAlias,
        color: backGroundColor,
        child: InkWell(
          focusColor: AppColors.transparent,
          borderRadius: BorderRadius.circular(Space.sp(17)),
          onTap: () => onClick(),
          onDoubleTap: () => onClick(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: Space.sp(1),
                color: borderColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(Space.sp(17)),
            ),
            constraints: BoxConstraints(
                minWidth: double.maxFinite, minHeight: Space.sp(34)),
            child: Center(
              child: RcsText(
                size: TextSize.setSp(14),
                text,
                color: textColor,
              ),
            ),
          ),
        ),
      );


  static Widget outlinedTextButtonWithMinWidth(
      String text, void Function() onClick,
      {bool wrap = false,
      Color backgroundColor = AppColors.white,
      Color textColor = AppColors.blackTextColor,
      bool autoFocus = false,
      FocusNode? focusNode,
/*      Size? minSize,*/
      double? maxWidth,
      double? minWidth,
      double? minHeight,
      int? textSize}) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: AppColors.transparent,
      child: InkWell(
        focusColor: AppColors.transparent,
        borderRadius: BorderRadius.circular(
            minHeight == null ? Space.sp(17) : minHeight / 2),
        onTap: () => onClick(),
        onDoubleTap: () => onClick(),
        child: Container(
          decoration: BoxDecoration(
            //color: AppColors.greenColor,
            border: Border.all(
              width: Space.sp(1),
              color: AppColors.buttonColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(
                minHeight == null ? Space.sp(17) : minHeight / 2),
          ),
          padding: wrap
              ? EdgeInsets.fromLTRB(
              Space.sp(10), Space.sp(3), Space.sp(10), Space.sp(3))
              : EdgeInsets.fromLTRB(
              Space.sp(10), Space.sp(0), Space.sp(10), Space.sp(0)),
          constraints: BoxConstraints(
              minWidth: minWidth ?? Space.sp(100),
              minHeight: minHeight ?? Space.sp(34),
              maxWidth: maxWidth ?? double.infinity),
          child: Center(
            child: RcsText(
              size: TextSize.setSp(textSize ?? (wrap ? 13 : 14)),
              text,
              textAlign: TextAlign.center,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }


  static Widget filledTextButtonMaxWidth(String text, void Function() onClick,
          {FocusNode? focusNode,
          bool autofocus = false,
          FocusNode? requestFocus}) =>
      Material(
        borderRadius: BorderRadius.circular(Space.sp(17)),
        clipBehavior: Clip.antiAlias,
        color: AppColors.buttonColor,
        child: Builder(builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return InkWell(
            focusColor: AppColors.transparent,
            borderRadius: BorderRadius.circular(Space.sp(17)),
            onTap: () => onClick(),
            onDoubleTap: () => onClick(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Space.sp(17)),
                  border: Border.all(
                    color: hasFocus && Utils.isTv
                        ? AppColors.focusHighlightingColor
                        : AppColors.transparent,
                    width: hasFocus && Utils.isTv ? Space.sp(2) : Space.sp(0),
                  )),
              constraints: BoxConstraints(
                  minWidth: double.infinity, minHeight: Space.sp(34)),
              child: Center(
                child: RcsText(
                  size: TextSize.setSp(14),
                  text,
                  color: AppColors.white,
                ),
              ),
            ),
          );
        }),
      );




  static Widget updatedOutlinedTextButtonWithMinWidth(
    String text,
    void Function() onClick, {
    bool wrap = false,
    double? minWidth,
    Color textColor = AppColors.blackTextColor,
    Color backgroundColor = AppColors.transparent,
    EdgeInsets? margin,
    bool autoFocus = false,
    FocusNode? focusNode,
    FocusNode? rightNextFocus,
    FocusNode? upNextFocus,
    bool? canRequestFocus,
  }) =>
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          borderRadius: BorderRadius.circular(Space.sp(50)),
          clipBehavior: Clip.antiAlias,
          color: backgroundColor,
          child: InkWell(
            focusColor: AppColors.transparent,
            onTap: () => onClick(),
            onDoubleTap: () => onClick(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Space.sp(50)),
                border: Border.all(
                  width: Space.sp(1),
                  color:  AppColors.buttonColor,
                  style: BorderStyle.solid,
                ),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Space.sp(wrap ? 4 : 7),
                  horizontal: Space.sp(wrap ? 10 : 20)),
              constraints: BoxConstraints(
                  minWidth:
                  minWidth ?? (wrap ? Space.sp(80) : Space.sp(125))),
              child: RcsText(
                size: TextSize.setSp(wrap ? 13 : 14),
                text,
                removeTextPadding: true,
                textAlign: TextAlign.center,
                color: textColor,
              ),
            ),
          ),
        ),
      );


  static Widget updatedFilledTextButtonWithMinWidth(
    String text,
    void Function() onClick, {
    bool wrap = false,
    double? minWidth,
    Color textColor = AppColors.white,
    Color backgroundColor = AppColors.buttonColor,
    bool autofocus = false,
    bool isUpFocusRequired = true,
    EdgeInsets? margin,
    FocusNode? focusNode,
  }) =>
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          borderRadius: BorderRadius.circular(Space.sp(50)),
          clipBehavior: Clip.antiAlias,
          color: backgroundColor,
          child: InkWell(
            focusColor: AppColors.transparent,
            splashColor:
            AppColors.loginGradientBottom.withValues(alpha: 0.4),
            onTap: () => onClick(),
            onDoubleTap: () => onClick(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Space.sp(50)),
                border: Border.all(
                    width:
                    Space.sp(1),
                    style: BorderStyle.solid,
                    color:  backgroundColor),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Space.sp(wrap ? 4 : 7),
                  horizontal: Space.sp(wrap ? 10 : 20)),
              constraints: BoxConstraints(
                  minWidth:
                  minWidth ?? (wrap ? Space.sp(80) : Space.sp(125))),
              child: RcsText(
                size: TextSize.setSp(wrap ? 13 : 14),
                text,
                removeTextPadding: true,
                textAlign: TextAlign.center,
                color: textColor,
              ),
            ),
          ),
        ),
      );


  static Widget updatedFilledTextButtonWithMinWidthUsingGestureDetector(
          String text, void Function() onClick,
          {bool wrap = false,
          double? minWidth,
          Color textColor = AppColors.white,
          bool autoFocus = false}) =>
      Material(
        borderRadius: BorderRadius.circular(Space.sp(50)),
        clipBehavior: Clip.antiAlias,
        color: AppColors.buttonColor,
        child: GestureDetector(
          onTap: () => onClick(),
          onDoubleTap: () => onClick(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Space.sp(50)),
              border: Border.all(
                  width:  Space.sp(1),
                  style: BorderStyle.solid,
                  color: AppColors.buttonColor),
            ),
            padding: EdgeInsets.symmetric(
                vertical: Space.sp(wrap ? 4 : 7),
                horizontal: Space.sp(wrap ? 10 : 20)),
            constraints: BoxConstraints(
                minWidth:
                minWidth ?? (wrap ? Space.sp(80) : Space.sp(125))),
            child: RcsText(
              size: TextSize.setSp(wrap ? 13 : 14),
              text,
              removeTextPadding: true,
              textAlign: TextAlign.center,
              color: textColor,
            ),
          ),
        ),
      );



  static Widget scrollableNoDataViewForRefresh() => LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
            controller: ScrollController(),
            child: SizedBox(
                height: constraints.maxHeight + 1,
                child: Center(
                    child: AppImages.appNoData.loadAsset(
                        height: min(Utils.width, Utils.height) * 0.81))),
          ));

  static Widget loadingShimmerList(
      {int cardHeight = 100,
      int borderRadius = 16,
      int cardsCount = 6,
      Axis scrollDirection = Axis.vertical,
      int? width,
      EdgeInsets? margin}) {
    margin ??=
        EdgeInsets.symmetric(vertical: Space.sp(6), horizontal: Space.sp(6));
    return Shimmer.fromColors(
      baseColor: AppColors.loginGradientTop.withValues(alpha: 0.5),
      highlightColor: AppColors.loginGradientTop.withValues(alpha: 0.4),
      child: ListView(
        scrollDirection: scrollDirection,
        children: [
          for (int i = 0; i < cardsCount; i++)
            Container(
              width: width != null ? Space.sp(width) : null,
              margin: margin,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Space.sp(borderRadius))),
              height: Space.sp(cardHeight),
            )
        ],
      ),
    );
  }

  static Widget singleCardShimmer(
          {int height = 100,
          int borderRadius = 16,
          int? margin,
          BoxShape shape = BoxShape.rectangle,
          int? width}) =>
      Shimmer.fromColors(
        baseColor: AppColors.loginGradientTop.withValues(alpha: 0.5),
        highlightColor: AppColors.loginGradientTop.withValues(alpha: 0.4),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: Space.sp(margin ?? 6),
              horizontal: Space.sp(margin ?? 6)),
          decoration: BoxDecoration(
              shape: shape,
              color: AppColors.white,
              borderRadius: shape == BoxShape.rectangle
                  ? BorderRadius.circular(Space.sp(borderRadius))
                  : null),
          height: Space.sp(height),
          width: width != null ? Space.sp(width) : null,
        ),
      );

  static esScrollBar(
      {required Widget child,
      EdgeInsets? padding,
      Color? thumbColor = AppColors.blackTextColor,
      ScrollController? controller,
      isTvScrollRequired = false,
      double? thickness,
      bool? thumbVisibility,
      bool? interactive}) {
    padding ??= const EdgeInsets.all(0);
    return (Utils.isTv && isTvScrollRequired)
        ? Row(
            children: [
              Expanded(child: child),
              SizedBox(
                width: Space.sp(20),
                child: Wrap(
                  children: [
                    IconButton(
                      focusColor: AppColors.black.withValues(alpha: 0.4),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_upward,
                        color: thumbColor,
                      ),
                      onPressed: () {
                        controller?.animateTo(
                          controller.offset - 100,
                          duration: const Duration(microseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    IconButton(
                      focusColor: AppColors.black.withValues(alpha: 0.4),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: thumbColor,
                      ),
                      onPressed: () {
                        controller?.animateTo(
                          controller.offset + 100,
                          duration: const Duration(microseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        : Padding(
            padding: EdgeInsets.fromLTRB(
                padding.left, padding.top, 0, padding.bottom),
            child: RawScrollbar(
              controller: controller,
              thumbColor: thumbColor,
              thumbVisibility: thumbVisibility,
              interactive: interactive,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Space.sp(50))),
              trackVisibility: true,
              minThumbLength: Space.sp(50),
              thickness: thickness ?? 5,
              child: Padding(
                padding: EdgeInsets.only(right: padding.right),
                child: child,
              ),
            ),
          );
  }


}

class CustomOrientationBuilder extends StatelessWidget {
  const CustomOrientationBuilder(
      {super.key, required this.portraitView, required this.landscapeView});

  final Widget portraitView;
  final Widget landscapeView;

  @override
  Widget build(BuildContext context) {
    Utils.updateOrientation(context);
    return Utils.orientation == Orientation.portrait
        ? portraitView
        : landscapeView;
  }
}

/*static TextButton outlinedTextButtonWithMinWidth(
          String text, void Function() onClick,
          {bool wrap = false,
          Color backgroundColor = AppColors.white,
          Color textColor = AppColors.blackTextColor,
          Size? minSize}) =>
      TextButton(
        onPressed: () {
          if (SingleClickListener.canClick()) {
            onClick();
          }
        },
        style: ButtonStyle(
          padding: wrap
              ? WidgetStateProperty.all(EdgeInsets.fromLTRB(
                  Space.sp(10), Space.sp(3), Space.sp(10), Space.sp(3)))
              : WidgetStateProperty.all(EdgeInsets.fromLTRB(
                  Space.sp(20), Space.sp(0), Space.sp(20), Space.sp(0))),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: wrap
              ? WidgetStateProperty.all(Size.zero)
              : WidgetStateProperty.all(
                  minSize ?? Size(Space.sp(150), Space.sp(35))),
          foregroundColor: WidgetStateProperty.all(AppColors.blackTextColor),
          side: WidgetStateProperty.all(
            BorderSide(
                width: Space.sp(1),
                color: AppColors.buttonColor,
                strokeAlign: BorderSide.strokeAlignInside),
          ),
        ),
        child: EsText(
          size: TextSize.setSp(wrap ? 13 : 15),
          text,
          color: textColor,
        ),
      );*/

/* static TextButton filledTextButtonMaxWidth(
          String text, void Function() onClick) =>
      TextButton(
        onPressed: () {
          if (SingleClickListener.canClick()) {
            onClick();
          }
        },
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(double.maxFinite, 0)),
          backgroundColor: WidgetStateProperty.all(AppColors.buttonColor),
          foregroundColor: WidgetStateProperty.all(AppColors.white),
        ),
        child: EsText(
          size: TextSize.setSp(15),
          textAlign: TextAlign.center,
          text,
          color: AppColors.white,
        ),
      );*/

/*static TextButton filledTextButtonWithMinWidth(
          String text, void Function() onClick,
          {bool wrap = false, Size? minSize}) =>
      TextButton(
        onPressed: () {
          if (SingleClickListener.canClick()) {
            onClick();
          }
        },
        style: ButtonStyle(
            padding: wrap
                ? WidgetStateProperty.all(EdgeInsets.fromLTRB(
                    Space.sp(10), Space.sp(3), Space.sp(10), Space.sp(3)))
                : WidgetStateProperty.all(EdgeInsets.fromLTRB(
                    Space.sp(20), Space.sp(0), Space.sp(20), Space.sp(0))),
            minimumSize: wrap
                ? WidgetStateProperty.all(Size.zero)
                : WidgetStateProperty.all(
                    minSize ?? Size(Space.sp(150), Space.sp(35))),
            foregroundColor: WidgetStateProperty.all(AppColors.whiteTextColor),
            backgroundColor: WidgetStateProperty.all(AppColors.buttonColor),
            side: WidgetStateProperty.all(
              BorderSide(
                  width: Space.sp(1),
                  color: AppColors.buttonColor,
                  strokeAlign: BorderSide.strokeAlignInside),
            )),
        child: EsText(
          size: TextSize.setSp(15),
          text,
          color: AppColors.whiteTextColor,
        ),
      );*/

/*static TextButton outlinedTextButtonMaxWidth(
      String text, void Function() onClick,
      {Color borderColor = AppColors.buttonColor,
        Color backGroundColor = AppColors.white,
        textColor = AppColors.blackTextColor}) =>
      TextButton(
        onPressed: () {
          if (SingleClickListener.canClick()) {
            onClick();
          }
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(backGroundColor),
            minimumSize:
            WidgetStateProperty.all(const Size(double.maxFinite, 0)),
            foregroundColor: WidgetStateProperty.all(AppColors.black),
            side: WidgetStateProperty.all(
              BorderSide(
                  width: Space.sp(2),
                  color: borderColor,
                  strokeAlign: BorderSide.strokeAlignInside),
            )),
        child: EsText(
          size: TextSize.setSp(15),
          textAlign: TextAlign.center,
          text,
          color: textColor,
        ),
      );*/
