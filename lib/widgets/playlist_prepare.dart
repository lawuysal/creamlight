import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utility/functions/cream_functions.dart';

class CreamPlaylistPrepare extends ConsumerStatefulWidget {
  /// These are the controllers for the playlist name and description
  final TextEditingController pNameCtrl;
  final TextEditingController pDescriptionCtrl;
  final GlobalKey<FormState> formKey;

  const CreamPlaylistPrepare(
      {super.key,
      required this.pNameCtrl,
      required this.pDescriptionCtrl,
      required this.formKey});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreamPlaylistPrepareState();
}

class _CreamPlaylistPrepareState extends ConsumerState<CreamPlaylistPrepare> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Create New Playlist'),
          content: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: widget.formKey,
            child: Container(
              height: 200,
              child: Column(
                children: [
                  TextFormField(
                    controller: widget.pNameCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a name for the playlist";
                      } else if (value.length > 50) {
                        return "Name, must be less than 50 characters";
                      } else if (value.length < 3) {
                        return "Name, must be at least 3 characters";
                      } else if (value
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\/]'))) {
                        return "Cannot contain special characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.pNameCtrl.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: widget.pDescriptionCtrl,
                    validator: (value) {
                      if (value!.length > 50) {
                        return "Must be less than 50 characters";
                      } else if (value
                          .contains(RegExp(r'[@#$%^&*()":{}|<>\/]'))) {
                        return "Cannot contain special characters";
                      } /* else if (value.isNotEmpty) {
                            if (value.length < 3) {
                              return "Name, must be at least 3 characters";
                            }f
                          } */
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.pDescriptionCtrl.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final isValidForm = widget.formKey.currentState!.validate();
                  if (isValidForm) {
                    final name = widget.pNameCtrl.text;
                    final description = widget.pDescriptionCtrl.text;
                    CreamFunc.preparePlaylist(ref, name, description);
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
