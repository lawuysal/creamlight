import 'dart:convert';
import 'package:creamlight/models/spotify_song_model.dart';
import 'package:creamlight/utility/constants/spotify_constants.dart';
import 'package:creamlight/utility/notifiers/spotify_notifiers.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class SpotifyAuth {
  //********************************************************//
  // Requests top songs from Spotify API
  static Future<void> fetchTopSongs(WidgetRef ref) async {
    await _requstAuthCode(ref);
    await _requestAccessToken(ref);
    await _requsetUserTopSongs(ref);
    _storeIncomingSongs(ref);
  }
  //********************************************************//

  // Extract authorization code from resulting url
  static void _extractAuthCode(WidgetRef ref) {
    try {
      ref.watch(spoAuthCode.notifier).state =
          Uri.parse(ref.watch(spoAuthRespone.notifier).state)
              .queryParameters['code'];
    } catch (e) {
      print(
          "CreamError: Successfully get auth response but can't get authorization code and this error: $e");
    }
  }

  static Future<void> _requestAccessToken(WidgetRef ref) async {
    // If the response is not null, request a token
    try {
      ref.watch(spoTokenResponse.notifier).state = await http.post(
        Uri.parse(tokenEndpoint),
        headers: {
          'Content-Type': contentType,
          'Authorization':
              'Basic   ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        },
        body: {
          'grant_type': grantType,
          'code': ref.watch(spoAuthCode.notifier).state,
          'redirect_uri': redirectUrl,
        },
      );
    } catch (e) {
      print(
          "CreamError: Successfully get auth token but can't get token response and this error: $e");
    }

    // Stores the token response data to a provider
    ref.watch(spoTokenResponseData.notifier).state =
        jsonDecode(ref.watch(spoTokenResponse.notifier).state!.body);

    // Stores the access token to a provider
    ref.watch(spoAccessToken.notifier).state =
        ref.watch(spoTokenResponseData.notifier).state!['access_token'];
  }

  static Future<void> _requsetUserTopSongs(WidgetRef ref) async {
    // If the token response is successful, request the user's top songs
    try {
      ref.watch(spoApiResponse.notifier).state = await http.get(
          Uri.parse(requestMySongsEndpoint),
          headers: {'Authorization': 'Bearer ${ref.watch(spoAccessToken)}'});
    } catch (e) {
      print(
          "CreamError: Successfully get token response but can't get api response and this error: $e");
    }

    // Stores the api response data to a providerkkkkk
    ref.watch(spoApiResponseData.notifier).state =
        jsonDecode(ref.watch(spoApiResponse.notifier).state!.body);
  }

  // Iterates through the songs from api response and stores them to a list provider
  static void _storeIncomingSongs(WidgetRef ref) {
    for (int i = 0; i < trackCallLimit; i++) {
      var song = SpotifySong(
        name: ref.watch(spoApiResponseData.notifier).state!['items'][i]['name'],
        artist: ref.watch(spoApiResponseData.notifier).state!['items'][i]
            ['artists'][0]['name'],
        image: ref.watch(spoApiResponseData.notifier).state!['items'][i]
            ['album']['images'][0]['url'],
        trackUri: ref.watch(spoApiResponseData.notifier).state!['items'][i]
            ['external_urls']['spotify'],
      );
      ref.watch(spoSongs.notifier).addSong(song);
      ref.watch(spoSongs.notifier).storeSongsLocally();
    }
  }

  // Stores the response from the authorization endpoint to a provider
  static Future<void> _requstAuthCode(WidgetRef ref) async {
    try {
      ref.watch(spoAuthRespone.notifier).state =
          await FlutterWebAuth2.authenticate(
              url: authorizationUrl, callbackUrlScheme: callbackUrlScheme);
    } catch (e) {
      print("CreamError: Can't get response from api and this error: $e");
    }
    // Extracts the authorization code from the response
    _extractAuthCode(ref);
  }
}
