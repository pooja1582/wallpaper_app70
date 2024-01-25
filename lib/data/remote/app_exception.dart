class AppException implements Exception{
  String title;
  String body;
  AppException({required this.body,required this.title});

  String toErrorMsg(){
    return "$title : $body";
  }
}


class FetchDataException extends AppException{
  FetchDataException({required String mBody}) : super(title: "Network Error" , body: mBody);
}

class BadRequestException extends AppException{
  BadRequestException([mBody]) : super(title: "Invalid Request" , body: mBody);
}

class UnauthorisedException extends AppException{
  UnauthorisedException([mBody]) : super(title: "Unauthorized " , body: mBody);
}

class InvalidInputException extends AppException{
  InvalidInputException([mBody]) : super(title: "Invalid Input" , body: mBody);
}