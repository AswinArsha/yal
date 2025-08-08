class AppUrls {
//================== server client id
  static const String serverClientId =
      '504170220783-q8vhtia3c8sefakkh4qemull0m0532qc.apps.googleusercontent.com';

//================== server client id

  ////////////////// E-Sports URL/////////////////////////////
  static const String baseURL = 'https://new.backend.dev.yalgamers.gg';

  // Auth URL
  static const String authURL = '$baseURL/auth/google/mobile-login';

  static const String savePasswordURL = '$baseURL/auth/save-password';

  static const String refreshURL = '$baseURL/auth/refresh';
  static const String logoutURL = '$baseURL/auth/logout';
  static const String whoamiURL = '$baseURL/auth/whoami';
  static const String saveTaskUrl = '$baseURL/tasks/save-task';
  // // Metamask endpoints
  static const String backendURL = 'https://new.backend.dev.yalgamers.gg/';
  static const String wcProjectId = 'b8f6b7558b5302d8ff6a403f5286aa44';

  //////////////////////////// Tournament URL/////////////////////////////
  static const String tournamentBaseURL =
      'https://tournaments.backend.dev.yalgamers.gg';

  static const String tournamentApprovalURL =
      '$tournamentBaseURL/auth/authorize';

  static const String tournamentRefreshURL = '$tournamentBaseURL/auth/refresh';
}
