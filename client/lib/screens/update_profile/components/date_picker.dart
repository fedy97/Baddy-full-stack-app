import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/constants.dart';

class MyTextFieldDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;

  MyTextFieldDatePicker({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    @required this.lastDate,
    @required this.initialDate,
    @required this.onDateChanged,
  })  : assert(lastDate != null),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);

  @override
  _MyTextFieldDatePicker createState() => _MyTextFieldDatePicker();
}

class _MyTextFieldDatePicker extends State<MyTextFieldDatePicker> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat.yM();
    }

    _selectedDate = widget.initialDate;
    _controllerDate = TextEditingController();
    _controllerDate.text = _selectedDate != null ? _dateFormat.format(_selectedDate) : '';
  }

  @override
  Widget build(BuildContext context) {
    try {
      return TextField(
        style: GoogleFonts.montserrat(color: kSecondaryColor),
        focusNode: widget.focusNode,
        controller: _controllerDate,
        decoration: customInputDecoration(
            title: "Birth", iconName: "Gift Icon"),
        onTap: () => _selectDate(context),
        readOnly: true,
      );
    } catch (e) {
      print(e);
      return Container();
    }
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1940, 8),
      initialDate: _selectedDate ?? DateTime(2000, 1),
      lastDate: widget.lastDate,
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }
}
