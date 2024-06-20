import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';

enum ToastType { success, error, warning }

class ToastBar extends StatelessWidget {
  const ToastBar({super.key, required this.message, required this.toastType});
  final String message;
  final ToastType toastType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: getColorForToast(toastType),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            getIconForToast(toastType),
            size: 25,
            color: Colors.white,
          ),
          12.ws,
          Expanded(
            child: Text(message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.bodyLarge!
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

IconData getIconForToast(ToastType toast) {
  switch (toast) {
    case ToastType.error:
      return Icons.error;
    case ToastType.success:
      return Icons.done;
    case ToastType.warning:
      return Icons.warning;

    default:
      return Icons.numbers;
  }
}

Color getColorForToast(ToastType toast) {
  switch (toast) {
    case ToastType.error:
      return Colors.red;
    case ToastType.success:
      return const Color(0xFF009973);
    case ToastType.warning:
      return Colors.yellow;

    default:
      return Colors.grey;
  }
}
