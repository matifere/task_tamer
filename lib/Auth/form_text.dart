import 'package:flutter/material.dart';

class FormText extends StatefulWidget {
  const FormText({
    super.key,
    required this.control,
    required this.hint,
    required this.validator,
    required this.esContra,
  });

  final TextEditingController control;
  final String hint;
  final FormFieldValidator<String?> validator;
  final bool esContra;

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  late bool iconEstado;
  @override
  void initState() {
    iconEstado = widget.esContra;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextFormField(
        obscureText: iconEstado,
        controller: widget.control,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: OutlineInputBorder(),
          suffixIcon: widget.esContra
              ? IconButton(
                  icon: iconEstado
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      iconEstado = !iconEstado;
                    });
                  },
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
