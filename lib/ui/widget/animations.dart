part of 'widgets.dart';

class BottomSheetAnimation extends StatefulWidget {
  const BottomSheetAnimation({
    this.bottomSheet,
    Key key,
  }) : super(key: key);

  final Widget bottomSheet;

  @override
  _BottomSheetAnimationState createState() => _BottomSheetAnimationState();
}

class _BottomSheetAnimationState extends State<BottomSheetAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller
      ..addListener(() {
        setState(() => null);
      });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: AppColors.black.withOpacity(0.7 * _controller.value),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionalTranslation(
              translation: Offset(0, _animation.value),
              child: widget.bottomSheet,
            ),
          ),
        ],
      ),
    );
  }
}
