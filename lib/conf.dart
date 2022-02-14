// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const url = 'http://10.0.3.2:8000/api/';
// online url using ngrok
//const url = 'http://6125-41-105-43-1.ngrok.io/api/';

Map<String, String> headers(String token) {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
}

class Tasks {
  var token = GetStorage().read('token');

  Future getdata() async {
    if (token != null) {
      http.Response response =
          await http.get(Uri.parse(url + 'tasks'), headers: headers(token));
      try {
        if (response.statusCode == 200) {
          return response.body;
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return e.toString();
      }
    }
  }

  Future get_task_state() async {
    if (token != null) {
      http.Response response = await http.get(Uri.parse(url + 'state_task'),
          headers: headers(token));
      try {
        if (response.statusCode == 200) {
          return response.body;
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return e.toString();
      }
    }
  }

  Future insert_state() async {
    if (token != null) {
      var fullurl = url + 'creat_state_task';
      http.Response response = await http.get(
        Uri.parse(fullurl),
        headers: headers(token),
      );

      try {
        print(response.statusCode);
        if (response.statusCode == 200) {
          return response.body;
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return e.toString();
      }
    }
  }

  Future insert_data(requestBody) async {
    if (token != null) {
      var fullurl = url + 'add_task';
      http.Response response = await http.post(
        Uri.parse(fullurl),
        headers: headers(token),
        body: json.encode(requestBody),
      );
      try {
        if (response.statusCode == 200) {
          return response.body;
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return e.toString();
      }
    }
  }

  Future task_complited(id) async {
    var fullurl = url + 'complited_tasks/$id';
    http.Response response = await http.put(
      Uri.parse(fullurl),
      headers: headers(token),
    );
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future delet_Tasks(id,iscomplited) async {
    
    var fullurl = url + 'delet_tasks/$id/$iscomplited';
    http.Response response = await http.delete(
      Uri.parse(fullurl),
      headers: headers(token),
      
    );
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future register(String password, String email, String name) async {
    var fullurl = url + 'register';
    print(email);
    print(password);
    print(name);
    http.Response response = await http.post(Uri.parse(fullurl), body: {
      'email': email,
      'password': password,
      'password_confirmation': password,
      'name': name
    }, headers: {
      'Accept': 'application/json',
    });
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future login(
    String password,
    String email,
  ) async {
    var fullurl = url + 'login';
    http.Response response = await http.post(Uri.parse(fullurl), body: {
      'email': email,
      'password': password,
    }, headers: {
      'Accept': 'application/json',
    });
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future logout() async {
    print(token);
    if (token != null) {
      var fullurl = url + 'logout';
      http.Response response = await http.get(
        Uri.parse(fullurl),
        headers: headers(token),
      );
      try {
        if (response.statusCode == 200) {
          GetStorage().remove('token');
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return e.toString();
      }
    }
  }

  Future get_user() async {
    print(token);
    if (token != null) {
      var fullurl = url + 'username';
      http.Response response = await http.get(
        Uri.parse(fullurl),
        headers: headers(token),
      );
      try {
        if (response.statusCode == 200) {
          return response.body;
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return e.toString();
      }
    }
  }
}
