import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';


import 'package:womentaxi/untils/export_file.dart';


// import '../constants.dart';


class LocationListTile extends StatelessWidget {

  const LocationListTile({

    Key? key,

    required this.location,

    required this.press,

  }) : super(key: key);


  final String location;


  final VoidCallback press;


  @override

  Widget build(BuildContext context) {

    return Column(

      children: [

        ListTile(

          onTap: press,

          horizontalTitleGap: 3,

          leading: CircleAvatar(

              backgroundColor: Kpink.withOpacity(0.5),

              radius: 16.r,

              child: Icon(

                Icons.location_on,

                color: Kpink,

                size: 20.sp,

              )),

          title: Text(

            location,

            maxLines: 2,

            overflow: TextOverflow.ellipsis,

          ),

        ),

        Divider(

          height: 1,

          thickness: 1,

          color: KdarkText.withOpacity(0.2),

        ),

      ],

    );

  }

}

