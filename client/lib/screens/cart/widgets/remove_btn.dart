import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RemoveBtn extends StatelessWidget {
  const RemoveBtn({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: SizedBox(
        width: 30,
        child: Container(
          color: Colors.orange,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              splashColor: Colors.red,
              onTap: onTap,
              child: Center(
                child: Text(
                  '-1',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
