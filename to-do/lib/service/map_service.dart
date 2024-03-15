import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  String baseUrl = 'http://localhost:9999/api/v1/task';

  // POST
  Map<String, dynamic> requestBody = {
    'description': 'task description 444',
    'date': '2019-01-01T00:00:00Z',
    'labelIds': [1, 2]
  };
  String authToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ3d3cudWNiLmVkdS5ibyIsIm5hbWUiOiJKdWFuIFBlcmV6IiwidHlwZSI6IkFVVEgiLCJleHAiOjE2ODI0Njg3MzUsInVzZXJJZCI6MTAwfQ.MU8q2NkqCgtGMxQGHggcuBR8J9tlSSCNQBJa7q3CTsk';

  http
      .post(Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
          body: jsonEncode(requestBody))
      .then((response) => print(response.body));

  // GET all
  http.get(Uri.parse(baseUrl), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  }).then((response) => print(response.body));

  // GET by id
  int taskId = 2;
  http.get(Uri.parse('$baseUrl/$taskId'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  }).then((response) => print(response.body));

  // PUT
  int taskToUpdate = 2;
  Map<String, dynamic> updatedTaskData = {
    'description': 'TArea actualizada',
    'date': '2019-01-01T00:00:00Z',
  };
  http
      .put(Uri.parse('$baseUrl/$taskToUpdate'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
          body: jsonEncode(updatedTaskData))
      .then((response) => print(response.body));

  // HEAD
  http.head(Uri.parse(baseUrl), headers: {
    'Authorization': 'Bearer $authToken',
  }).then((response) => print(response.headers));
}
