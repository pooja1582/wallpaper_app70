import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaperapp/data/remote/app_exception.dart';
import 'package:wallpaperapp/data/remote/urls.dart';



class ApiHelper{

      Future<dynamic> getAPI({required String url, Map<String,String>? header})async{
        var uri = Uri.parse(url);
        try{
          var response = await http.get(uri,headers: header ?? {
             "Authorization": Urls.API_KEY
          });
          return _returnResponse(response);
        }on SocketException catch(e){
          throw FetchDataException(mBody: "Not Connected to Internet");
        }
      }

      dynamic _returnResponse(http.Response response){
        switch(response.statusCode){
          case 200:
            var responseJson = jsonDecode(response.body.toString());
            print(responseJson);
            return responseJson;
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            throw FetchDataException(mBody: "Error occurred while Communication with Server with StatusCode : ${response.statusCode}");
        }
      }

}