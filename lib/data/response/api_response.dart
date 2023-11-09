

import 'package:plant_ui/data/response/status.dart';

class ApiResponse<T> {

  Status? status;
  T? data;
  String? message;

  /// The code snippet is defining a generic class called `ApiResponse` with three
  /// properties: `status`, `data`, and `message`.
  ApiResponse(this.status , this.data , this.message);

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.complete(): status = Status.completed;

  ApiResponse.error(): status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message: $message \n Data: $data";
  }

}