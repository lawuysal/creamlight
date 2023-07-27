// Purpose: Contains constants used in the Spotify API calls.
// for futher information, see https://developer.spotify.com/documentation/general/guides/authorization-guide/#authorization-code-flow

const clientId = "dd5543f59fb64b9983af1ed9ad5a1484";

const clientSecret = "a3a30c93c3af47e3a7699ccd2358c42b";

const redirectUrl = "com.example.creamlight://localhost:8888/callback/";

const callbackUrlScheme = "com.example.creamlight";

const scopes = "user-read-private user-read-email user-top-read";

const authorizationResponseType = "code";

const tokenEndpoint = "https://accounts.spotify.com/api/token";

const requestMySongsEndpoint =
    "https://api.spotify.com/v1/me/top/tracks?limit=$trackCallLimit&offset=$trackCallOffset";

const authorizationUrl =
    "https://accounts.spotify.com/authorize?response_type=$authorizationResponseType&client_id=$clientId&scope=$scopes&redirect_uri=$redirectUrl";

const grantType = "authorization_code";

const contentType = "application/x-www-form-urlencoded";

const trackCallLimit = 8;

const trackCallOffset = 0;
