import 'dart:convert';

import 'package:http/http.dart' as http;

final client = http.Client();
final postUrl = 'https://fcm.googleapis.com/fcm/send';
final serverKey = "AAAAosStCvA:APA91bGi1ymfPdCOww50b96EgYIx7b_PzlZYeSNvqvrNqXRsUsM0U1MHzSOGWzWuEDaq27EFQp4oU3ks0oSf7mwbR7Zp3EFGuv_xJuIEHBxKDPb7jlhSjh0deibZ3aJENyGbNLRGsOEJ";

Future<bool> sendNotification(String title, String body, String token) async {
  final data = {
    "notification": {"body": body, "title": title},
    "priority": "high",
    "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "sound": "default",
    },
    "to": token
  };
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey'
  };

  final response = await client.post(
      postUrl,
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}