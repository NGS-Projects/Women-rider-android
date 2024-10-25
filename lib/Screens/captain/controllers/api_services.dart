import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';

// import 'package:dio/dio.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:womentaxi/untils/export_file.dart';

class ApiService extends GetxService {
  // String baseUrl = "https://womenrapido.nuhvin.com/";
  // String baseUrl = "https://women-rapido.vercel.app/"; //local
  String baseUrl = "https://womenrapido.nuhvin.com/"; // main
  // String baseUrl = "http://192.168.1.198:5050/"; //local
  // UserApiController userapicontroller = Get.put(UserApiController());
  //    http://192.168.1.197:5050
  // String baseUrl = "http://192.168.1.197:5050/"; // main
  String VerificationUrl = "https://uat-hub.perfios.com/api/kyc/"; // main
  // https://uat-hub.perfios.com/api/kyc/v3/dl
  // https://uat-hub.perfios.com/api/kyc/v2/rc
// https://uat-hub.perfios.com/api/kyc/v3/pan-profile-detailed
  final errorDict = {
    "data": [
      {"error": "Please check your internet connection."}
    ],
    "status": "error"
  };
  Future putRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.put("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  String imagebaseUrl = "http://43.205.34.80:8001/";
  Future putProfileRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var response = await http.put(url, headers: header, body: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////
  Future patchRequestEditProfile({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'profilePic',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future patchRequestConvert({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// (File license, File pan, File adhar,
//       File authenticationImage, File rc)
  /////////////////////////////Upload DOcs Captain
  Future patchRequestUploadDocs({
    required File license,
    required File authenticationImage,
    required File rc,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'license',
        license.path,
        contentType: MediaType('image', 'png'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        authenticationImage.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'rc',
        rc.path,
        contentType: MediaType('image', 'png'),
      ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  Future patchRequestUploadVrefiDocs({
    required File pan,
    required File adhar,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'pan',
        pan.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

////////////////////////////////////////////////////////
  Future signuppatchRequestUploadVrefiAdhaar({
    required File adhar,
    required File adharBack,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'], adharBack
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'adharBack',
        adharBack.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

////////////////////////////////////////////////////
  Future patchRequestUploadVrefiAdhaar({
    required File adhar,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future patchRequestUploadVrefipan({
    required File pan,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'pan',
        pan.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////

  ///////////////////User Upload DOcs
  Future patchRequestUserUploadDocs({
    required File authenticationImage,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        authenticationImage.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////CaptainDutyAPi///////////////////////////
  Future patchRequestCaptainDuty({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'captainLiveImage',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////////////

  //////////
  ///
  Future patchRequestEditProfilebank({
    required File profilePic,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}'
        ..fields['bloodBankName'] = payload['bloodBankName'];
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profilePic.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///Post  request form data
  Future postRequestDonorSignupFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('POST', url)
        // ..headers['Authorization'] =
        //     'Bearer ${UserSimplePreferences.getToken()}'  // termsAndCondition
        ..fields['name'] = payload['name']
        ..fields['mobile'] = payload['mobile']
        ..fields['gender'] = payload['gender']
        ..fields['role'] = payload['role']
        ..fields['uniqueKey'] = payload['uniqueKey']
        ..fields['dateOfBirth'] = payload['dateOfBirth']
        ..fields['email'] = payload['email']
        ..fields['longitude'] = payload['longitude']
        ..fields['latitude'] = payload['latitude']
        ..fields['address'] = payload['address']
        ..fields['personalContact'] = payload['personalContact']
        ..fields['termsAndCondition'] = payload['termsAndCondition'];

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///////////////////////////////////NewSign UP
  Future NewSignupFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('POST', url)
        // ..headers['Authorization'] =
        //     'Bearer ${UserSimplePreferences.getToken()}'  // termsAndCondition
        ..fields['name'] = payload['name']
        ..fields['mobile'] = payload['mobile']
        ..fields['role'] = payload['role']
        ..fields['dateOfBirth'] = payload['dateOfBirth']
        ..fields['email'] = payload['email']
        ..fields['longitude'] = payload['longitude']
        ..fields['latitude'] = payload['latitude']
        ..fields['address'] = payload['address'];

////////////////////////////////////////////////

//////////////////////
      request.files.add(await http.MultipartFile.fromPath(
        'profilePic',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else if (response.statusCode == 400) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

///////////////////////
//{
  // "dropLangitude": "17.413973667114202",
//  "dropLongitude": "78.37360815684931",
  // "pickupLangitude": "17.419151642685726",
  // "pickupLongitude": "78.3889548353466",
//  "pickupAddress": "Raidurg",
  // "dropAddress": "Sutherland",
  // "price": "250",
  // "orderPlaceTime": "08:09 AM",
  // "orderPlaceDate": "04-07-2024",
  // "vehicleType": "bike"
//}
///////////////////
  // UserBookRide with Image
  ////////////////////////////////////////////////////////////////////////////////////////

  Future postRequestUserBookFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    required String token,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['dropLangitude'] = payload['dropLangitude']
        ..fields['dropLongitude'] = payload['dropLongitude']
        ..fields['pickupLangitude'] = payload['pickupLangitude']
        ..fields['pickupLongitude'] = payload['pickupLongitude']
        ..fields['pickupAddress'] = payload['pickupAddress']
        ..fields['dropAddress'] = payload['dropAddress']
        ..fields['price'] = payload['price']
        ..fields['orderPlaceTime'] = payload['orderPlaceTime']
        ..fields['orderPlaceDate'] = payload['orderPlaceDate']
        ..fields['vehicleType'] = payload['vehicleType'];

      request.files.add(await http.MultipartFile.fromPath(
        'userAuthenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      // Add the token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add custom headers if any
      if (customHeaders != null) {
        request.headers.addAll(customHeaders);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        debugPrint('Failed to update profile: ${response.reasonPhrase}');
        debugPrint('Response body: ${response.body}');
        return {"message": "Failed to update profile"};
      }
    } catch (e) {
      debugPrint("$e");
      if (e is DioError) {
        if (e.response?.statusCode == 404) {
          return e.response?.data;
        } else if (e.response?.statusCode == 401) {
          return e.response?.data;
        } else if (e.response?.statusCode == 400) {
          return e.response?.data;
        } else {
          return {"message": "Something went wrong!"};
        }
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////
  Future postRequestUserBookFormDatatime({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    required String token,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['dropLangitude'] = payload['dropLangitude']
        ..fields['dropLongitude'] = payload['dropLongitude']
        ..fields['pickupLangitude'] = payload['pickupLangitude']
        ..fields['pickupLongitude'] = payload['pickupLongitude']
        ..fields['pickupAddress'] = payload['pickupAddress']
        ..fields['dropAddress'] = payload['dropAddress']
        ..fields['price'] = payload['price']
        ..fields['orderPlaceTime'] = payload['orderPlaceTime']
        ..fields['orderPlaceDate'] = payload['orderPlaceDate']
        ..fields['time'] = "12:12"
        ..fields['vehicleType'] = payload['vehicleType'];

      request.files.add(await http.MultipartFile.fromPath(
        'userAuthenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      // Add the token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add custom headers if any
      if (customHeaders != null) {
        request.headers.addAll(customHeaders);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        debugPrint('Failed to update profile: ${response.reasonPhrase}');
        debugPrint('Response body: ${response.body}');
        return {"message": "Failed to update profile"};
      }
    } catch (e) {
      debugPrint("$e");
      if (e is DioError) {
        if (e.response?.statusCode == 404) {
          return e.response?.data;
        } else if (e.response?.statusCode == 401) {
          return e.response?.data;
        } else if (e.response?.statusCode == 400) {
          return e.response?.data;
        } else {
          return {"message": "Something went wrong!"};
        }
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////
  // Future postRequestUserBookFormData({
  //   required File image,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   //   //   'first_name': payload['firstName'],
  //   //   //   'last_name': payload['lastName'],
  //   try {
  //     var request = http.MultipartRequest('POST', url)

  //       ..fields['dropLangitude'] = payload['dropLangitude']
  //       ..fields['dropLongitude'] = payload['dropLongitude']
  //       ..fields['pickupLangitude'] = payload['pickupLangitude']
  //       ..fields['pickupLongitude'] = payload['pickupLongitude']
  //       ..fields['pickupAddress'] = payload['pickupAddress']
  //       ..fields['dropAddress'] = payload['dropAddress']
  //       ..fields['price'] = payload['price']
  //       ..fields['orderPlaceTime'] = payload['orderPlaceTime']
  //       ..fields['orderPlaceDate'] = payload['orderPlaceDate']
  //       ..fields['vehicleType'] = payload['vehicleType'];

  //     request.files.add(await http.MultipartFile.fromPath(
  //       'userAuthenticationImage',
  //       image.path,
  //       contentType: MediaType('image', 'png'), // or other image type
  //     ));

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     }
  //     // else {
  //     //   print('Failed to update profile: ${response.reasonPhrase}');
  //     //   print('Response body: ${response.body}');
  //     // }
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //     // var header = {
  //     //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
  //     // };
  //     // var response = await http.patch(url, headers: header, body: payload);
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  ///

  //]
  Future postRequestDonorSignupFormDatabloodBank({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('POST', url)
        // ..headers['Authorization'] =
        //     'Bearer ${UserSimplePreferences.getToken()}'
        ..fields['bloodBankName'] = payload['bloodBankName']
        // ..fields['lastName'] = payload['lastName']
        ..fields['mobile'] = payload['mobile']
        ..fields['email'] = payload['email']
        // ..fields['dateOfBirth'] = payload['dateOfBirth']
        // ..fields['bloodGroup'] = payload['bloodGroup']
        // ..fields['gender'] = payload['gender']
        // ..fields['locations'] = payload['locations']
        ..fields['address'] = payload['address']
        ..fields['longitude'] = payload['longitude']
        ..fields['latitude'] = payload['latitude']
        // ..fields['signupTime'] = payload['signupTime']
        ..fields['termAndCondition'] = payload['termAndCondition'];

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //

  //////////
  //  var request = http.MultipartRequest('PATCH', url)
  //     ..headers['Authorization'] = 'Bearer $authToken'
  //     ..fields['first_name'] = firstName
  //     ..fields['last_name'] = lastName;

  //   // Add the profile picture file
  //   if (profilePic != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'profile_pic',
  //       profilePic.path,
  //       contentType: MediaType('image', 'jpeg'), // or other image type
  //     ));
  //   }

  //   // Send the request
  //   var response = await request.send();
  ////////

  Future postRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// DonorRegister
  Future postRequestDonorRegister({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = '*/*';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // Postno Token

  Future<Map<String, dynamic>> postRequestNotoken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint
        // "http://womenrapido.nuhvin.com/auth/send-otp"
        ); // Replace with your baseUrl + endpoint if needed

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(payload),
      );

      // Handle 301 status code
      if (response.statusCode == 301 || response.statusCode == 302) {
        String? newUrl = response.headers['location'];
        if (newUrl != null) {
          url = Uri.parse(newUrl);
          response = await http.post(
            url,
            headers: headers,
            body: json.encode(payload),
          );
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return handleError(response);
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

  Map<String, dynamic> handleError(http.Response response) {
    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      return {"message": "Something went wrong!"};
    }
  }

//   import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

  // Future<Map<String, dynamic>> postRequestNotoken({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(
  //       "http://womenrapido.nuhvin.com/auth/send-otp/"); // Replace with your baseUrl + endpoint if needed

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   if (customHeaders != null) {
  //     headers.addAll(customHeaders);
  //   }

  //   try {
  //     var response = await http.post(
  //       url,
  //       headers: headers,
  //       body: json.encode(payload),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return json.decode(response.body);
  //     } else {
  //       return handleError(response);
  //     }
  //   } catch (e) {
  //     debugPrint("$e");
  //     return {"message": "Something went wrong!"};
  //   }
  // }

  // Map<String, dynamic> handleError(http.Response response) {
  //   if (response.statusCode == 404 ||
  //       response.statusCode == 401 ||
  //       response.statusCode == 400) {
  //     return json.decode(response.body);
  //   } else {
  //     return {"message": "Something went wrong!"};
  //   }
  // }

  Future postRequestNotokentwo({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //PostToken
  Future postRequestToken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.post("$url",
          //  "https://blood-server-us7o.onrender.com/auth/registor/donor",
          data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////////////Verify Docs

  //PostToken
  Future postRequestTokenVerifyDocs({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(VerificationUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["x-auth-key"] = "q4Ewu5OELeimuoiS";

      var response = await dio.post("$url",
          //  "https://blood-server-us7o.onrender.com/auth/registor/donor",
          data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // Post patch

  // Future patchRequestEditProfile({
  //   required File profilePic,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   try {

  //   //   Dio dio = Dio();

  //   //   dio.options.headers["content-type"] = 'application/json';
  //   //   dio.options.headers["accept"] = 'application/json';
  //   //   String fileName = profilePic.path.split('/').last;

  //   // FormData formData = FormData.fromMap({
  //   //   "profile_image": await MultipartFile.fromFile(
  //   //     file.path,
  //   //     filename: fileName,
  //   //   ),
  //   // });
  //   // //   FormData formData = FormData.fromMap({
  //   //   'first_name': payload['firstName'],
  //   //   'last_name': payload['lastName'],
  //   //   'image': await MultipartFile.fromBytes(
  //   //     'image', // Field name
  //   //     profilePic.readAsBytes(),
  //   //     filename: fileName, // Specify the filename
  //   //     contentType: MediaType('image', 'jpg'), // Set the content type
  //   //   ),
  //   // });
  //     // FormData formData = FormData();
  //     // formData.fields
  //     //   ..add(MapEntry('first_name', payload["firstName"]))
  //     //   ..add(MapEntry('last_name', payload["lastName"]));
  //     // formData.files.add(MapEntry(
  //     //   'image',
  //     //   await MultipartFile.fromFile(profilePic.path, filename: fileName),
  //     // )
  //     // );

  //    // var response = await dio.patch("$url", data: payload);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }
  // ///////////////////

  //     FormData formData = FormData();
  //     formData.fields
  //       ..add(MapEntry('first_name', firstName))
  //       ..add(MapEntry('last_name', lastName));
  //     formData.files.add(MapEntry(
  //       'profile_pic',
  //       await MultipartFile.fromFile(profilePic.path, filename: fileName),
  //     ));

  //     Response response = await _dio.patch('/users/$userId', data: formData);

  // ////////////
  Future patchRequestList({
    required String endpoint,
    required List payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //

  Future patchRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.patch("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // PatchRequestNo Payload
  Future patchRequestNopayload({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.patch("$url");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // post like
  Future postlikeRequest({
    required String endpoint,
    //  required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future deleteRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.delete("$url");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future<dynamic> postAuthRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var response = await http.post(url, body: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else if (response.statusCode == 404) {
        return response.body;
      } else if (response.statusCode == 401) {
        return response.body;
      } else if (response.statusCode == 400) {
        return response.body;
      } else if (response.statusCode == 500) {
        return response.body;
      } else {
        return {"message": "Something went wrong!"};
      }
    } on DioError catch (e) {
      debugPrint("$e");
      return {"message": "$e"};
    }
  }

  //

// Get Token
/////////////////////////////////////////////////////////////////////////////////

  Future<dynamic> getter({
    required String endpoint,
  }) async {
    Uri url = Uri.parse(
        baseUrl + endpoint); // Replace with your baseUrl + endpoint if needed

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSimplePreferences.getToken()}'
    };

    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      // Handle 301 status code
      if (response.statusCode == 301 || response.statusCode == 302) {
        String? newUrl = response.headers['location'];
        if (newUrl != null) {
          url = Uri.parse(newUrl);
          response = await http.get(
            url,
            headers: headers,
          );
        }
      }

      if (response.statusCode == 200) {
        return json.decode(response.body);
        // return json.decode(response.body);
      } else {
        return handleGetError(response);
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

  Map<String, dynamic> handleGetError(http.Response response) {
    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      return {"message": "Something went wrong!"};
    }
  }

//////////////////////////////////////////////
  Future<dynamic> getRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}',
        // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI5MzgxMDIyNTU4IiwiaWF0IjoxNzI3MTc4ODgyfQ._6eQ7xJgsoL6PY4wYIDe6gcOTC1bepbm0TBWEhy85t8',
        "accept": 'application/json'
      };
      var response = await http.get(url, headers: header);
      // var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // GetNoToken
  Future<dynamic> getRequestNoToken({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var response = await http.get(url);
      // var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future<dynamic> postreportRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
    required Map<dynamic, dynamic> payload,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var response = await http.post(url, body: payload, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static updateProfilePhoto(File file) {}
  Future<dynamic> putForProfileUpdateRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
    File? image,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var headers = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var request = http.MultipartRequest('PUT', Uri.parse(baseUrl + endpoint));
      request.fields.addAll({
        'full_name': payload["full_name"],
        'phone': payload["phone"],
        'gender': payload["gender"],
        'constituency': payload["constituency"]
      });
      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return {"status": "Updated"};
      } else {
        return ({"message": response.reasonPhrase});
      }
    } on DioError catch (e) {
      return {"message": "$e"};
    }
  }

  Future<dynamic> postReportRequest(
      {required String endpoint,
      required Map<dynamic, dynamic> payload,
      Map<String, String>? customHeaders,
      File? problem,
      File? salefe}) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var headers = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint));
      request.fields.addAll({
        'full_name': payload["full_name"],
        'email': payload["email"],
        'mobile_no': payload["mobile_no"],
        'pincode': payload["pincode"],
        'city': payload["city"],
        'state': payload["state"],
        'address': payload["address"],
        'report': payload["report"],
      });
      if (problem != null) {
        request.files.add(
            await http.MultipartFile.fromPath('report_image', problem.path));
      }
      if (salefe != null) {
        request.files.add(
            await http.MultipartFile.fromPath('reporter_selfie', salefe.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return {"status": "Updated"};
      } else {
        return ({"message": response.reasonPhrase});
      }
    } on DioError catch (e) {
      return {"message": "$e"};
    }
  }
}
