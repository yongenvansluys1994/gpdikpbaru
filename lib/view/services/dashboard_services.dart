// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';

class GetAccess {
  String accessToken = '';
  DateTime? accessTokenExpiry;

  Future<void> getAccessTokenFirebase() async {
    try {
      // Load the service account JSON file
      final serviceAccountJson = await rootBundle.loadString(
        'assets/gpdiphiladelphia-firebase-adminsdk.json',
      );

      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountJson),
      );

      const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client = http.Client();

      try {
        // Obtain access credentials
        final accessCredentials =
            await obtainAccessCredentialsViaServiceAccount(
          accountCredentials,
          scopes,
          client,
        );

        accessToken = accessCredentials.accessToken.data;
        accessTokenExpiry = accessCredentials.accessToken.expiry;

        final box = GetStorage();
        await box.write("token_access", accessToken);
        await box.write("token_expiry", accessTokenExpiry?.toIso8601String());

        print("Token obtained: $accessToken, expires at: $accessTokenExpiry");
      } catch (e) {
        print('Error obtaining access token: $e');
      } finally {
        client.close();
      }
    } catch (e) {
      print('Error loading service account JSON: $e');
    }
  }

  Future<void> checkAndRefreshToken() async {
    final box = GetStorage();

    // Load saved token and expiry date
    accessToken = box.read("token_access") ?? '';
    final expiryString = box.read("token_expiry");
    accessTokenExpiry =
        expiryString != null ? DateTime.parse(expiryString) : null;

    // Check if token is expired or not available
    if (accessToken.isEmpty ||
        accessTokenExpiry == null ||
        DateTime.now().isAfter(accessTokenExpiry!)) {
      print("Token expired or not found, requesting new token...");
      await getAccessTokenFirebase(); // Fetch new token
    } else {
      print("Token is still valid.");
    }
  }
}
