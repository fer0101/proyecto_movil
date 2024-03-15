import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> postLabel() async {
  final url = Uri.parse('http://localhost:9999/api/v1/label');
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ3d3cudWNiLmVkdS5ibyIsIm5hbWUiOiJKdWFuIFBlcmV6IiwidHlwZSI6IkFVVEgiLCJleHAiOjE2ODI0Njg3MzUsInVzZXJJZCI6MTAwfQ.MU8q2NkqCgtGMxQGHggcuBR8J9tlSSCNQBJa7q3CTsk'
  };
  final body = json.encode({'name': 'Hobby', 'date': '2019-01-01T00:00:00Z'});
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // La solicitud se completó correctamente.
  } else {
    // Ocurrió un error al realizar la solicitud.
  }
}
