import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scanner/model/my_user.dart';

///////////////// base uri//////////////
//const baseUri = 'http://194.163.136.227:8087/api/';
const baseUri = 'http://194.163.136.227:8090/api/';

///////////////////////////////////////
///
class RemoteService {
  //////////////////////////////////
  ///initialisation du client http
  var client = http.Client();
  //////////////////////////////
  ///

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<MyUserModel?> getSingleUser({required int id}) async {
    var uri = Uri.parse(baseUri + 'visiteurs/$id');
    var response = await client.get(uri);
    print('my user Dans remote /////////////////////////// : ${response.body}');
    print('Dans remote////////////////////////////// : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      print(response.body);
      MyUserModel user = myUserModelFromJson(json);
      return user;
    }
    return null;
  }

  ////////////////////
  ///
  ///////////////// post user detail when otp code is verify//////////////////
  ///
  Future<dynamic> postUserDetails({
    required String api,
    //required MyUser user,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);

    /////////////// encode user to jsn //////////////////////
    // var payload = userToJson(user);

    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    //////////////// post user ////////////
    var response = await client.post(
      url,
      //body: payload,
      headers: headers,
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 422) {
      //var result = jsonDecode(response.body);
      /* if (result.containsKey("email")) {
        return 'emailError';
      } */
      return null;
    }
  }

  /////////////
  ///
  /////////////////////////////////// edit totine /////////////////////
  ///
  ///
  Future<dynamic> putUser({
    required String api,
    required Map<String, dynamic> data,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    //var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = jsonEncode(data);
    // http request headers
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await client.put(url, body: payload, headers: headers);
    print(
        '---------------------------------///////////////////${response.statusCode}');
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      //print('puuuuut : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }
}
