// import 'dart:convert';

// import 'package:womentaxi/untils/export_file.dart';

// class Controller extends GetxController {
//   var duty = "OFF DUTY".obs;
// }
import 'dart:convert';
import 'dart:io';

import 'package:womentaxi/untils/export_file.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:womentaxi/untils/export_file.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
StatusTimerController statustimercontroller = Get.put(StatusTimerController());
ApiController apicontroller = Get.put(ApiController());

class UserApiController extends GetxController {
  final apiService = Get.put(ApiService());
  var duty = "OFF DUTY".obs;
  var bioMetricImage = "".obs;
  // var capturedimageFile = Rxn<File>().obs;
  var capturedimageFile = Rxn<File>();
  ///////////Counter
  ///
  ///
  ///
  ///
  ///
  var urlbaseImage = "".obs;
  var filebaseImage = "".obs;

  ////////////////
  var counter = 10.obs;
  var bankfilterbg = "A+".obs;
  var receiverfilterbg = "A+".obs;
  var donorfilterbg = "A+".obs;
  var totalDistanceStr = "".obs;
  var totalTimeStr = "".obs;

  void increment() {
    counter.value += 5;
  }

  void decrement() {
    counter.value -= 5;
  }

  ///DonorsCounter
  var donorcounter = 10.obs;

  void donorincrement() {
    donorcounter.value += 5;
  }

  void donordecrement() {
    donorcounter.value -= 5;
  }

  //ReceiversCounter
  var receivercounter = 10.obs;

  void receiverincrement() {
    receivercounter.value += 5;
  }

  void receiverdecrement() {
    receivercounter.value -= 5;
  }

  ///////////
  ///
  TextEditingController donorHealthreasonController = TextEditingController();

  ///Blood Bank fields
  TextEditingController BloodBankNameController = TextEditingController();
  TextEditingController BloodBankMobileController = TextEditingController();
  TextEditingController BloodBankEmailController = TextEditingController();
  TextEditingController BloodBankLongitudeController = TextEditingController();
  TextEditingController BloodBankLatitudeController = TextEditingController();
  TextEditingController BloodBankAddressController = TextEditingController();

  ///

  TextEditingController loginMobileController = TextEditingController();

  // Edit Profile
  TextEditingController editDonorfirstNameController = TextEditingController();
  TextEditingController editDonorLastNameController = TextEditingController();
  TextEditingController editBloodBankNameController = TextEditingController();
  TextEditingController editBloodBankEmailController = TextEditingController();
  TextEditingController editBloodBanklocationsController =
      TextEditingController();
  TextEditingController editBloodBankstartTimeController =
      TextEditingController();
  TextEditingController editBloodBankendTimeController =
      TextEditingController();
  ////////////////
  //  "email": authentication
  //                                 .editBloodBankNameController.text,
  //                             "locations": authentication
  //                                 .editBloodBankNameController.text,
  //                             "startTime": authentication
  //                                 .editBloodBankNameController.text,
  //                             "endTime": authentication
  //                                 .editBloodBankNameController.text,
  ////////////

  ///
  final address = ''.obs;

  void updateAddress(String newAddress) {
    address.value = newAddress;
  }

  //////////////////////
//  {
//   "firstName" : "Prem",
  TextEditingController registerDonorfirstNameController =
      TextEditingController();
//   "lastName" : "RRR",
  TextEditingController registerDonorlastNameController =
      TextEditingController();
//   "mobile" : "3131313131",
  TextEditingController registerDonorMobileController = TextEditingController();
//   "email" : "vamsidigamarthi03@gmail.com",
  TextEditingController registerDonorEmailController = TextEditingController();
//   "bloodGroup" : "B+",
  TextEditingController registerDonorBloodController = TextEditingController();
  TextEditingController registerDonorAddressController =
      TextEditingController();
  var donorRegisterBloodGroup = "".obs;
  var donorRegisterGender = "".obs;
  var donorRegistersGender = "".obs;
  var findDonorBloodGroup = "".obs;
  var findDonorRequesttype = "".obs;
  var ridebookTime = "".obs;
  var todayName = "Monday".obs;

  ///////////////////////////////////////////
  var isBloodCardSelected = false.obs;
  var selectedBloodCardIndex = 0.obs;
  //
//   "dateOfBirth" : "08/05/1999",
  TextEditingController registerDonorDateofBirthController =
      TextEditingController();
//   "location" : "Palakollu",
  TextEditingController registerDonorDateofLocationController =
      TextEditingController();
//   "longitude" :81.6497616,
  TextEditingController registerDonorlongitudeLocationController =
      TextEditingController();
//   "latitude" : 16.5196953
  TextEditingController registerDonorlatitudeLocationController =
      TextEditingController();
// }
  ////////////////////
  ///
  ///find donor
//   {
//   "patientFirstName" : "Maniraj",
  TextEditingController findDonorpatientFirstNameController =
      TextEditingController();
//   "patientLastName" : "Mamamma amma",
  TextEditingController findDonorpatientLastNameController =
      TextEditingController();
//   "attendeeFirstName" : "Jalayyaa",
  TextEditingController findDonorattendeeFirstNameController =
      TextEditingController();
//   "attendeeLastName" : "manapathijj",
  TextEditingController findDonorattendeeLastNameController =
      TextEditingController();
//   "attendeeMobile" : "2121219821",
  TextEditingController findDonorattendeeMobileController =
      TextEditingController();
//   "bloodGroup" : "B+",
  TextEditingController findDonorBloodController = TextEditingController();
//   "requestType" : "Blood",
  TextEditingController findDonorRequestTypeMobileController =
      TextEditingController();
//   "quantity" : "200ml",
  TextEditingController findDonorquantityController = TextEditingController();
  TextEditingController ApquantityController = TextEditingController();
  TextEditingController AnquantityController = TextEditingController();
  TextEditingController bpquantityController = TextEditingController();
  TextEditingController bnquantityController = TextEditingController();
  TextEditingController opquantityController = TextEditingController();
  TextEditingController onquantityController = TextEditingController();
  TextEditingController abpquantityController = TextEditingController();
  TextEditingController abnquantityController = TextEditingController();
  TextEditingController findDonorHospitalController = TextEditingController();

//   "requiredDate" : "1/12/23",
  TextEditingController findDonorrequiredDateController =
      TextEditingController();
//   "nameOfLocation" : "Kukatpally",
//   "longitude" :81.4749409,
//   "latitude" :16.5433508
// }
  ///

  TextEditingController fullnameProfileController = TextEditingController();
  TextEditingController mobileProfileController = TextEditingController();
  TextEditingController emailProfileController = TextEditingController();
  var gender = "".obs;
  var selectedRegister = "donor".obs;
  var enSearch = false.obs;
  var timerOn = false.obs;
  var fcmToken = "".obs;
  var dropdownvalue = "Select Region".obs;
  var isLanguage = "Telugu".obs;
  var acceptSignupCondition = false.obs;
  enableSearch(bool value) {
    enSearch(value);
  }

// Language
//     Obx(() =>  isLanguage == "Telugu"
// ? "login"
// :"login in english")
////////////////////////////////////////////////////////////////////////////////////////////

  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _currentAddress;
  String? _currentAddresspincode;
  var isLoadings = false.obs;
  var isLoading = "none";
  var otpLoading = false.obs;
  var resortsloading = false.obs;
  var resortsData = [].obs;
  var originalresortsList = [].obs;
  var dynamicresortsList = [].obs;
  var userCurrentLocationLatitude = "".obs;
  var userCurrentLocationLongitude = "".obs;
  var range = 10.obs;

  var phoneVerification = 0.obs;

  //GetReciversList
  var receiversdataLoading = false.obs;

///////////////
  var assetsData = [].obs;
  var reciversDatafilter = [].obs;

  var OriginalreciversData = [].obs;
///////////////

  ////////////Distance of Banks
  var distanceInKilometers = 0.0.obs;

  var dropdistanceInKilometers = 0.0.obs;

  ////  Get Banks List
  var bankListLoading = false.obs;

  /////////////////////////////

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else {
        if (isPermissionGiven != true) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Denined Location Will Failed To Upload Attendance",
          );
        }
      }
    } else {
      isPermissionGiven = true;
    }
    isLoading = "ended";

    return await Geolocator.getCurrentPosition();
  }

  bool isPermissionGiven = false;

  static const kEmbedMapApiKey = "AIzaSyDoRPQVkZ38v6_wsH-xjcKRuiDrPanMKqU";
  ////////////////////////////////////////////////////////////////////////////////////////////////////for image
  var assetImagePath = "assets/images/sunraylogo.png".obs;
  var activeassetLoading = false.obs;

////Blood Apis////////////////////// Blood donor
////////////////////////////////
  ///BloodBankRegister
  var registerBloodbankLoading = false.obs;

  var registerBloodbankMobileEntered = "".obs;
  Future<void> bloodBankRegister(Map payload) async {
    registerBloodbankLoading(true);
    registerBloodbankMobileEntered.value = payload["mobile"];

    try {
      var response = await apiService.postRequestNotoken(
          //   var response = await apiService.postAuthRequest(

          endpoint: "auth/blood/bank",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] != "Registration Successfully ..!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: "Registered Successfully",
        );
        var bloodbankpayloads = {
          "mobile": registerBloodbankMobileEntered.value,
          //  "8297297247"
        };

        //  logins(bloodbankpayloads);
        //  Get.toNamed(kSignInScreen)
        //   Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      registerBloodbankLoading(false);
    }
  }

  /////////////BloodBank Register With Image

  Future<void> bloodBankRegisterwithImage(Map payload, File file) async {
    registerBloodbankLoading(true);
    registerBloodbankMobileEntered.value = payload["mobile"];

    try {
      //
      var response = await apiService.postRequestDonorSignupFormDatabloodBank(
          //   var response = await apiService.postAuthRequest(

          endpoint: "auth/blood/bank",
          image: file,
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);
      Map data = jsonDecode(response);
      // Map data = response;
      print(response);
      if (data["message"] == "User already exists") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["message"] != "Registration Successfully ..!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else {
        // Map data = response;
        // print(response);
        // if (data["message"] != "Registration Successfully ..!") {
        //   Fluttertoast.showToast(
        //     msg: data["message"],
        //   );
        // } else {

        Fluttertoast.showToast(
          msg: "Registered Successfully",
        );
        var bloodbankpayloads = {
          "mobile": registerBloodbankMobileEntered.value,
          //  "8297297247"
        };

        // logins(bloodbankpayloads);
        //  Get.toNamed(kSignInScreen)
        //   Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      registerBloodbankLoading(false);
    }
  }

// Find Donor
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
  var finddonorRegistrationLoading = false.obs;
  var finddonorRegistrationData = {}.obs;
  var finddonorMobileEntered = "".obs;
  Future<void> findDonor(Map payload) async {
    finddonorRegistrationLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestToken(
          //   var response = await apiService.postAuthRequest(

          endpoint: "patient/add/patient",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Updated Patient Details..!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getProfile();
        // Get.toNamed(kPatientsScreen);
        // Get.back();
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: "Something went wrong",
        );

        // var payloads = {
        //   "phone": finddonorMobileEntered.value,
        //   //  "8297297247"
        // };

        // logins(payloads);
        //  Get.toNamed(kSignInScreen)
        //   Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      finddonorRegistrationLoading(false);
    }
  }

// Update Schedule of Blood bank timings
  var cancelOrderLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> userCancelRaid(Map payload) async {
    cancelOrderLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "user/cancel-order/${lastPlacedId}",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Order Canceled....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        statustimercontroller.stopTimer();

        Get.toNamed(kUserDashboard);
        apicontroller.captaindeleteChat(apicontroller.socketioData[0]["_id"]);
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      cancelOrderLoading(false);
    }
  }

  ////////////////ListenforComplete

  ////////////////////////////

  ///role change api
  var roleChangeLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> roleChange(Map payload, String Number) async {
    cancelOrderLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/change-role",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Change role successfully....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        var payloadss = {"mobile": Number};
        changeRolelogins(payloadss);
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      cancelOrderLoading(false);
    }
  }

  Future<void> roleChangeOtp(Map payload, String Number) async {
    cancelOrderLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/change-role",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Change role successfully....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        var payloadss = {"mobile": Number};
        changeRoleloginsotp(payloadss);
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      cancelOrderLoading(false);
    }
  }

  /// logins

  var chnageRoleloginsLoading = false.obs;
  var changeRoleloginsData = {}.obs;
  var changeRoleenteredNumber = "".obs;
  var changeRolestoredloginsData = {}.obs;
  Future<void> changeRolelogins(Map payload) async {
    chnageRoleloginsLoading(true);
    changeRoleenteredNumber.value = payload["mobile"];
    try {
      var response = await apiService.postRequestNotoken(
          endpoint: "auth/login", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "User does not exist") {
        Get.toNamed(KSignUp);
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        changeRoleloginsData.value = data;
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        UserSimplePreferences.setToken(token: data["token"].toString());
        apicontroller.getRapidoEmpProfileNvaigation();

        // Get.toNamed(KDashboard);
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Login Successfully",
        );
      }
      // "User Does't exist"
      // if (data["message"] == "User Does't exist") {
      //   Get.toNamed(kSignUpScreen);
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else if (data["token"] == null) {
      //   Fluttertoast.showToast(
      //     msg: response["message"],
      //   );
      // } else {
      //   loginsData.value = data;
      //   await UserSimplePreferences.setLoginStatus(loginStatus: true);

      //   //await UserSimplePreferences.setUserid(userId: loginsData["_id"]);
      //   // await UserSimplePreferences.setUserdata(
      //   //     userData: json.encode(loginsData.value));
      //   UserSimplePreferences.setToken(token: data["token"].toString());
      //   await getProfile();
      //   // apiController.storedloginsData["employeeType"] == "Blood Needed"
      //   //     ? Get.toNamed(kNavigation)
      //   //     : Get.toNamed(kDonorBottomNavigation);
      //   profileData["employeeType"] == "Donor"
      //       ? Get.toNamed(kDonorBottomNavigation)
      //       : Get.toNamed(kNavigation);
      //   // print(UserSimplePreferences.getUserdata());
      //   Fluttertoast.showToast(
      //     msg: "Login Successfully",
      //   );
      //   //  Get.toNamed(kNavigation);
      //   // loginsData["employeeType"] == "Blood Needed"
      //   //     ? Get.toNamed(kNavigation)
      //   //     : Get.toNamed(kDonorBottomNavigation);
      // }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      loginsLoading(false);
    }
  }

  Future<void> changeRoleloginsotps(Map payload) async {
    chnageRoleloginsLoading(true);
    changeRoleenteredNumber.value = payload["mobile"];
    try {
      var response = await apiService.postRequestNotoken(
          endpoint: "auth/login", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "User does not exist") {
        Get.toNamed(KSignUp);
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        changeRoleloginsData.value = data;
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        UserSimplePreferences.setToken(token: data["token"].toString());
        apicontroller.getRapidoEmpProfileNvaigation();

        // Get.toNamed(KDashboard);
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Login Successfully",
        );
      }
      // "User Does't exist"
      // if (data["message"] == "User Does't exist") {
      //   Get.toNamed(kSignUpScreen);
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else if (data["token"] == null) {
      //   Fluttertoast.showToast(
      //     msg: response["message"],
      //   );
      // } else {
      //   loginsData.value = data;
      //   await UserSimplePreferences.setLoginStatus(loginStatus: true);

      //   //await UserSimplePreferences.setUserid(userId: loginsData["_id"]);
      //   // await UserSimplePreferences.setUserdata(
      //   //     userData: json.encode(loginsData.value));
      //   UserSimplePreferences.setToken(token: data["token"].toString());
      //   await getProfile();
      //   // apiController.storedloginsData["employeeType"] == "Blood Needed"
      //   //     ? Get.toNamed(kNavigation)
      //   //     : Get.toNamed(kDonorBottomNavigation);
      //   profileData["employeeType"] == "Donor"
      //       ? Get.toNamed(kDonorBottomNavigation)
      //       : Get.toNamed(kNavigation);
      //   // print(UserSimplePreferences.getUserdata());
      //   Fluttertoast.showToast(
      //     msg: "Login Successfully",
      //   );
      //   //  Get.toNamed(kNavigation);
      //   // loginsData["employeeType"] == "Blood Needed"
      //   //     ? Get.toNamed(kNavigation)
      //   //     : Get.toNamed(kDonorBottomNavigation);
      // }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      loginsLoading(false);
    }
  }

  Future<void> changeRoleloginsotp(Map payload) async {
    chnageRoleloginsLoading(true);
    changeRoleenteredNumber.value = payload["mobile"];
    try {
      var response = await apiService.postRequestNotoken(
          endpoint: "auth/login", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "User does not exist") {
        Get.toNamed(KSignUp);
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        changeRoleloginsData.value = data;
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        UserSimplePreferences.setToken(token: data["token"].toString());
        apicontroller.getRapidoEmpProfileNvaigationotp();

        // Get.toNamed(KDashboard);
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Login Successfully",
        );
      }
      // "User Does't exist"
      // if (data["message"] == "User Does't exist") {
      //   Get.toNamed(kSignUpScreen);
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else if (data["token"] == null) {
      //   Fluttertoast.showToast(
      //     msg: response["message"],
      //   );
      // } else {
      //   loginsData.value = data;
      //   await UserSimplePreferences.setLoginStatus(loginStatus: true);

      //   //await UserSimplePreferences.setUserid(userId: loginsData["_id"]);
      //   // await UserSimplePreferences.setUserdata(
      //   //     userData: json.encode(loginsData.value));
      //   UserSimplePreferences.setToken(token: data["token"].toString());
      //   await getProfile();
      //   // apiController.storedloginsData["employeeType"] == "Blood Needed"
      //   //     ? Get.toNamed(kNavigation)
      //   //     : Get.toNamed(kDonorBottomNavigation);
      //   profileData["employeeType"] == "Donor"
      //       ? Get.toNamed(kDonorBottomNavigation)
      //       : Get.toNamed(kNavigation);
      //   // print(UserSimplePreferences.getUserdata());
      //   Fluttertoast.showToast(
      //     msg: "Login Successfully",
      //   );
      //   //  Get.toNamed(kNavigation);
      //   // loginsData["employeeType"] == "Blood Needed"
      //   //     ? Get.toNamed(kNavigation)
      //   //     : Get.toNamed(kDonorBottomNavigation);
      // }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      loginsLoading(false);
    }
  }

  //////////////////////////////////////////////////////////Post Request Razorpay
  var razorpaysendLoading = false.obs;
  var razorpayRequestDataBackend = {}.obs;
  Future<void> sendRazorpayRequest(Map payload) async {
    razorpaysendLoading(true);

    try {
      var response = await apiService.postRequest(
          endpoint: "payment/create-order", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "User does not exist") {
        Fluttertoast.showToast(
          msg: "",
        );
      } else if (data != null) {
        razorpayRequestDataBackend.value = data;
        print(razorpayRequestDataBackend.value);
      } else {
        Fluttertoast.showToast(
          msg: "",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      razorpaysendLoading(false);
    }
  }

  //////////
  ///payment/verify-payment
//POST
//body- razorpay_order_id, razorpay_payment_id, razorpay_signature
//////////////////////////////////////////////////////////
  var razorpaycompleteLoading = false.obs;
  Future<void> sendRazorpayCompletionDetails(Map payload) async {
    razorpaycompleteLoading(true);

    try {
      var response = await apiService.postRequest(
          endpoint: "payment/verify-payment", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Payment was successful!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        Get.back();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // data["message"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      razorpaycompleteLoading(false);
    }
  }

  //////////////////////////Send QR_razor Data//
  var qrimagerazorpaycompleteLoading = false.obs;
  Future<void> qrimagesendRazorpayCompletionDetails(Map payload) async {
    qrimagerazorpaycompleteLoading(true);

    try {
      var response = await apiService.postRequest(
          endpoint: "payment/qr-payemnt-verification", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Payment verified") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        Get.back();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // data["message"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      qrimagerazorpaycompleteLoading(false);
    }
  }
  //////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////
  // DeletePatient

  var deletePatientLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> deletePatient(String id) async {
    deletePatientLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "patient/isdelete/${id}",
        // http://183.82.10.109/patient/isdelete/66575a7fc99de5792c5c4777
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] == "updated successfully ....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getPatients();

        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      deletePatientLoading(false);
    }
  }

  // activat patient

  var activatePatientLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> activatePatient(String id) async {
    activatePatientLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        endpoint: "patient/isActive/${id}",
        // patient/isActive/66593165e2a7dea31c8f1a39
      );

      Map data = response;
      print(response);
      if (data["message"] == "updated successfully ....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getPatients();

        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      activatePatientLoading(false);
    }
  }

  // ActivatPatient with Del Option
  var activatePatientwithDeleteLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> activatePatientWithDeleteOption(String id) async {
    activatePatientwithDeleteLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        endpoint: "patient/isActive/${id}",
        // patient/isActive/66593165e2a7dea31c8f1a39
      );

      Map data = response;
      print(response);
      if (data["message"] == "updated successfully ....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // deletePatient(id);
        getPatients();

        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      activatePatientwithDeleteLoading(false);
    }
  }

  /////////////////

  // Update available blood quantity
  var bloodQuantityLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> bloodAvailability(List payload) async {
    bloodQuantityLoading(true);
    try {
      var response = await apiService.patchRequestList(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "bloodbank/add/bloods",
          //"bloodbank/update/bloodbank/details",
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "updated") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getProfile();
        // Get.back();
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      bloodQuantityLoading(false);
    }
  }

//Available Api
//

  //   Edit profile form
  var editFormLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> editProfileForm(Map payload) async {
    editFormLoading(true);
    try {
      //
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/edit/profile",
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Upload profile successfully...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getProfile();
        Get.back();
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      editFormLoading(false);
    }
  }

  /////////////////
// DonorEditProfile
  var donorEditLoading = false.obs;
  // var donorRegistrationData = {}.obs;
  // var donorMobileEntered = "".obs;
  Future<void> donorEditProfile(File file) async {
    donorEditLoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestEditProfile(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          endpoint: "auth/edit/pic",
          // "auth/edit/profile/${storedloginsData["_id"]}",

          //"auth/registor/donor",

          profilePic: file);

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Upload profile successfully...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getProfile();
        // Get.back();
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );

        // logins(payload[""])
        // Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      donorEditLoading(false);
    }
  }

  Future<void> donorEditProfileBank(Map payload, File file) async {
    donorEditLoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestEditProfilebank(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          endpoint: "auth/edit/profile",
          // "auth/edit/profile/${storedloginsData["_id"]}",

          //"auth/registor/donor",
          payload: payload,
          profilePic: file);

      Map data = jsonDecode(response);
      print(data);
      if (data["message"] == "Upload profile successfully...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getProfile();
        Get.back();
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );

        // logins(payload[""])
        // Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      donorEditLoading(false);
    }
  }

  /////////////////////////////////////////WomanRapido // ramwork here //userRapido
  ///place order
  var placeOrderloading = false.obs;
  var lastPlacedRide = {}.obs;
  var lastPlacedId = "".obs;
  Future<void> placeOrdersUser(Map payload, File file) async {
    placeOrderloading(true);

    try {
      //
      var response = await apiService.postRequestUserBookFormData(
          endpoint: "user/placed-order",
          payload: payload,
          image: file,
          token: '${UserSimplePreferences.getToken()}'
          //"auth/registor/donor",
          );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Order placed successfully!") {
        if (ridebookTime.value == "") {
          lastPlacedRide.value = data["order"];
          Get.toNamed(kUserRaidOtp);

          lastPlacedId.value = lastPlacedRide["_id"];
          listenUserOrders();
          Fluttertoast.showToast(
            msg: data["message"],
          );
        } else {
          // var payload = {
          //   "time": ridebookTime.value,
          // };
          // apicontroller.timeBooking(payload);
          Get.back();
        }
        // lastPlacedRide.value = data["order"];
        // Get.toNamed(kUserRaidOtp);

        // lastPlacedId.value = lastPlacedRide["_id"];
        // listenUserOrders();
        // Fluttertoast.showToast(
        //   msg: data["message"],
        // );
        //////////////  kUserBookRideAuth
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: data["message"],
        );
      }
      // if (data["message"] == "User already exists") {
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else {

      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      //   var payloads = {
      //     "mobile": donorMobileEntered.value,

      //   };

      // }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      placeOrderloading(false);
    }
  }

/////////////////////book time
  Future<void> timeplaceOrdersUser(Map payload, File file) async {
    placeOrderloading(true);

    try {
      //
      var response = await apiService.postRequestUserBookFormDatatime(
          endpoint: "user/placed-order",
          payload: payload,
          image: file,
          token: '${UserSimplePreferences.getToken()}'
          //"auth/registor/donor",
          );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Order placed successfully!") {
        // if (ridebookTime.value == "") {
        //   lastPlacedRide.value = data["order"];
        //   Get.toNamed(kUserRaidOtp);

        //   lastPlacedId.value = lastPlacedRide["_id"];
        //   listenUserOrders();
        //   Fluttertoast.showToast(
        //     msg: data["message"],
        //   );
        // } else {
        //   var payload = {
        //     "time": ridebookTime.value,
        //   };
        //   apicontroller.timeBooking(payload);
        ridebookTime.value = "";
        Get.back();

        // lastPlacedRide.value = data["order"];
        // Get.toNamed(kUserRaidOtp);

        // lastPlacedId.value = lastPlacedRide["_id"];
        // listenUserOrders();
        // Fluttertoast.showToast(
        //   msg: data["message"],
        // );
        //////////////  kUserBookRideAuth
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: data["message"],
        );
      }
      // if (data["message"] == "User already exists") {
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else {

      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      //   var payloads = {
      //     "mobile": donorMobileEntered.value,

      //   };

      // }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      placeOrderloading(false);
    }
  }

////////////////////
  // Listen Order Satus
// ramuserchat
//////////////////////////////////////////////////////////////////////////////
  var userRideArrivalTime = "".obs;
////////////////////////////////////////////////
  var listenOrders = {}.obs;
  var listenOrdersDataLoading = false.obs;
  var isChatStarted = false.obs;
  var isNavigationStarted = false.obs;
  var isopenedUserCompleteScreen = false.obs;
  var chattingCaptain = "".obs;
  Future<void> listenUserOrders() async {
    listenOrdersDataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "user/order-status/${lastPlacedId.value}");
      //   https://womenrapido.nuhvin.com/user/order-status/6686e32e84a865ac4c442069
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        if (data["message"] == null) {
          listenOrders.value = data;
          if (listenOrders["status"] == "accept" &&
              isChatStarted.value == false) {
            print("ram");
            var payload = {"receiverId": listenOrders["acceptCaptain"]["_id"]};
            apicontroller.socketioCreateChat(payload);
            chattingCaptain.value = listenOrders["acceptCaptain"]["name"];
            isChatStarted.value = true;
          }
          if (listenOrders["onNaviagtionChange"] == true &&
              isNavigationStarted.value == false) {
            isNavigationStarted.value = true;
            Get.toNamed(kUserDropNavigation);
            // Get.toNamed(kCaptainDropNavigation);
          }
          if (listenOrders["onNaviagtionChange"] == false &&
              isNavigationStarted.value == true) {
            isNavigationStarted.value = false;
          }
        } else {
          // Fluttertoast.showToast(
          //   msg: "Working here",
          // );
          listenOrders.value = data;
          print(listenOrders.value);
          if (listenOrders["message"] == "Your Ride is completed...!" &&
              isopenedUserCompleteScreen.value == false) {
            Get.toNamed(kUserCompletRideScreen);
            isopenedUserCompleteScreen.value = true;
            print("object");
            // Get.toNamed(kCaptainDropNavigation);
          }

          Fluttertoast.showToast(
            msg: data["message"],
          );
        }

        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      listenOrdersDataLoading(false);
    }
  }

  //////////////////////////////
  // favourite orders
  var favouriteOrders = [].obs;
  var favouriteOrdersDataLoading = false.obs;

  Future<void> getUserfavourites() async {
    favouriteOrdersDataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "user/favourite-orders");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        favouriteOrders.value = data;
        print(favouriteOrders.value);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      favouriteOrdersDataLoading(false);
    }
  }

  ///////////////////////////////
  /// Active Riders
  var activeRidersList = [].obs;
  var activeRidersDataLoading = false.obs;
  // var coordinatesList = [].obs;
  var coordinatesList = [].obs;
  Future<void> getActiveRidersList() async {
    activeRidersDataLoading(true);
    try {
      var response = await apiService.getter(
          endpoint:
              "user/location-based-captain/${serviceController.longitude}/${serviceController.latittude}");
//   "captain/orders/${serviceController.longitude}/${serviceController.latittude}/20/01-07-2024");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        activeRidersList.value = data;
        coordinatesList.clear();
        for (int i = 0; i < activeRidersList.length; i++) {
          final double latitude =
              activeRidersList[i]['captainLocation']['coordinates'][1];
          final double longitude =
              activeRidersList[i]['captainLocation']['coordinates'][0];

          // Add a map with latitude and longitude as separate fields
          coordinatesList.add({"latitude": latitude, "longitude": longitude});
        }
        // second
        // for (int i = 0; i < activeRidersList.length; i++) {
        //   final double latitude =
        //       activeRidersList[i]['captainLocation']['coordinates'][1];
        //   final double longitude =
        //       activeRidersList[i]['captainLocation']['coordinates'][0];

        //   // Add the LatLng directly
        //   coordinatesList.add(LatLng(latitude, longitude));
        // }
        // first
        // for (int i = 0; i < activeRidersList.length; i++) {
        //   final double latitude =
        //       activeRidersList[i]['captainLocation']['coordinates'][1];
        //   final double longitude =
        //       activeRidersList[i]['captainLocation']['coordinates'][0];
        //   coordinatesList.add(LatLng(latitude, longitude));
        // }
        print(activeRidersList.value);
        print(activeRidersList.value);
        print(coordinatesList.value);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      activeRidersDataLoading(false);
    }
  }

  //ALL USER ORDERS
  var userOrders = [].obs;
  var userOrdersDataLoading = false.obs;
  var selectedorderlistType = "Ride History".obs;

  Future<void> getUserOrders() async {
    userOrdersDataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "user/all-order");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        userOrders.value = data;
        print(userOrders.value);
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      userOrdersDataLoading(false);
    }
  }

  // UserRide Cities
  var userRideCities = [].obs;
  var userRideCitiesLoading = false.obs;
  var metropolitanCities = [].obs;

  Future<void> getRideCities() async {
    userRideCitiesLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "auth/cities");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        userRideCities.value = data;
        metropolitanCities.value = data[0]["cities"];
        print(userRideCities.value);
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      userRideCitiesLoading(false);
    }
  }

  // User Rejected orders
  var userrejectedOrders = [].obs;
  var userRejectedOrdersDataLoading = false.obs;

  Future<void> getUserRejectedOrders(String ID) async {
    userRejectedOrdersDataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "user/rejecte-orders/${ID}");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        userrejectedOrders.value = data;
        print(userrejectedOrders.value);
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      userRejectedOrdersDataLoading(false);
    }
  }

  // Saved Address
  // User Rejected orders
  var userSavedOrders = [].obs;
  var userSavedOrdersDataLoading = false.obs;

  Future<void> getUserSavedOrders() async {
    userSavedOrdersDataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "user/saved-orders");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        userSavedOrders.value = data;
        print(userSavedOrders.value);
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      userSavedOrdersDataLoading(false);
    }
  }

  // SAve Address

  var saveLoading = false.obs;
  var switchValues = false.obs;
  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> userAddtoSave() async {
    saveLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "user/saved/${lastPlacedId.value}",
      );

      Map data = response;
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getUserSavedOrders();
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      saveLoading(false);
    }
  }

  // UsrADD Favourite
  var favouriteLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> userAddtoFavourite(String ID) async {
    favouriteLoading(true);
    try {
      //
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "user/favourite/${ID}",
      );

      Map data = response;
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getUserSavedOrders();
        getUserOrders();
        getUserfavourites();
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      favouriteLoading(false);
    }
  }

  Future<void> userAddtoFavouriteinHistory(String ID) async {
    favouriteLoading(true);
    try {
      //
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "user/favourite/${ID}",
      );

      Map data = response;
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getUserOrders();
        getUserSavedOrders();
        getUserfavourites();
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      favouriteLoading(false);
    }
  }

  ////
  Future<void> userAddtoFavouriteinFavouritesList(String ID) async {
    favouriteLoading(true);
    try {
      //
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "user/favourite/${ID}",
      );

      Map data = response;
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getUserfavourites();
        getUserSavedOrders();
        getUserOrders();
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      favouriteLoading(false);
    }
  }

  // RE - Order
  // UsrADD Favourite
  var reorderLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> userReorder(Map payload) async {
    reorderLoading(true);
    try {
      //
      var response = await apiService.patchRequest(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "user/re-place-order/${lastPlacedId}", payload: {},
      );

      Map data = response;
      print(response);
      if (data["message"] == "Re-place ordered...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      reorderLoading(false);
    }
  }

  // var filteraminityData = [].obs;
//  get profile API
  var profileData = {}.obs;
  var profiledataLoading = false.obs;

  Future<void> getRapidoEmpProfile() async {
    profiledataLoading(true);
    try {
      var response = await apiService.getRequest(
          //https://new-ram-blood-server.onrender.com
          endpoint: "auth/profile"
          //"auth/getuser/${storedloginsData["_id"]}"
          // apiController.storedloginsData["firstName"]
          //  "auth/getuser/6645df08c8658740e78b9ecf"
          // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10/A+"
          );
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = jsonDecode(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        profileData.value = data;

        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      profiledataLoading(false);
    }
  }
  /////////MobileNumberOtpRegister

  var mobileRegistrationLoading = false.obs;
  var mobileRegistrationData = {}.obs;
  var mobileMobileEntered = "".obs;
  Future<void> mobileRegistration(Map payload) async {
    mobileRegistrationLoading(true);
    mobileMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.postRequestNotoken(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          endpoint: "auth/send-otp",
          //"auth/registor/donor",
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "OTP sent successfully!"
          // ||
          //     data["message"] == "otp send & updated db"
          ) {
        print("object");
        Get.toNamed(KOtpVerification, arguments: mobileMobileEntered.value);
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
        // var payloads = {
        //   "mobile": donorMobileEntered.value,

        // };

        // logins(payloads);

        // Get.toNamed(kOtpScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      mobileRegistrationLoading(false);
    }
  }

  //OTP verification

  var otpRegistrationLoading = false.obs;
  var otpRegistrationData = {}.obs;
  var otpMobileEntered = "".obs;
  var enteredNumber = "".obs;
  Future<void> otpRegistration(Map payload) async {
    otpRegistrationLoading(true);
    otpMobileEntered.value = payload["mobile"];
    enteredNumber.value = payload["mobile"];
    try {
      var response = await apiService.postRequestNotoken(
          endpoint: "auth/verify-otp", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "User does not exist") {
        Get.toNamed(KSignUp);
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        loginsData.value = data;
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        UserSimplePreferences.setToken(token: data["token"].toString());
        Get.toNamed(KDashboard);
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Login Successfully",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      otpRegistrationLoading(false);
    }
  }

////////////////////////////////
  // Donor registration
  var donorRegistrationLoading = false.obs;
  var donorRegistrationData = {}.obs;
  var donorMobileEntered = "".obs;
  Future<void> donorRegistration(Map payload) async {
    donorRegistrationLoading(true);
    donorMobileEntered.value = payload["mobile"];
    try {
      //
      var response = await apiService.postRequestNotoken(
          endpoint: "auth/register",
          //"auth/registor/donor",
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "User Already Exist ....!") {
        Get.toNamed(KSignUp);
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["token"] == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        UserSimplePreferences.setToken(token: data["token"].toString());
        Get.toNamed(KDashboard);
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Registered Successfully",
        );
      }
      // if (data["message"] == "User already exists") {
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else {

      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      //   var payloads = {
      //     "mobile": donorMobileEntered.value,

      //   };

      // }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      donorRegistrationLoading(false);
    }
  }

  /// Rapido captain OnDuty Update
  var donorAvailableLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> captainAvailability() async {
    donorAvailableLoading(true);
    try {
      //
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/change-dutty",
      );

      Map data = response;
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
        print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      donorAvailableLoading(false);
    }
  }
//////////////////////////////////////
  ////////////Distance of Banks

  void calculatePickupDistance(double lat, double longi) {
    double startLatitude = serviceController.latittude;

    // double.parse(serviceController.latittude as String);
    double startLongitude = serviceController.longitude;
    double endLatitude = lat;
    double endLongitude = longi;
    // double endLatitude = 17.438819837071353;
    // double endLongitude = 78.34050178467211;

    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    // Convert meters to kilometers
    distanceInKilometers.value = distanceInMeters / 1000;
    print(distanceInKilometers);
    print(distanceInKilometers.value);
  }

  ///////////////////////////////////////////
  void calculateDropDistance(
      double lat, double longi, double dropLat, double dropLongi) {
    double startLatitude = lat;

    // double.parse(serviceController.latittude as String);
    double startLongitude = longi;
    double endLatitude = dropLat;
    double endLongitude = dropLongi;
    // double endLatitude = 17.438819837071353;
    // double endLongitude = 78.34050178467211;

    double distanceInMeter = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    // Convert meters to kilometers
    dropdistanceInKilometers.value = distanceInMeter / 1000;
    print(dropdistanceInKilometers);
    print(dropdistanceInKilometers.value);
  }

////////////Captain Fetch Apis
  // GoogleController serviceController = Get.put(GoogleController());
  ServiceController serviceController = Get.put(ServiceController());

  // double lat = 37.42796133580664;
  // double lon = -122.085749655962;

  // String? _currentAddress;
  // String? _currentAddresspincode;
  // var isLoadings = false.obs;
  // var isLoading = "none";
  // var otpLoading = false.obs;
  // var resortsloading = false.obs;
  // var resortsData = [].obs;
  // var originalresortsList = [].obs;
  // var dynamicresortsList = [].obs;
  // var userCurrentLocationLatitude = "".obs;
  // var userCurrentLocationLongitude = "".obs;
  // var range = 10.obs;

  // var phoneVerification = 0.obs;
  //////////////////////////////////////////////////////////////////////////////////////////////////////////
  var pointAddress = ''.obs;
  var ordersLoadings = false.obs;
  Future<void> getCurrentLocation() async {
    ordersLoadings(true);
    isLoading = "started";
    Position position = await _determinePosition();
    serviceController.position = position;
    serviceController.latittude = serviceController.position!.latitude;
    serviceController.longitude = serviceController.position!.longitude;

    resortsloading(true);
    orders.value = [];
    // donorfilterbg.value = profileData["bloodGroup"];
    var payload = {
      "latitude": serviceController.latittude.toString(),
      "longitude": serviceController.longitude.toString(),
      "radius": "155"
    };

    // donorsdataLoading(true);
    try {
      var response = await apiService.getRequest(
          endpoint:
              "captain/orders/${serviceController.longitude}/${serviceController.latittude}/20/01-07-2024");
      // "blood/needed/find/donor/longitude//latitude//distance/${donorcounter.value}/${storedloginsData["bloodGroup"]}");
      // "blood/find/donor/longitude/${serviceController.longitude}/latitude/${serviceController.latittude}/distance/${donorcounter.value}/${donorfilterbg.value}");

      var data = jsonDecode(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        orders.value = data;
        for (int i = 0; i < orders.length; i++) {
          calculatePickupDistance(orders[i]["pickup"]["coordinates"][1],
              orders[i]["pickup"]["coordinates"][0]);
          orders[i]['pickUpdistance'] = distanceInKilometers.value;
          print(orders[i]);
          //   if(int.parse(kitchen[i]["delivery_time"])<=time.value){
          //   lesstimeKitchen.add(kitchen[i]);
          // }
        }

        for (int i = 0; i < orders.length; i++) {
          calculateDropDistance(
            orders[i]["pickup"]["coordinates"][1],
            orders[i]["pickup"]["coordinates"][0],
            orders[i]["drop"]["coordinates"][1],
            orders[i]["drop"]["coordinates"][0],
          );
          orders[i]['dropdistance'] = dropdistanceInKilometers.value;
          print(orders[i]);
          //   if(int.parse(kitchen[i]["delivery_time"])<=time.value){
          //   lesstimeKitchen.add(kitchen[i]);
          // }
        }
        /////pickup address

        // donorsDatafilter.value = data;
        // donorsDataCopy.value = data;

        // OriginaldonorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      ordersLoadings(false);
    }
  }

  // Accept Order
  var acceptOrderLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  var acceptOrderData = {}.obs;
  Future<void> acceptOrder(String ID) async {
    acceptOrderLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/accept-order/${ID}",
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] == "Accept Order Successfully...!") {
        acceptOrderData.value = data["order"];
        print(acceptOrderData.value);
        Get.toNamed(kArrivedScreen);
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
        // Get.back();
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        Get.back();
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      acceptOrderLoading(false);
    }
  }

  // decline Orders
  var declineOrderLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  var declineOrderData = {}.obs;
  Future<void> declineOrder(String ID) async {
    acceptOrderLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/orders-rejected/${ID}",
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] ==
          "Order declined and user added to rejectedCaptaine successfully.") {
        // acceptOrderData.value = data["order"];
        // print(acceptOrderData.value);
        // Get.toNamed(kArrivedScreen);
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
        // Get.back();
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        Get.back();
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      acceptOrderLoading(false);
    }
  }

  //Cpmplete orders

  var completeOrderLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  var completeOrderData = {}.obs;
  Future<void> completeOrder(String ID) async {
    completeOrderLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/order-completed/${ID}",
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] == "Completed Order Updated successfully...!") {
        completeOrderData.value = data["order"];
        print(acceptOrderData.value);

        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
        Get.back();
        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        Get.back();
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      completeOrderLoading(false);
    }
  }

  // userReview
  var reviewOrderLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  var reviewOrderData = {}.obs;
  Future<void> reviewOrder(Map payload) async {
    reviewOrderLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "user/review-order/${lastPlacedId}",
          payload: payload
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          );

      Map data = response;
      print(response);
      if (data["message"] == "reviews added succesfully...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        statustimercontroller.stopTimer();
        Get.toNamed(kUserDashboard);
        // getProfile();

        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      completeOrderLoading(false);
    }
  }

  var completedData = [].obs;
  var completedDataLoading = false.obs;

  Future<void> getCompletedTrips() async {
    completedDataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "captain/completed-all-orders");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        completedData.value = data;
        print(completedData.value);
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;veri
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      completedDataLoading(false);
    }
  }

////////////////////////////////////////////////////////////////////////////////////////
  //RegistorImageDOnor
  // postRequestDonorSignupFormData
  //   var donorRegistrationLoading = false.obs;
  // var donorRegistrationData = {}.obs;
  // var donorMobileEntered = "".obs;
  Future<void> donorRegistrationwithImage(Map payload, File file) async {
    //vvip
    donorRegistrationLoading(true);
    donorMobileEntered.value = payload["mobile"];
    try {
      //
      var response = await apiService.postRequestDonorSignupFormData(
          endpoint: "auth/donor",
          //"auth/registor/donor",
          payload: payload,
          image: file);
      Map data = jsonDecode(response);
      // Map data = response;
      print(response);
      if (data["message"] == "User already exists") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else if (data["message"] != "Registration Successfully ..!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data["message"],
        );
        var payloads = {
          "mobile": donorMobileEntered.value,
          //  "8297297247"
        };

        //    logins(payloads);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      donorRegistrationLoading(false);
    }
  }

  ///SignIn
  ///
  //LoginAPI

  var loginsLoading = false.obs;
  var loginsData = {}.obs;
  // var enteredNumber = "".obs;
  // var storedloginsData = {}.obs;
  // Future<void> logins(Map payload) async {
  //   loginsLoading(true);
  //   enteredNumber.value = payload["mobile"];
  //   try {
  //     var response = await apiService.postAuthRequest(
  //         endpoint: "auth/login", payload: payload);

  //     Map data = jsonDecode(response);
  //     print(response);
  //     // "User Does't exist"
  //     if (data["message"] == "User Does't exist") {
  //       Get.toNamed(kSignUpScreen);
  //       Fluttertoast.showToast(
  //         msg: data["message"],
  //       );
  //     } else if (data["token"] == null) {
  //       Fluttertoast.showToast(
  //         msg: response["message"],
  //       );
  //     } else {
  //       loginsData.value = data;
  //       await UserSimplePreferences.setLoginStatus(loginStatus: true);

  //       UserSimplePreferences.setToken(token: data["token"].toString());
  //       await getProfile();

  //       profileData["employeeType"] == "Donor"
  //           ? Get.toNamed(kDonorBottomNavigation)
  //           : Get.toNamed(kNavigation);

  //       Fluttertoast.showToast(
  //         msg: "Login Successfully",
  //       );

  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     loginsLoading(false);
  //   }
  // }

  //
  // Future<void> loginSignin(Map payload) async {
  //   loginsLoading(true);

  //   try {
  //     var response = await apiService.postAuthRequest(
  //         endpoint: "auth/login", payload: payload);

  //     Map data = jsonDecode(response);
  //     print(response);
  //     if (data["message"] == "User Does't exist") {
  //       Get.toNamed(kSignUpScreen);
  //       Fluttertoast.showToast(
  //         msg: data["message"],
  //       );
  //     } else if (data["token"] == null) {
  //       Fluttertoast.showToast(
  //         msg: response["message"],
  //       );
  //     } else {
  //       loginsData.value = data;
  //       await UserSimplePreferences.setLoginStatus(loginStatus: true);

  //       //await UserSimplePreferences.setUserid(userId: loginsData["_id"]);
  //       // await UserSimplePreferences.setUserdata(
  //       //     userData: json.encode(loginsData.value));
  //       UserSimplePreferences.setToken(token: data["token"].toString());
  //       await getProfile();
  //       // apiController.storedloginsData["employeeType"] == "Blood Needed"
  //       //     ? Get.toNamed(kNavigation)
  //       //     : Get.toNamed(kDonorBottomNavigation);
  //       profileData["employeeType"] == "Donor"
  //           ? Get.toNamed(kDonorBottomNavigation)
  //           : Get.toNamed(kNavigation);

  //       Fluttertoast.showToast(
  //         msg: "Login Successfully",
  //       );

  //       // Get.toNamed(kNavigation);
  //       // loginsData["employeeType"] == "Blood Needed"
  //       //     ? Get.toNamed(kNavigation)
  //       //     : Get.toNamed(kDonorBottomNavigation);
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     loginsLoading(false);
  //   }
  // }

/////
  Future<void> otplogins(Map payload) async {
    loginsLoading(true);
    try {
      var response = await apiService.postAuthRequest(
          endpoint: "auth/verify-otp", payload: payload);

      Map data = jsonDecode(response);
      print(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: response["message"],
        );
      } else {
        loginsData.value = data;
        await UserSimplePreferences.setLoginStatus(loginStatus: true);

        await UserSimplePreferences.setUserdata(
            userData: json.encode(loginsData.value));

        Fluttertoast.showToast(
          msg: "Login Successfully",
        );
        // loginsData["employeeType"] == "Blood Needed"
        //     ? Get.toNamed(kNavigation)
        //     : Get.toNamed(kDonorBottomNavigation);
      }
    } catch (e) {
      // Get.toNamed(kSignUpScreen);
      Fluttertoast.showToast(
        msg: "Account Not Created",
      );
    } finally {
      loginsLoading(false);
    }
  }

////////
// Blood donors list
  var orders = [].obs;
  var ordersPickupAdress = "".obs;
  var ordersDropAdress = "".obs;
  var donorsDatafilter = [].obs;
  var donorsDataCopy = [].obs;
  var OriginaldonorsData = [].obs;
  var reciversData = [].obs;
  var bankdonorsData = [].obs;
  var bankdonorsDatafilter = [].obs;
  var bankdonorsDataCopy = [].obs;
  var OriginalbankdonorsData = [].obs;
  var reciversDataCopy = [].obs;
  var donorsdatas = {}.obs;
  var OriginalassetsData = [].obs;
  // var filteraminityData = [].obs;
//  get profile API

  var donorsdataLoading = false.obs;
  Future<void> getProfile() async {
    profiledataLoading(true);
    try {
      var response = await apiService.getRequest(
          //https://new-ram-blood-server.onrender.com
          endpoint: "auth/getUser"
          //"auth/getuser/${storedloginsData["_id"]}"
          // apiController.storedloginsData["firstName"]
          //  "auth/getuser/6645df08c8658740e78b9ecf"
          // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10/A+"
          );
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = jsonDecode(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        profileData.value = data;
        switchValues.value = profileData["isAvailable"];
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      profiledataLoading(false);
    }
  }

  ///////////////

  // Get Patients list
  var patientsData = [].obs;
  var patientDatadataLoading = false.obs;
  var listB = <String>[].obs;
  Future<void> getPatients() async {
    patientDatadataLoading(true);
    try {
      var response = await apiService.getRequest(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "patient/get/patinet");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = jsonDecode(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        patientsData.value = data;
        for (var item in patientsData) {
          listB.add(item["bloodGroup"]);
        }
        listB.value = listB.toSet().toList();
        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      patientDatadataLoading(false);
    }
  }

  //////////////////
  var bannersData = [].obs;
  var bannerDatadataLoading = false.obs;

  Future<void> getBannersOne() async {
    bannerDatadataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "developer/baners");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = response;
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        bannersData.value = data;

        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      bannerDatadataLoading(false);
    }
  }

  // Banners two
  var bannersTwoData = [].obs;
  var bannerTwoDatadataLoading = false.obs;

  Future<void> getBannersTwo() async {
    bannerTwoDatadataLoading(true);
    try {
      var response = await apiService.getRequest(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "auth/bannersTwo");
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = jsonDecode(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        bannersTwoData.value = data;

        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      bannerTwoDatadataLoading(false);
    }
  }

  /////
  /////Get feeds
  var feedsData = [].obs;
  var feedDatadataLoading = false.obs;

  Future<void> getFeedsData() async {
    feedDatadataLoading(true);
    try {
      var response = await apiService.getRequest(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "auth/feeds");
      // auth/feeds
      // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
      var data = jsonDecode(response);
      if (data == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      } else {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        feedsData.value = data;

        //assetsData.value = data;
        //   assetsDatafilter.value = data;
        //   OriginalassetsData.value = data;
        //donorsData.value = data;
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // var assetsDatafilter = [].obs;
        // var activeAsset = {}.obs;
        // var OriginalassetsData = [].obs;
        // activeAsset.value = assetsData[0];
        // getAssetImage();

        // OriginalaminityData.value = data["rows"];
        // filteraminityData.value = data["rows"];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
      // Get.snackbar(
      //   "E-MLA",
      //   "Something Went Wrong!!",
      //   icon: const Icon(Icons.person, color: Colors.white),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } finally {
      feedDatadataLoading(false);
    }
  }
}
