part of 'widgets.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({@required this.child, @required this.onPressed, Key key})
      : super(key: key);

  factory PrimaryButton.text(String text,
      {@required void Function() onPressed}) {
    return PrimaryButton(
      child: Text(
        text,
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
      ),
      onPressed: onPressed,
    );
  }

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.primary,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryTextFieldLikeButton extends StatelessWidget {
  PrimaryTextFieldLikeButton({this.hint, this.text, this.onPressed, Key key})
      : super(key: key);

  final String hint;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        style: BorderStyle.solid,
        width: 1.0,
        color: AppColors.lightGrey,
      ),
    );

    final child = Text(
      text ?? hint,
      style: TextStyle(
          color: text == null ? AppColors.lightGrey : AppColors.black),
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
