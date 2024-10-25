import 'package:womentaxi/untils/export_file.dart';

class NoOrdersWidget extends StatefulWidget {
  const NoOrdersWidget({super.key});

  @override
  State<NoOrdersWidget> createState() => _NoOrdersWidgetState();
}

class _NoOrdersWidgetState extends State<NoOrdersWidget> {
  @override
  void initState() {
    Get.toNamed(KDashboard);
    // Get.back();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "No Orders",
        style: GoogleFonts.roboto(
            fontSize: kSixteenFont, color: KdarkText, fontWeight: kFW500),
      ),
    );
  }
}
