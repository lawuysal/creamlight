import 'package:creamlight/utility/functions/hive_functions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utility/functions/cream_functions.dart';

class PlaylistsScreen extends ConsumerStatefulWidget {
  const PlaylistsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaylistsScreenState();
}

class _PlaylistsScreenState extends ConsumerState<PlaylistsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController playlistNameController = TextEditingController();
    TextEditingController playlistDescriptionController =
        TextEditingController();
    final playlistFormKey = GlobalKey<FormState>();
    final playlists = CreamHive.getLocalPlaylist();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            CreamFunc.createPlaylist(context, playlistFormKey,
                playlistNameController, playlistDescriptionController);
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Playlists'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint(playlists.toString());
              },
              child: const Text('Show Local Playlists'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Text(playlists[index].name),
                    subtitle: Text(playlists[index].description),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          CreamFunc.deletePlaylist(ref, index);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
