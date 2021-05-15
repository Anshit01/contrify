import 'package:contrify/UI/Pages/about_us.dart';
import 'package:contrify/UI/Pages/latest_contracts.dart';
import 'package:flutter/material.dart';
import 'package:contrify/Constants/colors.dart' as AppColors;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs())),
                  icon: SvgPicture.asset('assets/icons/info.svg'))),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Contrify",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.righteous(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 48,
                      fontWeight: FontWeight.w400)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        hintText: 'Search smart contract by address',
                        hintStyle: GoogleFonts.poppins(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(30)),
                        )),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Total Contracts', style: GoogleFonts.poppins()),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '500',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('FA Token', style: GoogleFonts.poppins()),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '100',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Contract Calls',
                          style: GoogleFonts.poppins(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '20000',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34.0, vertical: 30),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LatestContractsPage())),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Text(
                      'Browser Latest Contracts',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.PRIMARY_COLOR),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
