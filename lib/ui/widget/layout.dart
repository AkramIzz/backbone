import 'package:flutter/material.dart';

class VerticalSpace extends SizedBox {
  VerticalSpace(double space) : super(height: space);
}

class HorizontalSpace extends SizedBox {
  HorizontalSpace(double space) : super(width: space);
}

class SizedLayoutBuilder extends StatefulWidget {
  SizedLayoutBuilder({this.child, this.builder, Key key}) : super(key: key);

  final Widget child;
  final Widget Function(BuildContext context, Size childSize, Widget child)
      builder;

  @override
  _SizedLayoutBuilderState createState() => _SizedLayoutBuilderState();
}

class _SizedLayoutBuilderState extends State<SizedLayoutBuilder> {
  Size size;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() => size = context.size),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return size == null
        ? widget.child
        : widget.builder(context, size, widget.child);
  }
}
