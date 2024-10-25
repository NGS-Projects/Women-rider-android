// import 'dart:convert';

// import 'package:womentaxi/untils/export_file.dart';

// class Controller extends GetxController {
//   var duty = "OFF DUTY".obs;
// }
import 'dart:convert';
import 'dart:io';

import 'package:womentaxi/untils/export_file.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:womentaxi/untils/export_file.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
TimerController timercontroller = Get.put(TimerController());

class ApiController extends GetxController {
  final apiService = Get.put(ApiService());
  UserApiController userapicontroller = Get.put(UserApiController());
  // TimerController timercontroller = Get.put(TimerController());
  var duty = "OFF DUTY".obs;
  var switchedValue = false.obs;
  var switchedValueOrg = false.obs;
  var selectedVehicle = "scooty".obs;
  var selectedMensCount = "0".obs;
  var isVehicleselected = false.obs;
  var selectedParcelType = "Food".obs;
  var selectedCancelReason = "".obs;
  var registerAutenticationBody = {}.obs;
  var bookrideTimeBody = {}.obs;
  var userRideAutenticationBody = {}.obs;
  var selectedRegisterType = "captain".obs;
  var selectedIDType = "Aadhar".obs;
  var captainVehicleNumberCorrect = true.obs;
  var doesUserSelectedRole = false.obs;
  ////////////////////////////////////////////////////////////////
  var isSignupAdhaarVerified = false.obs;
  var isSignupBiometricVerified = false.obs;
  var isEmergencyVerified = false.obs;
  //////////////////////////////////////////////////////////////
  ///////////Counter
  var counter = 10.obs;
  var bankfilterbg = "A+".obs;
  var receiverfilterbg = "A+".obs;
  var donorfilterbg = "A+".obs;

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
  TextEditingController emergencyContactController = TextEditingController();
  TextEditingController rideStartPinController = TextEditingController();

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
  TextEditingController registerAdharTextController = TextEditingController();
  TextEditingController registerPanTextController = TextEditingController();
  TextEditingController registerDonorfirstNameController =
      TextEditingController();
  TextEditingController registerDonoremailController = TextEditingController();
  TextEditingController registerworaddressController = TextEditingController();
  TextEditingController registerworemergencyController =
      TextEditingController();
  TextEditingController instructionsController = TextEditingController();
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
  var selectedIdProof = "".obs;
  var donorRegistersGender = "".obs;
  var findDonorBloodGroup = "".obs;
  var findDonorRequesttype = "".obs;
  var todayName = "Monday".obs;
  var isDOBSelectedinSignUp = false.obs;
  var isProfileImageSelectedinSignUp = false.obs;

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

  TextEditingController editfirstNameController = TextEditingController();
  TextEditingController editRideAddressController = TextEditingController();
  TextEditingController editRideEmailController = TextEditingController();
  TextEditingController editRideDobController = TextEditingController();
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
  var searchedData = {}.obs;
  var searchedDataV2 = "".obs;
  var searchedDataV2longitude = 0.0.obs;
  var searchedDataV2latittude = 0.0.obs;
  var searchedDataPickupAddress = "NA".obs;
  var searchedDataDropAddress = "NA".obs;
  void updateSearchedData(Map<String, dynamic> data) {
    searchedData.value = data;
    Get.toNamed(kUserBookRide);
    // Get.toNamed();
    print(
        "rama///////////////////////////////////luv/////////////////////////////////////");
    print(searchedData.value);
    print(
        "rama///////////////////////////////////luv/////////////////////////////////////");
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
  var fbTokenLoading = false.obs;

  Future<void> uploadFbToken(Map payload) async {
    fbTokenLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(

          endpoint: "auth/fbtoken",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "token updated successfully...!") {
        // Fluttertoast.showToast(
        //   msg: data["message"],
        // );
        // getProfile();
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
      fbTokenLoading(false);
    }
  }

/////////////////////////
  var timeBookingLoading = false.obs;

  Future<void> timeBooking(Map payload) async {
    timeBookingLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(

          endpoint: "auth/time",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Time updated successfully...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );

        userapicontroller.ridebookTime.value = "";
        print("object");
        // getProfile();
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
      timeBookingLoading(false);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////
  //// gmaps changed searched addresss
  void updateSearchedDataGmapsV2() {
    print(searchedDataV2.value);

    // searchedData.value = data;
//Get.toNamed(kUserBookRide);
    Get.toNamed(kGmapstestpolilines);
    // Get.toNamed();
    print(searchedDataV2.value);
  }

  void updateSearchedDataGmapsV2Bookride() {
    // searchedData.value = data;
//Get.toNamed(kUserBookRide);
    searchedDataDropAddress.value = searchedDataV2.value;
    // Get.toNamed(kUserBookRide); // rechange
    // Get.toNamed();
    print(searchedDataV2.value);
  }
  ////////////////////////////////////////////////////

  // Map<String, dynamic>? userSearchedAddress = {}.obs as Map<String, dynamic>?;
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
  var _switchValue = false.obs;
////////////////////////////////////////////RiderFaceMatching
  Future<void> ridercaptainFaceMatching(Map payload, File imagesFiles) async {
    facematchingLoading(true);
    captainfacematched.value = false;
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/facesimilarity",
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        Fluttertoast.showToast(
          msg: "Success",
        );
        facematchingData.value = data;

        print("verifyAdharDocData.value");
        print(facematchingData.value);
        if (facematchingData["result"]["match"] == "yes") {
          apicontroller.captainAvailability(imagesFiles!);
          // setState(() {
          _switchValue.value = switchedValueOrg.value;
          switchedValue.value = _switchValue.value;
          // _switchValue = apicontroller.switchedValue;
          duty == "ON DUTY" ? duty.value = "OFF DUTY" : duty.value = "ON DUTY";
          timercontroller.startTimer();
          // startBackgroundService();
          // ramaddback
          // });
          Get.back();
          // if (userapicontroller.ridebookTime == "") {
          //   userapicontroller.placeOrdersUser(
          //       userRideAutenticationBody.value, imagesFiles!);
          // } else {
          //   userapicontroller.timeplaceOrdersUser(
          //       userRideAutenticationBody.value, imagesFiles!);
          // }
        } else {
          Fluttertoast.showToast(
            msg: "Face Didnot Match",
          );
        }
        print("verifyAdharDocData.value");
        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
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
      facematchingLoading(false);
    }
  }

////////////////////////////
  ////  Get Banks List
  var bankListLoading = false.obs;
// Face Matching
  var facematchingLoading = false.obs;
  var facematchingData = {}.obs;
  var captainfacematched = false.obs;
  Future<void> captainFaceMatching(Map payload, File imagesFiles) async {
    facematchingLoading(true);
    captainfacematched.value = false;
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/facesimilarity",
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        Fluttertoast.showToast(
          msg: "Wait for face matching..",
        );
        facematchingData.value = data;

        print("verifyAdharDocData.value");
        print(facematchingData.value);
        if (facematchingData["result"]["match"] == "yes") {
          if (userapicontroller.ridebookTime == "") {
            userapicontroller.placeOrdersUser(
                userRideAutenticationBody.value, imagesFiles!);
          } else {
            userapicontroller.timeplaceOrdersUser(
                userRideAutenticationBody.value, imagesFiles!);
          }
        } else {
          Fluttertoast.showToast(
            msg: "Face Didnot Match",
          );
        }
        print("verifyAdharDocData.value");
        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
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
      facematchingLoading(false);
    }
  }

  ///////////////////////////////////////verifyDocs
//ram ///
  var verifyAdharDocLoading = false.obs;
  var verifyAdharDocData = {}.obs;
  var enteredVerifyAdharNumber = "".obs;
  Future<void> verifyAdharDoc(Map payload) async {
    verifyAdharDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/aadhaar-xml/otp",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        Fluttertoast.showToast(
          msg: "Otp Sent to registered Mobile Number",
        );
        verifyAdharDocData.value = data;
        enteredVerifyAdharNumber.value = payload["aadhaarNo"];
        print("verifyAdharDocData.value");

        // getProfile();
        Get.toNamed(kAdhaarOTPScreen);
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
      verifyAdharDocLoading(false);
    }
  }

  Future<void> newverifyAdharDoc(Map payload) async {
    verifyAdharDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/aadhaar-xml/otp",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        Fluttertoast.showToast(
          msg: "Otp Sent to registered Mobile Number",
        );
        verifyAdharDocData.value = data;
        enteredVerifyAdharNumber.value = payload["aadhaarNo"];
        print("verifyAdharDocData.value");

        // getProfile();
        Get.toNamed(kNewAdhaarOtpScreen);
        // Get.toNamed(kAdhaarOTPScreen);
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
      verifyAdharDocLoading(false);
    }
  }

  /////////////////////////////////
  /// AdharOTP
  var otpAdharDocLoading = false.obs;
  var otoAdharDocData = {}.obs;

  Future<void> otpAdharDoc(Map payload) async {
    otpAdharDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/aadhaar-xml/file",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        otoAdharDocData.value = data;
        print("verifyAdharDocData.value");
        // updateAdhaarVerification(otoAdharDocData.value);
        if (otoAdharDocData["result"]["dataFromAadhaar"]["gender"] != null) {
          otoAdharDocData["result"]["dataFromAadhaar"]["gender"] == "M"
              ? Fluttertoast.showToast(
                  msg: "Only Female accounts can be verified")
              : Fluttertoast.showToast(msg: "verified");
          if (otoAdharDocData["result"]["dataFromAadhaar"]["gender"] != "M") {
            var payloadds = {
              "aadharNumberVerified": "true",
              //  "8297297247"
            };
            updateAdhaarVerification(otoAdharDocData.value);
            // updateAdhaarVerification(payloadds);
          }
        } else {
          updateAdhaarVerification(otoAdharDocData.value);
        }

        //ramintegrate docbackendapis
        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
        // Get.back();
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: "Something went wrong",
        );

        // var payloadds = {
        //   "aadharNumberVerified": "true",
        //   //  "8297297247"
        // };
        // updateAdhaarVerification(payloadds);
        // logins(payloads);
        //  Get.toNamed(kSignInScreen)
        //   Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      otpAdharDocLoading(false);
    }
  }

  Future<void> newotpAdharDoc(Map payload) async {
    otpAdharDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/aadhaar-xml/file",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        otoAdharDocData.value = data;
        print("verifyAdharDocData.value");

        // newupdateAdhaarVerification(otoAdharDocData.value);
        if (otoAdharDocData["result"]["dataFromAadhaar"]["gender"] != null) {
          otoAdharDocData["result"]["dataFromAadhaar"]["gender"] == "M"
              ? Fluttertoast.showToast(
                  msg: "Only Female accounts can be verified")
              : Fluttertoast.showToast(msg: "verified");
          if (otoAdharDocData["result"]["dataFromAadhaar"]["gender"] != "M") {
            var payloadds = {
              "aadharNumberVerified": "true",
              //  "8297297247"
            };
            newupdateAdhaarVerification(otoAdharDocData.value);
            // updateAdhaarVerification(payloadds);
          }
        } else {
          newupdateAdhaarVerification(otoAdharDocData.value);
        }

        //ramintegrate docbackendapis
        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
        // Get.back();
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: "Something went wrong",
        );

        // var payloadds = {
        //   "aadharNumberVerified": "true",
        //   //  "8297297247"
        // };
        // updateAdhaarVerification(payloadds);
        // logins(payloads);
        //  Get.toNamed(kSignInScreen)
        //   Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      otpAdharDocLoading(false);
    }
  }

  ///////////////////Backend Update Adhaar Api
  var adhaarUpdateBackendLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> updateAdhaarVerification(Map payload) async {
    adhaarUpdateBackendLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/aadhar-card-verification",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Aadhar details updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
        Get.back();
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
      adhaarUpdateBackendLoading(false);
    }
  }

  Future<void> newupdateAdhaarVerification(Map payload) async {
    adhaarUpdateBackendLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/aadhar-card-verification",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Aadhar details updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        isSignupAdhaarVerified.value = true;
        // getProfile();
        getRapidoEmpProfile();
        Get.back();
        Get.back();
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
      adhaarUpdateBackendLoading(false);
    }
  }

/////////////////////////////////////////////////////////////////////////////
  var enteredSignUpAdhaar = "".obs;
  var enteredSignUpPAN = "".obs;
  ////////////////////////////Pan
  var panDocLoading = false.obs;
  var panDocData = {}.obs;

  Future<void> panDoc(Map payload) async {
    panDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/pan-profile-detailed",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        // ram Changed on 15/10
        panDocData.value = data;
        // if (panDocData["result"]["gender"] != "male") {
        //   var payloaddpan = {
        //     "panNumberVerified": "true",
        //     //  "8297297247"
        //   };
        // updatePANVerification(panDocData.value);
        // }

        print("verifyAdharDocData.value");

        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
        //////////////////////////////////////////////////////////////
        if (panDocData["result"]["gender"] != null) {
          if (panDocData["result"]["gender"] != "male") {
            // var payloaddpan = {
            //   "panNumberVerified": "true",
            //   //  "8297297247"
            // };
            updatePANVerification(panDocData.value);
            // updatePANVerification(payloaddpan);
          } else {
            Fluttertoast.showToast(
              msg: "Female Accounts are only Verified.",
            );
          }
        } else {
          updatePANVerification(panDocData.value);
        }

        /////////////////////////////////////////////////////
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
      panDocLoading(false);
    }
  }

  ///
  Future<void> newpanDoc(Map payload) async {
    panDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/pan-profile-detailed",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        panDocData.value = data;

        newupdatePANVerification(panDocData.value);

        print("verifyAdharDocData.value");

        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
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
      panDocLoading(false);
    }
  }

  ///////////////////////////////////////PAN BACkend api
  ///////////////////Backend Update Adhaar Api
  var panUpdateBackendLoading = false.obs;
  Future<void> newupdatePANVerification(Map payload) async {
    panUpdateBackendLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/pan-card-verification",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "PAN details updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        isSignupAdhaarVerified.value = true;
        // getProfile();
        Get.back();
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
      panUpdateBackendLoading(false);
    }
  }

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> updatePANVerification(Map payload) async {
    panUpdateBackendLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/pan-card-verification",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Pan details updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
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
      panUpdateBackendLoading(false);
    }
  }
/////////////////////////////////////////////////////////////////////////////

  /// RC Verify
  var rcDocLoading = false.obs;
  var rcDocData = {}.obs;

  Future<void> rcDoc(Map payload) async {
    rcDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v2/rc",
          // https://uat-hub.perfios.com/api/kyc/v2/rc
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["request_id"] != null) {
        // Fluttertoast.showToast(
        //   msg: "Successful",
        // );
        rcDocData.value = data;
        // print("verifyAdharDocData.value");
        // var payloaddrc = {
        //   "rcnumberVerified": "true",
        //   //  "8297297247"
        // };
        updateRCVerification(rcDocData.value);
        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
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
      rcDocLoading(false);
    }
  }

  // Rc backend
  ///////////////////Backend Update Adhaar Api
  var rcUpdateBackendLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> updateRCVerification(Map payload) async {
    rcUpdateBackendLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/rc-card-verification",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "RC details updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
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
      rcUpdateBackendLoading(false);
    }
  }

  /////////////////////////////////Drivere  License
  var licenseDocLoading = false.obs;
  var licenseDocData = {}.obs;

  Future<void> licenseDoc(Map payload) async {
    licenseDocLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestTokenVerifyDocs(
          //   var response = await apiService.postAuthRequest(

          endpoint: "v3/dl",
          // https://uat-hub.perfios.com/api/kyc/v2/rc
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["requestId"] != null) {
        licenseDocData.value = data;
        print("verifyAdharDocData.value");
        updateDLVerification(licenseDocData.value);
        // var payloaddl = {
        //   "licenseNumberVerified": "true",
        //   //  "8297297247"
        // };
        // if (otoAdharDocData["result"]["dataFromAadhaar"]["name"] == null) {
        //   Fluttertoast.showToast(
        //     msg: "Please verify Adhaar Number",
        //   );
        // }
        // if (otoAdharDocData["result"]["dataFromAadhaar"]["name"] ==
        //     licenseDocData["result"]["name"]) {
        //   updateDLVerification(payloaddl);
        // } else {
        //   Fluttertoast.showToast(
        //     msg: "Name does't match with Adhaar name",
        //   );
        // }

//licenseDocData["result"]["name"]
        // getProfile();
        // Get.toNamed(kAdhaarOTPScreen);
        //  licenseDocData["result"]["name"]
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
      licenseDocLoading(false);
    }
  }

  // Dl backend
  ///////////////////Backend Update Adhaar Api
  var dlUpdateBackendLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> updateDLVerification(Map payload) async {
    dlUpdateBackendLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/license-card-verification",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "License details updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
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
      dlUpdateBackendLoading(false);
    }
  }

  ///

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
        // getProfile();
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
  var scheduleLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> updateBloodBankTimings(Map payload) async {
    scheduleLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "bloodbank/add/bloodbank/timmings",
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "updated") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // getProfile();
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
      scheduleLoading(false);
    }
  }

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

///////////////////////////////////// Confirm captainStartedNavigation
  var confirmcaptainStartNavigationLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> confirmcaptainStartedNavigation(String id, Map payload) async {
    confirmcaptainStartNavigationLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "captain/order-otp-verified/${id}",
          payload: payload
          // http://183.82.10.109/patient/isdelete/66575a7fc99de5792c5c4777
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          );

      Map data = response;
      print(response);
      if (data["message"] == "Order OTP verified..!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        captainStartedNavigation(id);
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
      confirmcaptainStartNavigationLoading(false);
    }
  }

///////////////////////////////////////////////////////////////////////
  // patch request for captainStartnavigation
  var captainStartNavigationLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> captainStartedNavigation(String id) async {
    captainStartNavigationLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/isridestart-naviage/${id}",
        // http://183.82.10.109/patient/isdelete/66575a7fc99de5792c5c4777
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] == "navigation started successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        Get.toNamed(kCaptainDropNavigation);
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
      captainStartNavigationLoading(false);
    }
  }

  Future<void> captainEndedNavigation(String id) async {
    captainStartNavigationLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/isridestart-naviage/${id}",
        // http://183.82.10.109/patient/isdelete/66575a7fc99de5792c5c4777
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] == "navigation started successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        captaindeleteChat(socketioData[0]["_id"]);
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
      captainStartNavigationLoading(false);
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
        // getProfile();
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
        // getProfile();
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
        // getProfile();
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
        // getProfile();
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

  /////////////////////////////////////////WomanRapido // ramwork here
  // var filteraminityData = [].obs;
//  get profile API
  var profileDataRole = "".obs;
  var profileData = {}.obs;
  var profiledataLoading = false.obs;
  Timer? profileTimer;

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
        profileDataRole.value = profileData["role"];
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

  void startProfileRoleTimer() {
    profileTimer?.cancel(); // Ensure there's no previous timer running
    Timer.periodic(Duration(minutes: 3), (timer) async {
      await getRapidoEmpProfile();
      if (profileDataRole.value == "captain" && profileData["onDuty"] == true) {
        liveUpdatesofCaptain();
      }
    });
  }

  // Cancel the timer when the controller is disposed
  @override
  void onClose() {
    profileTimer?.cancel();
    super.onClose();
  }

//////////
  Future<void> getRapidoEmpProfileNvaigationotp() async {
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
        //  var payload = {"mobile": _phoneController.text};

        //                   // {"mobile": _phoneController.text}
        //                 mobileRegistrationotp(payload);
        profileData.value = data;
        profileDataRole.value = profileData["role"];
        // profileData["role"] == "captain"
        //     ? Get.toNamed(KDashboard)
        //     : Get.toNamed(kUserDashboard);
        //  var payload = {"mobile":  changeRoleenteredNumber.value};
        var payload = {
          "mobile": userapicontroller.changeRoleenteredNumber.value
        };
        // {"mobile": _phoneController.text}
        mobileRegistrationotp(payload);
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

  /////////////////getProfileNavigation
  Future<void> getRapidoEmpProfileNvaigation() async {
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
        profileData.value = data;
        profileDataRole.value = profileData["role"];
        profileData["role"] == "captain"
            ? Get.toNamed(KDashboard)
            : Get.toNamed(kUserDashboard);
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

  // With change role
  Future<void> getRapidoEmpProfileNvaigationandchangerole() async {
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
        ///////////////////////////////////////////////////////
        profileData.value = data;
        profileDataRole.value = profileData["role"];
        if (apicontroller.selectedRegisterType.value == profileData["role"]) {
          profileData["role"] == "captain"
              ? Get.toNamed(KDashboard)
              : Get.toNamed(kUserDashboard);
        } else {
          if (apicontroller.selectedRegisterType.value == "user") {
            var payload = {"role": "user"};

            // {"mobile": _phoneController.text};
            userapicontroller.roleChange(
                payload, apicontroller.profileData["mobile"]);
          } else {
            var payload = {"role": "captain"};

            // {"mobile": _phoneController.text};
            userapicontroller.roleChange(
                payload, apicontroller.profileData["mobile"]);
          }
        }
        ////////////////////////////////////////
        // profileData.value = data;
        // profileDataRole.value = profileData["role"];
        // profileData["role"] == "captain"
        //     ? Get.toNamed(KDashboard)
        //     : Get.toNamed(kUserDashboard);
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

  ///////////////////////////Ram Edit profile Woman
// Edit picture
  var EditpicLoading = false.obs;
  // var donorRegistrationData = {}.obs;
  // var donorMobileEntered = "".obs;
  Future<void> editProfilePicture(File file) async {
    EditpicLoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestEditProfile(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          endpoint: "auth/edit-profile",
          // "auth/edit/profile/${storedloginsData["_id"]}",

          //"auth/registor/donor",

          profilePic: file);

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Profile updated successfully ....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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
      EditpicLoading(false);
    }
  }

  var urlLoading = false.obs;
  var BackendImageUrl = "".obs;
  var payloaded = {}.obs;
  // rider
  Future<void> riderconvertFromFiletoUrl(File file) async {
    urlLoading(true);
    // BackendImageUrl.value = "";
    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestConvert(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          endpoint: "auth/new-authenticated-image",
          // "auth/edit/profile/${storedloginsData["_id"]}",

          //"auth/registor/donor",

          profilePic: file);

      Map data = jsonDecode(response);

      print(response);
      if (data["url"] != null) {
        BackendImageUrl.value = data["url"];
        print(BackendImageUrl.value);
        // payload = {"role": "user"};
        payloaded.value = {
          // "url1": kBaseImageUrl + BackendImageUrl.value,
          "url1": kBaseImageUrl + "${data["url"]}",

          "url2": kBaseImageUrl + "${profileData["authenticationImage"]}"
          // "getNumberOfFaces": false,
          // "clientData": {"caseId": "123456"}
          // "image1B64": "base64 ${userapicontroller.urlbaseImage.value}",
          // "image2B64": "base64 ${userapicontroller.filebaseImage.value}"
        };
        //  {"pan": "", "consent": "Y"};

        ridercaptainFaceMatching(payloaded.value, file);
        //   ridercaptainFaceMatching(payloaded.value, file);
      } else {
        // loginData.value = data;

        // Fluttertoast.showToast(
        //   msg: data["message"],
        // );

        // logins(payload[""])
        // Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      urlLoading(false);
    }
  }

  ////
  Future<void> convertFromFiletoUrl(File file) async {
    urlLoading(true);
    // BackendImageUrl.value = "";
    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestConvert(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          endpoint: "auth/new-authenticated-image",
          // "auth/edit/profile/${storedloginsData["_id"]}",

          //"auth/registor/donor",

          profilePic: file);

      Map data = jsonDecode(response);

      print(response);
      if (data["url"] != null) {
        BackendImageUrl.value = data["url"];
        print(BackendImageUrl.value);
        // payload = {"role": "user"};
        payloaded.value = {
          // "url1": kBaseImageUrl + BackendImageUrl.value,
          "url1": kBaseImageUrl + "${data["url"]}",

          "url2": kBaseImageUrl + "${profileData["authenticationImage"]}"
          // "getNumberOfFaces": false,
          // "clientData": {"caseId": "123456"}
          // "image1B64": "base64 ${userapicontroller.urlbaseImage.value}",
          // "image2B64": "base64 ${userapicontroller.filebaseImage.value}"
        };
        //  {"pan": "", "consent": "Y"};

        captainFaceMatching(payloaded.value, file);
      } else {
        // loginData.value = data;

        // Fluttertoast.showToast(
        //   msg: data["message"],
        // );

        // logins(payload[""])
        // Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      urlLoading(false);
    }
  }

// try {
//   var response = await apiService.patchRequestConvert(
//       endpoint: "auth/new-authenticated-image",
//       profilePic: file);

//   var data = jsonDecode(response.body);
//   print(response.body);

//   if (data["url"] != null) {
//     // Process the URL and send to face matching
//     Map payload = {
//       "url1": kBaseImageUrl + data["url"],
//       "url2": kBaseImageUrl + apicontroller.profileData["authenticationImage"],
//       "getNumberOfFaces": false,
//       "clientData": {"caseId": "123456"}
//     };

//     apicontroller.captainFaceMatching(payload);
//   } else {
//     Fluttertoast.showToast(msg: data["message"] ?? "Error uploading image");
//   }
// } catch (e, stacktrace) {
//   print("Error: $e");
//   print(stacktrace);
//   Fluttertoast.showToast(msg: "Something went wrong");
// }

  //////////////////////////////Captain Upload Documents
  var uploadDocsoading = false.obs;
  // var donorRegistrationData = {}.obs;
  // var donorMobileEntered = "".obs;
  Future<void> captainUploadDocs(
      File license, File authenticationImage, File rc) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestUploadDocs(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image", license: license,
        authenticationImage: authenticationImage, rc: rc,
        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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
      uploadDocsoading(false);
    }
  }

///////////////////////////Sign up Upload
  Future<void> signupuserUploadVrrifyPan(File pan) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestUploadVrefipan(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image", pan: pan,

        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();

        var payload = {"pan": enteredSignUpPAN.value, "consent": "Y"};

        newpanDoc(payload);
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
      uploadDocsoading(false);
    }
  }

/////////////
  ///////
  var useruploadDocsoading = false.obs;
  // var donorRegistrationData = {}.obs;
  // var donorMobileEntered = "".obs;
  Future<void> userUploadVrrifyPan(File pan) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestUploadVrefipan(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image", pan: pan,

        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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
      uploadDocsoading(false);
    }
  }

  //////////////////Sign up adhar
  Future<void> signupuserUploadVrrifyAdhaar(File adhar, File adharBack) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.signuppatchRequestUploadVrefiAdhaar(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image",
        adhar: adhar, adharBack: adharBack,

        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
        var payload = {
          "aadhaarNo": enteredSignUpAdhaar.value,
          "consent": "Y",
        };

        newverifyAdharDoc(payload);
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
      uploadDocsoading(false);
    }
  }
  ////////////////////////////

  Future<void> userUploadVrrifyAdhaar(File adhar) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestUploadVrefiAdhaar(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image",
        adhar: adhar,
        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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
      uploadDocsoading(false);
    }
  }

  Future<void> userUploadVrrifyDocs(File pan, File adhar) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestUploadVrefiDocs(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image", pan: pan,
        adhar: adhar,
        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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
      uploadDocsoading(false);
    }
  }

  ////////////////////UserUploadMissingBiometrics
  Future<void> userUploadDocs(
    File authenticationImage,
  ) async {
    uploadDocsoading(true);

    //  donorMobileEntered.value = payload["mobile"];
    try {
      var response = await apiService.patchRequestUserUploadDocs(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        endpoint: "captain/upload-security-image",
        authenticationImage: authenticationImage,
        // "auth/edit/profile/${storedloginsData["_id"]}",

        //"auth/registor/donor",
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Security images uploaded successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        isSignupBiometricVerified.value = true;
        getRapidoEmpProfile();
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
      uploadDocsoading(false);
    }
  }

  ///////////////////////////////////
  /////////////////////////////////////////////////////////reviewByCaptain
  var captainReviewLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;

  Future<void> ratingByCaptain(Map payload, String ID) async {
    captainReviewLoading(true);
    try {
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "captain/rating-by-captain/${ID}",
          payload: payload
          // http://183.82.10.109/bloodbank/add/bloodbank/timmings
          );

      Map data = response;
      print(response);
      if (data["message"] == "rating updated.....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );

        completeOrder(ID);
        // statustimercontroller.stopTimer();
        // Get.toNamed(kUserDashboard);
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
      captainReviewLoading(false);
    }
  }

  ////////// RiderLiveUpdates// patch
  var captainLiveUpdatesLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> liveUpdatesofCaptain() async {
    captainLiveUpdatesLoading(true);
    isLoading = "started";
    Position position = await _determinePosition();
    serviceController.position = position;
    serviceController.latittude = serviceController.position!.latitude;
    serviceController.longitude = serviceController.position!.longitude;

    // donorfilterbg.value = profileData["bloodGroup"];
    var payload = {
      "latitude": serviceController.latittude.toString(),
      "longitude": serviceController.longitude.toString(),
    };

    try {
      var response = await apiService.patchRequest(
          endpoint: "captain/location-tracking", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == " captain location updated successfully") {
        // Fluttertoast.showToast(
        //   msg: data["message"],
        // );
        print(data["message"]);
        // statustimercontroller.stopTimer();
        // Get.toNamed(kUserDashboard);
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
      captainLiveUpdatesLoading(false);
    }
  }

  // Future<void> liveUpdatesofCaptain(Map payload) async {
  //   captainReviewLoading(true);
  //   try {
  //     var response = await apiService.patchRequest(
  //         endpoint: "captain/location-tracking", payload: payload);

  //     Map data = response;
  //     print(response);
  //     if (data["message"] == " captain location updated successfully") {
  //       Fluttertoast.showToast(
  //         msg: data["message"],
  //       );

  //       // statustimercontroller.stopTimer();
  //       // Get.toNamed(kUserDashboard);
  //       // getProfile();

  //       // switchValues.value = profileData["isAvailable"];
  //       // print(switchValues.value);
  //     } else {
  //       // loginData.value = data;

  //       Fluttertoast.showToast(
  //         msg: data["message"],
  //       );
  //       //  Get.toNamed(kSignInScreen);
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     captainReviewLoading(false);
  //   }
  // }

  ////////////////////////////////////////////////////////////////////////////////////

  // rider Profile Form
  var ridereditFormLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> ridereditProfileForm(Map payload) async {
    ridereditFormLoading(true);
    try {
      //
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/edit-profile",
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Profile updated successfully ....!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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
      ridereditFormLoading(false);
    }
  }

  //////////////////////add contact
  var addContactLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> addEmergencyForm(Map payload) async {
    addContactLoading(true);
    try {
      //
      var response = await apiService.patchRequest(
          //   var response = await apiService.postAuthRequest(
          // https://blood-server-us7o.onrender.com/auth/registor/donor
          //https://blood-server-us7o.onrender.com/auth/update/user/available
          endpoint: "auth/emergency-contact-number",
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "Emergency contact number updated successfully") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        isEmergencyVerified.value = true;
        Get.back();
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
      addContactLoading(false);
    }
  }
  /////////////////////////////////////////////////////////////////////

  /////////MobileNumberOtpRegister
  var isRegistrationIconSelected = false.obs;
  var isVerificationIconSelected = false.obs;
  var mobileRegistrationLoading = false.obs;
  var accountAcceptTerms = false.obs;
  var otpEnterCompleted = false.obs;
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
        Get.toNamed(kNewOtpScreen, arguments: mobileMobileEntered.value);
        // Get.toNamed(KOtpVerification, arguments: mobileMobileEntered.value);
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

  Future<void> mobileRegistrationotp(Map payload) async {
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
        Get.toNamed(kChangeRoleOTPScreen, arguments: mobileMobileEntered.value);
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
        // Get.toNamed(KSignUp);
        // Get.toNamed(kNewSignUpScreen);
        Get.toNamed(kNewSelectRoleScreen);

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
        await getRapidoEmpProfileNvaigation();
        // await getRapidoEmpProfileNvaigationandchangerole();
        // profileData["role"] == "captain"
        //     ?

        //     Get.toNamed(KDashboard)
        //     : Get.toNamed(kUserDashboard);
        // Get.toNamed(KDashboard);
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

  Future<void> otpRegistrationotp(Map payload) async {
    otpRegistrationLoading(true);
    otpMobileEntered.value = payload["mobile"];
    enteredNumber.value = payload["mobile"];
    try {
      var response = await apiService.postRequestNotoken(
          endpoint: "auth/change-role-verify-otp", payload: payload);

      Map data = response;
      print(response);
      if (data["message"] == "OTP Verified successfully..!") {
        // ramchangerolehere
        profileData["role"] == "captain"
            ? Get.toNamed(KDashboard)
            : Get.toNamed(kUserDashboard);
      } else {
        //ramchangerole
        // profileData["role"] == "captain"
        //     ?

        //     Get.toNamed(KDashboard)
        //     : Get.toNamed(kUserDashboard);
        // Get.toNamed(KDashboard);
        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Something went wrong",
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

////////////////////////////////WoR Register
  // Donor registration
  var donorRegistrationLoading = false.obs;
  var donorRegistrationData = {}.obs;
  var donorMobileEntered = "".obs;
  Future<void> newRegister(Map payload, File profilePic) async {
    donorRegistrationLoading(true);
    donorMobileEntered.value = payload["mobile"];

    try {
      //
      var response = await apiService.NewSignupFormData(
          endpoint: "auth/new-register",
          //"auth/registor/donor",
          payload: payload,
          image: profilePic);

      var data = jsonDecode(response);

      print(response);
      if (data["message"] == "User Already Exist ....!") {
        // Get.toNamed(KSignUp);
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
        //   getRapidoEmpProfileNvaigation();
        Get.toNamed(kNewDocScreen);

        // Fluttertoast.showToast(
        //   msg: "Registered Successfully",
        // );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      donorRegistrationLoading(false);
    }
  }

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
        getRapidoEmpProfileNvaigation();
        // await profileDataRole.value == "captain"
        //     ?

        //     //     ? Get.toNamed(kNavigation)
        //     //     : Get.toNamed(kDonorBottomNavigation);

        //     Get.toNamed(KDashboard)
        //     : Get.toNamed(kUserDashboard);

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

  //   FormData Register
  Future<void> RegistrationwithImage(Map payload, File file) async {
    //vvip
    donorRegistrationLoading(true);
    donorMobileEntered.value = payload["mobile"];
    try {
      //
      var response = await apiService.postRequestDonorSignupFormData(
          endpoint: "auth/register", payload: payload, image: file);
      ///////////////////////////////////NA
      //  var response = await apiService.postRequestNotoken(
      // endpoint: "",
      // //"auth/registor/donor",
      // payload: payload);
      ///////////
      Map data = jsonDecode(response);
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
        getRapidoEmpProfileNvaigation();
        // await profileDataRole.value == "captain"
        //     ?

        //     //     ? Get.toNamed(kNavigation)
        //     //     : Get.toNamed(kDonorBottomNavigation);

        //     Get.toNamed(KDashboard)
        //     : Get.toNamed(kUserDashboard);

        //await getProfile();

        // profileData["employeeType"] == "Donor"
        //     ? Get.toNamed(kDonorBottomNavigation)
        //     : Get.toNamed(kNavigation);

        Fluttertoast.showToast(
          msg: "Registered Successfully",
        );
      }
      // print(response);
      // if (data["message"] == "User already exists") {
      //   Fluttertoast.showToast(
      //     msg: data["message"],
      //   );
      // } else if (data["message"] != "Registration Successfully ..!") {
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
  var switchValues = false.obs;
  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> captainAvailability(File file) async {
    donorAvailableLoading(true);
    try {
      // var response = await apiService.patchRequestNopayload(
      var response = await apiService.patchRequestCaptainDuty(
        endpoint: "captain/change-dutty",
        profilePic: file,
      );

      Map data = jsonDecode(response);
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
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

  // Captain availability OFF
  Future<void> captainAvailabilityOFF() async {
    donorAvailableLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        endpoint: "captain/change-dutty",
      );

      Map data = response;
      print(response);
      if (data["message"] == "Updated...!") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        getRapidoEmpProfile();
        // getProfile();
        //  switchValues.value = profileData["isAvailable"];
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
  var today = ''.obs;
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
              "captain/orders/${serviceController.longitude}/${serviceController.latittude}/20/${today.value}");
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

  Future<void> getCurrentLocationTimer() async {
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
              "captain/orders/${serviceController.longitude}/${serviceController.latittude}/20/${today.value}");
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
          if (orders.isNotEmpty) {
            Get.toNamed(kAcceptOrders);
            Fluttertoast.showToast(
              msg: "Working Periodically",
            );
          } else {
            // Get.toNamed(KDashboard);
            Fluttertoast.showToast(
              msg: "No Orders",
            );
          }
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
  var chattingUser = "".obs;
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
        timercontroller.stopTimer();

        acceptOrderData.value = data["order"];
        var payload = {"receiverId": acceptOrderData["head"]["_id"]};
        apicontroller.socketioCreateChat(payload);
        chattingUser.value = acceptOrderData["head"]["name"];
        print(acceptOrderData.value);
        // below code is added for trail
        // captaindeleteChat(socketioData[0]["_id"]);
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
        /////////////statemanagement
        for (int i = 0; i < orders.length; i++) {
          if (orders[i]["_id"] == ID) {
            orders.remove(orders[i]);
            // Fluttertoast.showToast(
            //   msg: "removed ${ID}",
            // );
          }
        }
        ///////////////////////
      } else {
        Get.back();
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: "Something went wrong",
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
        timercontroller.startTimer();
        // ramaddback
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // captaindeleteChat(socketioData[0]["_id"]);
        captainEndedNavigation(ID);
        Get.toNamed(KDashboard);
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

  ////////////////////////// Exist Ride with men problem
  var escapeOrderLoading = false.obs;
  Future<void> escapeOrder(String ID) async {
    escapeOrderLoading(true);
    try {
      var response = await apiService.patchRequestNopayload(
        //   var response = await apiService.postAuthRequest(
        // https://blood-server-us7o.onrender.com/auth/registor/donor
        //https://blood-server-us7o.onrender.com/auth/update/user/available
        endpoint: "captain/mens-problem/${ID}",
        // http://183.82.10.109/bloodbank/add/bloodbank/timmings
      );

      Map data = response;
      print(response);
      if (data["message"] == "Mens problem updated.....!") {
        timercontroller.startTimer();
        // ramaddback
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // captaindeleteChat(socketioData[0]["_id"]);
        captainEndedNavigation(ID);
        Get.toNamed(KDashboard);
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
      escapeOrderLoading(false);
    }
  }
  ////////////////

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
  // Future<void> getProfile() async {
  //   profiledataLoading(true);
  //   try {
  //     var response = await apiService.getRequest(
  //         //https://new-ram-blood-server.onrender.com
  //         endpoint: "auth/getUser"
  //         //"auth/getuser/${storedloginsData["_id"]}"
  //         // apiController.storedloginsData["firstName"]
  //         //  "auth/getuser/6645df08c8658740e78b9ecf"
  //         // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10/A+"
  //         );
  //     // "blood/needed/find/donor/longitude/78.4089828/latitude/17.4851206/distance/10");
  //     var data = jsonDecode(response);
  //     if (data == null) {
  //       Fluttertoast.showToast(
  //         msg: "Something went wrong",
  //       );
  //     } else {
  //       // Fluttertoast.showToast(
  //       //   msg: "Successful",
  //       // );
  //       profileData.value = data;

  //       //assetsData.value = data;
  //       //   assetsDatafilter.value = data;
  //       //   OriginalassetsData.value = data;
  //       //donorsData.value = data;
  //       // Fluttertoast.showToast(
  //       //   msg: "Successful",
  //       // );
  //       // var assetsDatafilter = [].obs;
  //       // var activeAsset = {}.obs;
  //       // var OriginalassetsData = [].obs;
  //       // activeAsset.value = assetsData[0];
  //       // getAssetImage();

  //       // OriginalaminityData.value = data["rows"];
  //       // filteraminityData.value = data["rows"];
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //     // Get.snackbar(
  //     //   "E-MLA",
  //     //   "Something Went Wrong!!",
  //     //   icon: const Icon(Icons.person, color: Colors.white),
  //     //   snackPosition: SnackPosition.BOTTOM,
  //     // );
  //   } finally {
  //     profiledataLoading(false);
  //   }
  // }

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

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  var deleteChatLoading = false.obs;

  // bool _switchValue = false;
  //var donorRegistrationData = {}.obs;
  Future<void> captaindeleteChat(String id) async {
    deleteChatLoading(true);
    try {
      var response = await apiService.deleteRequest(
        endpoint: "chat/${id}",
      );

      var data = response;
      print(response);
      if (data == "Chat deleted successfully") {
        // Chat deleted successfully
        Fluttertoast.showToast(
          msg: data,
        );

        // switchValues.value = profileData["isAvailable"];
        // print(switchValues.value);
      } else {
        // loginData.value = data;

        Fluttertoast.showToast(
          msg: data,
        );
        //  Get.toNamed(kSignInScreen);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      deleteChatLoading(false);
    }
  }
  /////////

  //// Socket io List
  var socketioData = [].obs;
  var socketioReceiverID = "".obs;
  var socketiodataLoading = false.obs;

  Future<void> getSocketiochat() async {
    socketiodataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "chat/own-all-chats");
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
        socketioData.value = data;
        for (int i = 0; i < socketioData[0]["members"].length; i++) {
          if (socketioData[0]["members"][i] != profileData["_id"]) {
            socketioReceiverID.value = socketioData[0]["members"][i];
          }
          // if (apicontroller.socketioData[0]["members"][i] != apicontroller.profileData["_id"])
          // calculateDistance(bankdonorsData[i]["location"]["coordinates"][1],
          //     bankdonorsData[i]["location"]["coordinates"][0]);
          // bankdonorsData[i]['distance'] = distanceInKilometers.value;
          print(socketioData[0]["members"][i]);
          print(socketioReceiverID.value);
          //   if(int.parse(kitchen[i]["delivery_time"])<=time.value){
          //   lesstimeKitchen.add(kitchen[i]);
          // }
        }
        Get.toNamed(kChatTestScreen);
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
      socketiodataLoading(false);
    }
  }

  //////////////////Socket Apis
  // 1 Create Chat
  // Method – POST
  // Path  -- rootUrl/chat/
  // Body – {
  // 	receiverId
  // }
  ///////Create Chat///
  var createChatLoading = false.obs;

  Future<void> socketioCreateChat(Map payload) async {
    createChatLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestToken(
          //   var response = await apiService.postAuthRequest(

          endpoint: "chat/",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      var data = response;
      print(response);
      if (data["message"] == "Chat created successfully...!" ||
          data["message"] == "Chat already exists") {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        // Get.toNamed(kChatTestScreen);
        // getProfile();
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
      createChatLoading(false);
    }
  }

  // 4. Creating Message//////////////////////
// 3, Creating message
// 	Method – POST
// 	Path – rootUrl/message/
// 	Body – {
// 		chartId,
// 		message
// 	}

  var createMessageLoading = false.obs;

  Future<void> socketioCreateMessaage(Map payload) async {
    createMessageLoading(true);
    // finddonorMobileEntered.value = payload["attendeeMobile"];

    try {
      //
      var response = await apiService.postRequestToken(
          endpoint: "message/",
// https://blood-server-us7o.onrender.com/auth/registor/blood/need/user
          payload: payload);

      Map data = response;
      print(response);
      if (data["message"] != null) {
        Fluttertoast.showToast(
          msg: data["message"],
        );
        previousChatData.add(data);
        print(previousChatData.value);
        // getProfile();
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
      createMessageLoading(false);
    }
  }

/////////////////////////////////////////////////

  ///////////////Get own Chat
  // 2, Get Own Chat
  // Method – GET
  // Path – rootUrl/chat/own-all-chats
  // RESPONSE  -- Array of single Object
  ////////////////////////////////////////////////////////////////////
  var ownChatData = [].obs;
  var ownChatdataLoading = false.obs;

  Future<void> socketioGetownChat() async {
    ownChatdataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "chat/own-all-chats");
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
        ownChatData.value = data;

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
      ownChatdataLoading(false);
    }
  }

  //////////////// FetchPreviousMessages
  // 3, First Fetch previous message
  // Method—GET
  // Path – rootUrl/message/:chartId
  // RESPONSE – ARRAY of Messages
  var previousChatData = [].obs;
  var previousChatdataLoading = false.obs;

  Future<void> socketioGetpreviousChat(String ID) async {
    previousChatdataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint: "message/${ID}");
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
        previousChatData.value = data;
        print(previousChatData.value);
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
      previousChatdataLoading(false);
    }
  }

  //////////////////BannersforUsers
  var vehicleBannerActive = "".obs;
  var vehiclesbannersData = [].obs;
  var vehiclesbannerDatadataLoading = false.obs;

  Future<void> getvehicleBannersOne() async {
    vehiclesbannerDatadataLoading(true);
    try {
      var response = await apiService.getter(
          //https://new-ram-blood-server.onrender.com
          endpoint:
              //   https://new-ram-blood-server.onrender.com/patient/get/patinet
              "user/banners-offers");
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
        vehiclesbannersData.value = data;

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
      vehiclesbannerDatadataLoading(false);
    }
  }

  ////////////

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
