import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';

showDiscard(BuildContext context, String content, Function() onDiscard) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        child: DialogueBox(
          title: "Discard Changes",
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: context.theme.primaryColor),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => onDiscard(),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Discard"),
            ),
          ],
        ),
      );
    },
  );
}

showDeleteDialogue(
    BuildContext context, String title, String content, Function() onDelete) {
  showAdaptiveDialog(
    context: context,
    builder: (dlgContext) {
      return Dialog(
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        child: DialogueBox(
          title: title,
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: context.theme.primaryColor),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: onDelete,
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        ),
      );
    },
  );
}

class DialogueBox extends StatelessWidget {
  const DialogueBox({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  final String title;
  final String content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 2,
            style: context.theme.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          15.hs,
          Text(
            content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          20.hs,
          Row(mainAxisAlignment: MainAxisAlignment.end, children: actions)
        ],
      ),
    );
  }
}
