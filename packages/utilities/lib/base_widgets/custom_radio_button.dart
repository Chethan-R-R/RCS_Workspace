import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../text_size.dart';
import 'rcs_text_widget.dart';

class CustomRadioListTile extends StatelessWidget {
  bool value = false;

  //final T groupValue;
  final ValueChanged<bool> onChanged;
  final Widget title;

  CustomRadioListTile(
      {super.key,
      // required this.groupValue,
      required this.onChanged,
      required this.title,
      this.value = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black), // Add border to the container
      ),
      child: ListTile(
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        onTap: () => onChanged(value),
        leading: _customRadioButton,
        title: title,
      ),
    );
  }

  Widget get _customRadioButton {
    // bool isSelected = widget.value; // == widget.groupValue;

    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: value ? Colors.transparent : Colors.grey,
        ),
        color: value ? Colors.greenAccent[100] : Colors.transparent,
      ),
      child: value
          ? Icon(
              Icons.check,
              color: Colors.green[700],
              size: 16.0,
            )
          : null,
    );
  }
}

class CustomFilterRadioListTile extends StatelessWidget {
  bool value = false;

  //final T groupValue;
  final ValueChanged<bool> onChanged;
  final Widget title;

  CustomFilterRadioListTile(
      {super.key,
        // required this.groupValue,
        required this.onChanged,
        required this.title,
        this.value = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.activityCentreFilterDropDownColor))),
      child: ListTile(
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        onTap: () => onChanged(value),
        trailing: _customRadioButton,
        title: title,
      ),
    );
  }

  Widget get _customRadioButton {
    // bool isSelected = widget.value; // == widget.groupValue;

    return Icon(
      Icons.check_outlined,
      color: value?AppColors.orangeColor:AppColors.black,
      size: 20.0,
    );
  }
}
///////////////////////////////////
//////////////////////////////
class EsTrailRadioGroup extends StatefulWidget {
  final List<EsTrailRadioButton> radioButtons;
  final ValueChanged<int> onChanged;
  const EsTrailRadioGroup(this.radioButtons, this.onChanged, {super.key});

  @override
  State<EsTrailRadioGroup> createState() => _EsTrailRadioGroupState();
  int getSelectedIndex() {
    return radioButtons
        .indexOf(radioButtons.firstWhere((item) => item.selected));
  }
}

class _EsTrailRadioGroupState extends State<EsTrailRadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (EsTrailRadioButton button in widget.radioButtons)
          GestureDetector(
            onTap: () {
              for (EsTrailRadioButton btn in widget.radioButtons) {
                btn.selected = false;
              }
              setState(() {
                button.selected = true;
                widget.onChanged(widget.getSelectedIndex());
              });
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
  Widget _getRadioButton(EsTrailRadioButton button) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors
                      .activityCentreFilterDropDownColor))),
      child: ListTile(
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        trailing: _customRadioButton(button),
        title: RcsText(button.text,
            overflow: TextOverflow.ellipsis,
            size: TextSize.setSp(15),
            fontWeight: FontWeight.w500,
            color: AppColors.blackTextColor),
      ),
    );
  }
  Widget _customRadioButton(EsTrailRadioButton button) {
    // bool isSelected = widget.value; // == widget.groupValue;

    return Icon(
        Icons.check,
        color:  button.selected?AppColors.buttonColor:AppColors.esRadioButtonTickMarkColor,
        size: 20.0,
    );
  }


}
class EsTrailRadioButton {
  final String text;
  bool selected = false;
  EsTrailRadioButton(this.text);
}
