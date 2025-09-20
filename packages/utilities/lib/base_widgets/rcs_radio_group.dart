import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors.dart';
import '../text_size.dart';
import '../utils.dart';
import 'rcs_text_widget.dart';

class RcsRadioGroup extends StatefulWidget {
  final List<EsRadioButton> radioButtons;
  final ValueChanged<int> onChanged;
  final FocusNode? requestFocusNode;

  const RcsRadioGroup(this.radioButtons, this.onChanged,
      {this.requestFocusNode, super.key});

  @override
  State<RcsRadioGroup> createState() => _RcsRadioGroupState();

  int getSelectedIndex() {
    return radioButtons
        .indexOf(radioButtons.firstWhere((item) => item.selected));
  }
}

class _RcsRadioGroupState extends State<RcsRadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (EsRadioButton button in widget.radioButtons)
          GestureDetector(
            onTap: () {
              _esRadioClick(button);
            },
            onDoubleTap: () {},
            child: Padding(
              padding: EdgeInsets.only(bottom: Space.sp(10)),
              child: _getRadioButton(button),
            ),
          )
      ],
    );
  }

  void _esRadioClick(EsRadioButton button) {
    for (EsRadioButton btn in widget.radioButtons) {
      btn.selected = false;
    }
    setState(() {
      button.selected = true;
      widget.onChanged(widget.getSelectedIndex());
    });
  }

  Widget _getRadioButton(EsRadioButton button) {
    return Builder(builder: (context) {
      final hasFocus = Focus.of(context).hasFocus;
      return Container(
          height: Space.sp(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: hasFocus && Utils.isTv
                  ? AppColors.focusHighlightingColor
                  : AppColors.editTextFieldBorderGreyColor,
              width: hasFocus && Utils.isTv? Space.sp(1) : Space.sp(0),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Space.sp(5),
              ),
              _customRadioButton(button),
              SizedBox(
                width: Space.sp(5),
              ),
              Expanded(
                child: RcsText(button.text,
                    overflow: TextOverflow.ellipsis,
                    size: TextSize.setSp(13),
                    fontWeight: FontWeight.normal,
                    color: AppColors.black),
              )
            ],
          )

          /*ListTile(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            leading: _customRadioButton(button),

            title: EsText(button.text,
                overflow: TextOverflow.ellipsis,
                size: TextSize.setSp(15),
                fontWeight: FontWeight.w500,
                color: AppColors.blackTextColor),
          ),*/
          );
    });
  }

  Widget _customRadioButton(EsRadioButton button) {
    // bool isSelected = widget.value; // == widget.groupValue;

    return Container(
      width: Space.sp(16),
      height: Space.sp(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: button.selected
              ? AppColors.transparent
              : AppColors.editTextFieldBorderGreyColor,
        ),
        color: button.selected
            ? AppColors.esRadioButtonCircleColor
            : AppColors.transparent,
      ),
      child: button.selected
          ? const Icon(
              Icons.check,
              color: AppColors.esRadioButtonTickMarkColor,
              size: 16.0,
            )
          : null,
    );
  }
}

class EsRadioButton {
  final String text;
  bool selected = false;

  EsRadioButton(this.text);
}
