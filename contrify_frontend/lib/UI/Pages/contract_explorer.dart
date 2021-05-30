import 'package:contrify/Models/Contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contrify/Constants/colors.dart' as AppColors;

class ContractExplore extends StatelessWidget {
  const ContractExplore({Key? key, required this.c}) : super(key: key);
  final Contract c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          'EXPLORER',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(236, 235, 235, 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/contract.png',
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${c.address}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.notoSans(
                              fontSize: 13,
                              color: Color.fromRGBO(51, 51, 51, 1)),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Clipboard.setData(ClipboardData(text: c.address))
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                              'Address Copied to Clipboard')))),
                          child: Text(
                            'Copy',
                            style: GoogleFonts.nunito(
                                color: Colors.blue, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Creator',
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(222, 220, 220, 1)),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(255, 253, 253, 1),
                ),
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/user-male.svg',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${c.creatorName}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${c.address}',
                      style: GoogleFonts.notoSans(
                        color: Color.fromRGBO(92, 89, 89, 1),
                          fontSize: 13, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Balance',
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(222, 220, 220, 1)),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(255, 253, 253, 1),
                ),
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      '${c.amount}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/icons/tezos_logo.svg',
                      height: 14,
                      width: 14,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'First Activity',
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(222, 220, 220, 1)),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(255, 253, 253, 1),
                ),
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/calender.png',
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${c.getFirstActivity}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 12),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Last Activity',
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(222, 220, 220, 1)),
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(255, 253, 253, 1),
                ),
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      height: 18,
                      width: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${c.getLastActivity}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                    onPressed: () => launch(c.url),
                    child: Text(
                      'View on Better Call Dev',
                      style: GoogleFonts.poppins(
                          color: Color.fromRGBO(3, 69, 171, 1)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
