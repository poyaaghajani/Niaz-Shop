import 'package:dio/dio.dart';

class AppException implements Exception {
  final message;
  Response? response;

  AppException({required this.message, this.response});
}

class ServerException extends AppException {
  ServerException({String? message})
      : super(message: message ?? "مشکلی در سرور پیش آمده");
}

class NotFoundException extends AppException {
  NotFoundException({String? message})
      : super(message: message ?? "صفحه مورد نظر شما یافت نشد");
}

class DataParsingException extends AppException {
  DataParsingException({String? message})
      : super(message: message ?? "خطایی در مدل سازی به وجود آمده");
}

class BadRequestException extends AppException {
  BadRequestException({String? message, Response? response})
      : super(
            message: message ?? "مشکلی در نمایش دیتا پیش آمده",
            response: response);
}

class FetchDataException extends AppException {
  FetchDataException({String? message})
      : super(message: message ?? "لطفا اینترنت خود را چک کنید");
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message})
      : super(message: message ?? "توکن شما منقضی شده است");
}
