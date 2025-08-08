import 'dart:convert';
import 'dart:developer';

import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/constants/tournament_token_service.dart';
import 'package:yalgamers/core/secrets/app_secrets.dart';
import 'package:yalgamers/feature/tournament/data/model/tournament_token_model.dart';

Future<void> authorizeWithTournamentService() async {
  final accessToken = await TokenService.getAccessToken();
  final refreshToken = await TokenService.getRefreshToken();
  final user = await TokenService.getUser();

  if (accessToken == null || refreshToken == null || user == null) {
    throw Exception('Missing accessToken, refreshToken or user data');
  }

  const url = AppUrls.tournamentApprovalURL;

  final body = {
    "accesstoken": accessToken,
    "refreshToken": refreshToken,
    "userId": user['id'],
    "username": user['name'],
    "uid": user['uid'],
  };

  final response = await TokenService.post(url, body);

  log("Tournament auth response: ${response.statusCode} => ${response.body}");

  if (response.statusCode != 201) {
    throw Exception('Tournament authorization failed: ${response.body}');
  }

  final Map<String, dynamic> responseJson = jsonDecode(response.body);
  final tournamentData = TournamentAuthModel.fromJson(responseJson);

  await TournamentTokenService.saveTournamentTokensAndUser(
    accessToken: tournamentData.accessToken,
    refreshToken: tournamentData.refreshToken,
    user: tournamentData.user.toJson(),
  );
}
