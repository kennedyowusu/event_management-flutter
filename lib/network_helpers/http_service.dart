import 'package:dio/dio.dart';
import 'package:event_management/model/event.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class HttpService {
  late Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: 'http://192.168.1.109:8000/api',
  );

  HttpService() {
    _dio = Dio(options);
  }

  /////////////////////////////////////////////////////////////////////////////

  //=====================================//
  //      Authentication Endpoints      //
  //===================================//

  Future<Map<String, dynamic>> signUserUp(
      Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        '${options.baseUrl}/register',
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      if (kDebugMode) {
        print(responseData);
        print(responseData['token']);
      } // Log the response data

      await GetStorage().write('token', responseData['token']);
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.statusCode);
        print(e.response?.data); // Log the error response data
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        '${options.baseUrl}/login',
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      if (kDebugMode) {
        print(responseData);
      }
      if (kDebugMode) {
        print(responseData['token']);
      }

      await GetStorage().write('token', responseData['token']);
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> logoutUser() async {
    try {
      Response response = await _dio.post(
        '${options.baseUrl}/logout',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      if (kDebugMode) {
        print(responseData);
      }

      await GetStorage().remove('token');
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  //=====================================//
  //      Events Endpoints              //
  //===================================//

  Future<List<EventModel>> fetchEvents() async {
    try {
      Response response = await _dio.get(
        '${options.baseUrl}/events',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      List<dynamic> responseData = response.data;
      if (kDebugMode) {
        print(responseData);
      }
      return responseData.map((json) => EventModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchEvent(String eventId) async {
    try {
      Response response = await _dio.get(
        '/event/$eventId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> saveEvent(Map<String, dynamic> eventData) async {
    try {
      Response response = await _dio.post(
        '/event/create',
        data: eventData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> updateEvent(
      String eventId, Map<String, dynamic> eventData) async {
    try {
      Response response = await _dio.post(
        '/event/$eventId/update',
        data: eventData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> deleteEvent(String eventId) async {
    try {
      Response response = await _dio.delete(
        '/event/$eventId/delete',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  //===============================//
  //      Tickets Endpoints       //
  //=============================//

  Future<Map<String, dynamic>> fetchTickets() async {
    try {
      Response response = await _dio.get(
        '/tickets',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> fetchTicket(String ticketId) async {
    try {
      Response response = await _dio.get(
        '/ticket/$ticketId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> saveTicket(
      Map<String, dynamic> ticketData) async {
    try {
      Response response = await _dio.post(
        '/ticket/create',
        data: ticketData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> updateTicket(
      String ticketId, Map<String, dynamic> ticketData) async {
    try {
      Response response = await _dio.post(
        '/ticket/$ticketId/update',
        data: ticketData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> deleteTicket(String ticketId) async {
    try {
      Response response = await _dio.delete(
        '/ticket/$ticketId/delete',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  //============================//
  //      Review Endpoints     //
  //=========================//

  Future<Map<String, dynamic>> fetchReviews(int eventId) async {
    try {
      Response response = await _dio.get(
        '/events/$eventId/reviews',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'error': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> fetchReview(String reviewId) async {
    try {
      Response response = await _dio.get(
        '/review/$reviewId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> saveReview(
      Map<String, dynamic> reviewData) async {
    try {
      Response response = await _dio.post(
        '/reviews',
        data: reviewData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> updateReview(
      String reviewId, Map<String, dynamic> reviewData) async {
    try {
      Response response = await _dio.post(
        '/review/$reviewId/update',
        data: reviewData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> deleteReview(String reviewId) async {
    try {
      Response response = await _dio.delete(
        '/review/$reviewId/delete',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  //=========================//
  //      User Endpoints     //
  //=========================//

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      Response response = await _dio.get(
        '/user/$userId', //ENDPOiNT URL
        //options: Options(headers: ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      print(e.response?.data);
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> saveUserData(
      String userId, Map<String, dynamic> userData) async {
    try {
      Response response = await _dio.post(
        '/user/$userId/update', //ENDPOiNT URL
        data: userData, //REQUEST BODY
        //options: Options(headers: ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      print(e.response?.data);
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }

  Future<Map<String, dynamic>> submitUserReview(
      Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        '/review',
        data: userData, //REQUEST BODY
        //options: Options(headers: ),
      );
      Map<String, dynamic> responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      print(e.response?.data);
      Map<String, dynamic> err = e.response?.data ??
          {'message': 'Unable to connect to server, please try again!'};
      return err;
    }
  }
}

  //============================//
  //      User Endpoints End    //
  //============================//
