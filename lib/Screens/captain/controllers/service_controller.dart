import 'package:womentaxi/untils/export_file.dart';
import 'package:geolocator/geolocator.dart';

class ServiceController extends GetxController {
  var longitude = -122.085749655962;
  var latittude = 37.42796133580664;
  var liveTracklongitude = -122.085749655962;
  var liveTracklatittude = 37.42796133580664;
  var captainlongitude = -122.085749655962;
  var captainlatittude = 37.42796133580664;
  TextEditingController celebratepost = TextEditingController();
  TextEditingController message = TextEditingController();
  var address = "".obs;
  var captainaddress = "".obs;
  var addressLatitude = "".obs;
  var addressLongitude = "".obs;
  var captainaddressLatitude = "".obs;
  var captainaddressLongitude = "".obs;
  var loacationIsEnabled = false.obs;

  Position? position;
  Position? liveTrackposition;
  Position? captainposition;
  String celebrateText = "";
  String profileImageData = "";
  var eachStoryList = {}.obs;
  var isLoading = false.obs;
  var empId = 0.obs;
  int? celebrateID;
  @override
  void onInit() {
    celebrateText = "";
    super.onInit();
  }

  void postCelebrateData(Map data) {
    celebrateText = data["description"];
    celebratepost.text = data["description"];
    celebrateID = data["celebrate_id"];
  }

  void storeStoryData(data) {
    eachStoryList.value = data;
  }

  void setLoading(bool data) {
    isLoading.value = data;
  }

  void setIndex(int number) {
    empId.value = number;
  }
}
