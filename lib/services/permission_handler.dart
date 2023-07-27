import 'package:permission_handler/permission_handler.dart';
import 'package:creamlight/utility/variables/permission_variables.dart';

// Gets permission for audio, photos, and videos and returns a overall boolean
Future<bool> requestPermissions() async {
  audioStatus = await Permission.audio.request();
  photosStatus = await Permission.photos.request();
  videosStatus = await Permission.videos.request();

  if (audioStatus.isGranted &&
      photosStatus.isGranted &&
      videosStatus.isGranted) {
    return true;
  } else {
    return false;
  }
}
