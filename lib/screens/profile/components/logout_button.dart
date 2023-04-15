import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';
import '../../../utils/dialogs.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.square_arrow_right,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Log out',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          )
        ],
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want log sign out ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Dialogs.showProgressBar(context);
                    Navigator.pop(context);
                    await FirebaseService.auth.signOut().then((value) {
                      //hiden dialog
                      Navigator.pop(context);
                      //hiden profile screen
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Confirm',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
