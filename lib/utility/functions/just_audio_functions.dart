import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/cream_light_notifiers.dart';

class JAudio {
  

  static void seekNext(WidgetRef ref) async {
    ref.watch(clCurrentTrack.notifier).setNextTrack(ref);
  }

  static void seekPrevious(WidgetRef ref) async {
    ref.watch(clCurrentTrack.notifier).setPreviousTrack(ref);
  }
}
