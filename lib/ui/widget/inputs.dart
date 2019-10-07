part of 'widgets.dart';

class PrimaryTextField extends StatefulWidget {
  PrimaryTextField({
    this.text,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.focusNode,
    this.controller,
    Key key,
  }) : super(key: key);

  final String text;
  final String hint;
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;
  final bool autofocus;

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  TextEditingController _controller;

  @override
  initState() {
    if (widget.text != null) {
      _controller = widget.controller ?? TextEditingController();
      _controller.text = widget.text;
    }
    super.initState();
  }

  @override
  dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightGrey),
      borderRadius: BorderRadius.circular(12.0),
    );

    return TextField(
      focusNode: widget.focusNode,
      controller: _controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.lightGrey),
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: border,
        border: border,
        filled: true,
        fillColor: AppColors.white,
      ),
    );
  }
}
