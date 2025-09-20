import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utilities/base_widgets/rcs_text_widget.dart';

import '../app_colors.dart';
import '../strings.dart';
import '../text_size.dart';
import '../utils.dart';

class RcsPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool enabled;
  final bool isHorizontalPaddingRequired;
  final TextInputAction inputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool autoFocus;

  const RcsPasswordTextField(this.controller, this.labelText,
      {super.key,
      this.enabled = true,
      this.inputAction = TextInputAction.done,this.isHorizontalPaddingRequired=true,this.inputFormatters,this.focusNode,
        this.nextFocusNode,
        this.autoFocus = false,});

  @override
  State<RcsPasswordTextField> createState() => _RcsPasswordTextFieldState();
}

class _RcsPasswordTextFieldState extends State<RcsPasswordTextField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.isHorizontalPaddingRequired? Space.sp(10):Space.sp(0)),
      color: AppColors.white,
      child: TextField(
        onTapOutside: (event) =>  FocusManager.instance.primaryFocus?.unfocus(),
        onEditingComplete: Utils.isTv ? () {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        } :  null,
        autofocus: widget.autoFocus,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.inputAction,
        controller: widget.controller,
        enabled: widget.enabled,
        cursorColor: AppColors.blackTextColor,
        focusNode: widget.focusNode,
        enableSuggestions: false,
        autocorrect: false,
        maxLength: 20,
        contextMenuBuilder: null,
        obscureText: !passwordVisible,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(Space.sp(13)),
            counterText: "",
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: AppColors.editTextFieldBorderGreyColor),
              borderRadius: BorderRadius.circular(Space.sp(6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Space.sp(6)),
              borderSide: const BorderSide(
                color: AppColors.editTextFieldBorderGreyColor,
              ),
            ),
            label: RcsText(
              widget.labelText,
              size: TextSize.setSp(12),
            ),
            labelStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.normal,
                fontSize: TextSize.setSp(15),
                color: AppColors.blackTextColor),
            hintText: Strings.enterPasswordText,
            hintStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.normal,
                fontSize: TextSize.setSp(15),
                color: AppColors.lightGrey),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              child: Icon(
                passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: AppColors.lightGrey,
              ),
            )),
        enableInteractiveSelection: true,
      ),
    );
  }
}
