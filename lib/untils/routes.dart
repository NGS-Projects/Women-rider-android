// import 'package:nuhvinbloodbank/untils/export_file.dart';

import 'package:womentaxi/untils/export_file.dart';

class Routes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: KSplash,
        transition: Transition.rightToLeft,
        page: () => SplashScreen()),
    GetPage(
        name: KOnboarding,
        transition: Transition.rightToLeft,
        page: () => OnBoarding()),
    GetPage(
        name: KMobileRegistration,
        transition: Transition.rightToLeft,
        page: () => PhoneRegistration()),
    GetPage(
        name: KOtpVerification,
        transition: Transition.rightToLeft,
        page: () => OtpVerify()),
    GetPage(
        name: KDashboard,
        transition: Transition.rightToLeft,
        page: () => Dashboard()),
    GetPage(
        name: KNotifications,
        transition: Transition.rightToLeft,
        page: () => Notifications()),
    GetPage(
        name: KProfile,
        transition: Transition.rightToLeft,
        page: () => Profile()),
    GetPage(
        name: KEarningsScreen,
        transition: Transition.rightToLeft,
        page: () => EarningsScreen()),
    GetPage(
        name: kAcceptOrders,
        transition: Transition.rightToLeft,
        page: () => OrdersList()),
    GetPage(
        name: kArrivedScreen,
        transition: Transition.rightToLeft,
        page: () => ArrivedScreen()),
    GetPage(
        name: kDropScreen,
        transition: Transition.rightToLeft,
        page: () => DropScreen()),
    GetPage(
        name: kSelectType,
        transition: Transition.rightToLeft,
        page: () => SelectFlow()),
    GetPage(
        name: kUserDashboard,
        transition: Transition.rightToLeft,
        page: () => UserDashboard()),
    GetPage(
        name: kUserSelectDrop,
        transition: Transition.rightToLeft,
        page: () => UserSelectDrop()),
    GetPage(
        name: kUserBookRide,
        transition: Transition.rightToLeft,
        page: () => UserBookRide()),
    GetPage(
        name: kUserProfile,
        transition: Transition.rightToLeft,
        page: () => UserProfile()),
    GetPage(
        name: kUserNotifications,
        transition: Transition.rightToLeft,
        page: () => UserNotifications()),
    GetPage(
        name: kUserRideHistory,
        transition: Transition.rightToLeft,
        page: () => RideHistory()),
    GetPage(
        name: kUserPayments,
        transition: Transition.rightToLeft,
        page: () => UserPayments()),
    GetPage(
        name: kUserRaidOtp,
        transition: Transition.rightToLeft,
        page: () => RaidOtp()),
    GetPage(
        name: kUserParcel,
        transition: Transition.rightToLeft,
        page: () => ParcelScreen()),
    GetPage(
        name: kUserParcelAddress,
        transition: Transition.rightToLeft,
        page: () => ParcelAddressScreen()),
    GetPage(
        name: kUserParcelDetails,
        transition: Transition.rightToLeft,
        page: () => ParcelContactDetails()),
    GetPage(
        name: kUserRestaurantList,
        transition: Transition.rightToLeft,
        page: () => UserRestaurantList()),
    GetPage(
        name: kUserRestaurantDetail,
        transition: Transition.rightToLeft,
        page: () => restaurant_detail()),
    GetPage(
        name: kUserCart,
        transition: Transition.rightToLeft,
        page: () => Cart_screen()),
    GetPage(
        name: kUserConfirmOrder,
        transition: Transition.rightToLeft,
        page: () => Confirm_order()),
    GetPage(
        name: kUserOrdersHistory,
        transition: Transition.rightToLeft,
        page: () => My_orders()),
    GetPage(
        name: kUserPhoneRegister,
        transition: Transition.rightToLeft,
        page: () => UserPhoneRegistration()),
    GetPage(
        name: kUserOtpVerify,
        transition: Transition.rightToLeft,
        page: () => UserOtpVerify()),
    GetPage(
        name: kCollectAmount,
        transition: Transition.rightToLeft,
        page: () => CollectAmount()),
    GetPage(
        name: kFacialBiometric,
        transition: Transition.rightToLeft,
        page: () => AppBiometric()),
    GetPage(
        name: kFingerPrints,
        transition: Transition.rightToLeft,
        page: () => FingerprintScreen()),
    GetPage(
        name: kTrackingScreen,
        transition: Transition.rightToLeft,
        page: () => DeliveryScreen()),
    GetPage(
        name: kMappleLocationScreen,
        transition: Transition.rightToLeft,
        page: () => MapplScreen()),
    GetPage(
        name: KSignUp,
        transition: Transition.rightToLeft,
        page: () => SignUp()),
    GetPage(
        name: kCompletedOrdersScreen,
        transition: Transition.rightToLeft,
        page: () => CompletedOrdersList()),
    GetPage(
        name: kMergeMapplsScreen,
        transition: Transition.rightToLeft,
        page: () => MapScreen()),
    GetPage(
        name: kAuth_Screen,
        transition: Transition.rightToLeft,
        page: () => AuthScreen()),
    GetPage(
        name: kEditProfileScreen,
        transition: Transition.rightToLeft,
        page: () => EditProfile()),
    GetPage(
        name: kUserBookRideAuth,
        transition: Transition.rightToLeft,
        page: () => UserBookRideAuth()),
    GetPage(
        name: kBiometricRegistration,
        transition: Transition.rightToLeft,
        page: () => BiometricsRegister()),
    GetPage(
        name: kCaptainUploads,
        transition: Transition.rightToLeft,
        page: () => UploadDocs()),
    GetPage(
        name: kCaptainReviews,
        transition: Transition.rightToLeft,
        page: () => CaptainReview()),
    GetPage(
        name: kUserUploadDocs,
        transition: Transition.rightToLeft,
        page: () => UserUploadDocs()),
    GetPage(
        name: kCaptainAuthenticationUpload,
        transition: Transition.rightToLeft,
        page: () => CaptainBiometricsUpload()),
    GetPage(
        name: kRazorPay,
        transition: Transition.rightToLeft,
        page: () => SampleRazorPay()),
    GetPage(
        name: kpaymentsScreen,
        transition: Transition.rightToLeft,
        page: () => PaymentScreen()),
    GetPage(
        name: kphoneCallScreen,
        transition: Transition.rightToLeft,
        page: () => FlutterPhone()),
    GetPage(
        name: kChatTestScreen,
        transition: Transition.rightToLeft,
        //   page: () => ChatScreen(receiverId: "Ram", senderId: "Charan")),
        // page: () => ChatScreen(receiverId: "Charan", senderId: "Ram")),
        page: () => ChatScreen()),
    GetPage(
        name: kRouteGMapsTestScreen,
        transition: Transition.rightToLeft,
        page: () => RouteScreen()),
    GetPage(
        name: kCaptainPickUpNavigation,
        transition: Transition.rightToLeft,
        page: () => CaptainRouteScreen()),
    GetPage(
        name: kCaptainDropNavigation,
        transition: Transition.rightToLeft,
        page: () => CaptainDropRouteScreen()),
    GetPage(
        name: kPlacesSearch,
        transition: Transition.rightToLeft,
        page: () => PlacesSearch()),
    GetPage(
        name: kUserSendParcel,
        transition: Transition.rightToLeft,
        page: () => UserSendparcel()),
    GetPage(
        name: kUserDropNavigation,
        transition: Transition.rightToLeft,
        page: () => UserDropRouteScreen()),
    GetPage(
        name: kHelpDesk,
        transition: Transition.rightToLeft,
        page: () => HelpDesk()),
    GetPage(
        name: kPrivacyPolicies,
        transition: Transition.rightToLeft,
        page: () => PrivacyPolicies()),
    GetPage(
        name: kSearchPlacesV2,
        transition: Transition.rightToLeft,
        page: () => SearchLocationScreen()),
    GetPage(
        name: kGmapstestpolilines,
        transition: Transition.rightToLeft,
        page: () => GoogleMapPage()),
    GetPage(
        name: kGmapsSelect,
        transition: Transition.rightToLeft,
        page: () => PickAddressonMap()),
    GetPage(
        name: kUserFavourites,
        transition: Transition.rightToLeft,
        page: () => FavouritesList()),
    GetPage(
        name: kUserCompletRideScreen,
        transition: Transition.rightToLeft,
        page: () => UserCompleteScreen()),
    GetPage(
        name: kAdhaarScreen,
        transition: Transition.rightToLeft,
        page: () => AdhaarVerify()),
    GetPage(
        name: kAdhaarOTPScreen,
        transition: Transition.rightToLeft,
        page: () => AdhaarOtpVerify()),
    GetPage(
        name: kPanScreen,
        transition: Transition.rightToLeft,
        page: () => PanVerify()),
    GetPage(
        name: kRCScreen,
        transition: Transition.rightToLeft,
        page: () => rcVerify()),
    GetPage(
        name: kDlScreen,
        transition: Transition.rightToLeft,
        page: () => licenseVerify()),
    GetPage(
        name: kCitySearchScreen,
        transition: Transition.rightToLeft,
        page: () => CitySearch()),
    GetPage(
        name: kUserPersonalInformationScreen,
        transition: Transition.rightToLeft,
        page: () => UserPersonalInformation()),
    GetPage(
        name: kUserDocsVerifyScreen,
        transition: Transition.rightToLeft,
        page: () => UserUploadVerifyDocs()),
    GetPage(
        name: kUserAnyIDScreen,
        transition: Transition.rightToLeft,
        page: () => UserAnyId()),
    GetPage(
        name: kChangeRoleOTPScreen,
        transition: Transition.rightToLeft,
        page: () => CahngeRoleOTP()),
    GetPage(
        name: kNewSignUpScreen,
        transition: Transition.rightToLeft,
        page: () => NewSignUp()),
    GetPage(
        name: kNewDocScreen,
        transition: Transition.rightToLeft,
        page: () => NewDocVerification()),
    GetPage(
        name: kAddContactScreen,
        transition: Transition.rightToLeft,
        page: () => AddContact()),
    GetPage(
        name: kNewPhoneScreen,
        transition: Transition.rightToLeft,
        page: () => NewPhoneNumber()),
    GetPage(
        name: kNewOtpScreen,
        transition: Transition.rightToLeft,
        page: () => NewOtpScreen()),
    GetPage(
        name: kNewSelectRoleScreen,
        transition: Transition.rightToLeft,
        page: () => NewSelectRole()),
    GetPage(
        name: kNewAdhaarPanScreen,
        transition: Transition.rightToLeft,
        page: () => NewAdhaarPan()),
    GetPage(
        name: kNewAdhaarOtpScreen,
        transition: Transition.rightToLeft,
        page: () => NewAdhaarOtpScreen()),
    GetPage(
        name: kNewBiometricScreen,
        transition: Transition.rightToLeft,
        page: () => NewAuthenticationImageUpload()),
    GetPage(
        name: kTestFIleScreen,
        transition: Transition.rightToLeft,
        page: () => FileConvert()),
    GetPage(
        name: kNewAdharPanUploadScreen,
        transition: Transition.rightToLeft,
        page: () => NewAadharPanUploadDOcs()),
    GetPage(
        name: kPhonePeScreen,
        transition: Transition.rightToLeft,
        page: () => PhonePeTestScreen()),
    GetPage(
        name: kTestRazorQRScreen,
        transition: Transition.rightToLeft,
        page: () => RazorpayQRImage()),

// kNewAdharPanUploadScreen
// kNewAdhaarOtpScreen

// kDlScreen
// kPanScreen
// kSearchPlacesV2
    // kPlacesSearch
    // kCaptainDropNavigation
// kCaptainPickUpNavigation
    // kRouteGMapsTestScreen

// kpaymentsScreen
    // GetPage(
    //     name: kTestNavigation,
    //     transition: Transition.rightToLeft,
    //     page: () => MappScreen()),
    // kTestNavigation
// kCaptainAuthenticationUpload
    // kBiometricRegistration

    // kMappleLocationScreen

//
// kCollectAmount
// kUserOtpVerify
// kUserPhoneRegister

    // kUserOrdersHistory

    // kUserConfirmOrder

// kUserCart
    //  kUserRestaurantDetail
    // kUserRestaurantList

// kUserParcelDetails
    //  kUserParcelAddress

//   kUserParcel
    // kUserRaidOtp

// kUserPayments
//   kUserRideHistory
// kUserNotifications
    // kUserProfile

// kUserBookRide
    // kUserSelectDrop
// kUserDashboard
    // kSelectType

    // kArrivedScreen
// kAcceptOrders
    // KEarningsScreen
    // KProfile
// KNotifications
    // KDashboard
    // KOtpVerification
    // KMobileRegistration
    // KOnboarding
  ];
}
