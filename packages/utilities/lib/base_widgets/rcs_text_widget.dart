import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';
import '../text_size.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Common application level text widget
TODO check alternatives using extension and defaultStyle.merge apis

*/
Widget RcsText(String text, {
double? size,
int? maxLines,
TextOverflow? overflow,
FontWeight? fontWeight,
TextAlign? textAlign,
Color? color,
double? letterSpacing,
bool removeTextPadding=false,})=>Text(
  text,
  textAlign: textAlign ?? TextAlign.left,
  overflow: overflow,
  maxLines: maxLines,
  style: GoogleFonts.roboto(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? TextSize.setSp(23),
      letterSpacing: letterSpacing ?? 0.0,
      height: removeTextPadding?0:null,
      color: color ?? AppColors.blackTextColor),
);

// class EsText extends StatelessWidget {
//   final String text;
//   final double? size;
//   final int? maxLines;
//   final TextOverflow? overflow;
//   final FontWeight? fontWeight;
//   final TextAlign? textAlign;
//   final Color? color;
//   final double? letterSpacing;
//   final bool removeTextPadding;
//
//   const EsText(this.text,
//       {super.key,
//       this.size,
//       this.fontWeight,
//       this.color,
//       this.letterSpacing,
//       this.textAlign,
//       this.maxLines,
//       this.overflow,
//       this.removeTextPadding=false});
//
//   @override
//   Widget build(BuildContext context) {
//     return _getTextView();
//   }
//
//   Widget _getTextView() {
//     return Text(
//       text,
//       textAlign: textAlign ?? TextAlign.left,
//       overflow: overflow,
//       maxLines: maxLines,
//       style: GoogleFonts.roboto(
//           fontWeight: fontWeight ?? FontWeight.normal,
//           fontSize: size ?? TextSize.setSp(23),
//           letterSpacing: letterSpacing ?? 0.0,
//           height: removeTextPadding?0:null,
//           color: color ?? AppColors.blackTextColor),
//     );
//   }
// }
