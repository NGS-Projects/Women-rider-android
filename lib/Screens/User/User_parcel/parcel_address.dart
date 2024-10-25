import 'package:womentaxi/untils/export_file.dart';

class ParcelAddressScreen extends StatefulWidget {
  const ParcelAddressScreen({super.key});

  @override
  State<ParcelAddressScreen> createState() => _ParcelAddressScreenState();
}

class _ParcelAddressScreenState extends State<ParcelAddressScreen> {
  final List<String> bloodgroupss = [
    'Food',
    'Medicines',
    'Electronics',
    'Clothes',
    'Others'
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: AppBar(
        backgroundColor: Kwhite,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: KTextdark,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Parcel Address",
          style: GoogleFonts.roboto(
              fontSize: 22.sp, color: kcarden, fontWeight: kFW600),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Ktextcolor.withOpacity(0.5),
                      blurRadius: 5.r,
                      offset: Offset(1, 1),
                      spreadRadius: 1.r,
                    )
                  ],
                  color: Kwhite,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: greenColor,
                          radius: 5.r,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HMT Hills Ramalayam",
                              style: GoogleFonts.roboto(
                                  fontSize: kFourteenFont,
                                  color: kcarden,
                                  fontWeight: kFW500),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                "325, High Tension Line Rd, Srinivas Colony, Aditya Nagar, Kukatpally, Hyderabad, Telangana 500072",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: kTwelveFont,
                                    color: Ktextcolor,
                                    fontWeight: kFW500),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(kUserParcelDetails);
                              },
                              child: Container(
                                height: 42.h,
                                width: 200.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: Border.all(
                                        color: Ktextcolor, width: 1)),
                                child: Text(
                                  " + Add Address / Contact",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: kFourteenFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Kpink,
                          radius: 5.r,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Long Drive Cars",
                              style: GoogleFonts.roboto(
                                  fontSize: kFourteenFont,
                                  color: kcarden,
                                  fontWeight: kFW500),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                "Suryey no 305 Opp Tulsi vanam Ladies Hostel Paradise Lane, South india Shopping mall, beside Lane, Kukatpally Housing Board Colony, Kukatpally, Hyderabad, Telangana 500072",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: kTwelveFont,
                                    color: Ktextcolor,
                                    fontWeight: kFW500),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(kUserParcelDetails);
                              },
                              child: Container(
                                height: 42.h,
                                width: 200.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: Border.all(
                                        color: Ktextcolor, width: 1)),
                                child: Text(
                                  " + Add Address / Contact",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: kFourteenFont,
                                      color: Ktextcolor,
                                      fontWeight: kFW700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 60.h,
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.only(top: 90.h),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Ktextcolor.withOpacity(0.5),
                      blurRadius: 5.r,
                      offset: Offset(1, 1),
                      spreadRadius: 1.r,
                    )
                  ],
                  color: Kwhite,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: Text(
                    'Select  Category',
                    style: GoogleFonts.roboto(fontSize: 14),
                  ),
                  items: bloodgroupss
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select BloodGroup.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // authentication.findDonorBloodGroup.value =
                      //     value.toString();
                      selectedValue = value.toString();
                      print(selectedValue);
                    });

                    // authentication.registerDonorBloodController.value =
                    //     selectedValue as TextEditingValue;
                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                    print(selectedValue);
                    // authentication.registerDonorBloodController.value =
                    //     selectedValue as TextEditingValue;
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: KText,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
