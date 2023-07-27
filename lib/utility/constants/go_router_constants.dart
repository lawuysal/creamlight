import 'package:creamlight/pages/audio_query_test_screen.dart';
import 'package:creamlight/pages/cream_playlist_test.dart';
import 'package:go_router/go_router.dart';

import '../../pages/playlists_screen.dart';

class RouteNames {
  static const String query = 'queryScreen';
  static const String allsongs = 'playlistScreen';
  static const String playlists = 'playlistsScreen';
}

final GoRouter pageRoutes = GoRouter(routes: [
  GoRoute(
    name: RouteNames.query,
    path: '/',
    builder: ((context, state) => const QueryTest()),
    routes: [
      GoRoute(
          name: RouteNames.allsongs,
          path: 'allsongs',
          builder: ((context, state) => const CreamPlaylistTest())),
      GoRoute(
          name: RouteNames.playlists,
          path: 'playlists',
          builder: ((context, state) => const PlaylistsScreen())),
    ],
  ),
]);
