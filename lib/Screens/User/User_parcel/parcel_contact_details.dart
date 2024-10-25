// import 'package:womentaxi/untils/export_file.dart';

// class ParcelContactDetails extends StatefulWidget {
//   const ParcelContactDetails({super.key});

//   @override
//   State<ParcelContactDetails> createState() => _ParcelContactDetailsState();
// }

// class _ParcelContactDetailsState extends State<ParcelContactDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'package:womentaxi/untils/export_file.dart';

class ParcelContactDetails extends StatefulWidget {
  const ParcelContactDetails({super.key});

  @override
  State<ParcelContactDetails> createState() => _ParcelContactDetailsState();
}

class _ParcelContactDetailsState extends State<ParcelContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Kwhite,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        topRight: Radius.circular(8.r)),
                    child: const Google_map()),
              )
            ],
          ),
        ),
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(15.r),
            color: Kwhite,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  enabled: true,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Full Name",
                  maxLines: 1,
                  readOnly: false,
                  label: 'Full Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Full Name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomFormField(
                  maxLength: 10,
                  enabled: true,
                  prefix: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                    child: Text(
                      " +91",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, fontWeight: kFW500, color: kblack),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Your mobile no",
                  maxLines: 1,
                  readOnly: false,
                  label: "Mobile no",
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  validator: (value) {
                    if (value.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                            .hasMatch(value)) {
                      //  r'^[0-9]{10}$' pattern plain match number with length 10
                      return "Mobile number least 10 digits";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomFormField(
                  enabled: true,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Address",
                  maxLines: 1,
                  readOnly: false,
                  label: 'Address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter  Address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomFormField(
                  enabled: true,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Landmark",
                  maxLines: 1,
                  readOnly: false,
                  label: 'Landmark',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter  Landmark';
                    }
                    return null;
                  },
                ),
                CustomButton(
                    margin: EdgeInsets.only(top: 40.h),
                    width: double.infinity,
                    height: 42.h,
                    fontSize: kFourteenFont,
                    fontWeight: kFW700,
                    textColor: Kwhite,
                    borderRadius: BorderRadius.circular(30.r),
                    label: "Save and Proceed",
                    isLoading: false,
                    onTap: () {
                      Get.toNamed(kUserDashboard);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
