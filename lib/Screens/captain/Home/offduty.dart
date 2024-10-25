import 'package:womentaxi/untils/export_file.dart';

class OffdutyCard extends StatefulWidget {
  const OffdutyCard({super.key});

  @override
  State<OffdutyCard> createState() => _OffdutyCardState();
}

class _OffdutyCardState extends State<OffdutyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Image.asset("assets/images/switchon.gif", width: 100),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          "Good Morning, Captain",
          style: GoogleFonts.roboto(
              fontSize: kSixteenFont,
              fontWeight: kFW400,
              height: 1.2,
              color: Ktextcolor),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "Go ON DUTY to start earning",
          style: GoogleFonts.roboto(
              fontSize: kEighteenFont,
              fontWeight: kFW700,
              height: 1.2,
              color: kcarden),
        ),
        SizedBox(
          height: 90.h,
        ),
        Banners()
      ],
    );
  }
}
