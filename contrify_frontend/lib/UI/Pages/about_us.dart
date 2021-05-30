import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contrify/Constants/colors.dart' as AppColors;

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  final String sometext =
      'Contrify alerts the users whenever a new unique smart contract is deployed on the Tezos mainnet.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: false,
          title: Text(
            'ABOUT',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 23,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('$sometext',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Developers',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            DevProfile(
                fontend: 'Backend Developer',
                image: 'https://avatars.githubusercontent.com/u/50164581?v=4',
                github: 'https://github.com/Anshit01',
                linkdin: 'https://www.linkedin.com/in/anshit01/',
                name: 'Anshit Bhardwaj'),
            DevProfile(
                fontend: 'Frontend Developer',
                image:
                    'https://avatars.githubusercontent.com/u/55653609?s=400&v=4',
                github: 'https://github.com/SushantChandla',
                linkdin: 'https://www.linkedin.com/in/sushantchandla/',
                name: 'Sushant Chandla'),
            DevProfile(
                fontend: 'UI/UX Developer',
                image: 'https://avatars.githubusercontent.com/u/57187745?v=4',
                github: 'https://github.com/shwetalsoni',
                linkdin: 'https://www.linkedin.com/in/shwetalsoni/',
                name: 'Shwetal Soni'),
          ],
        ));
  }
}

class DevProfile extends StatelessWidget {
  const DevProfile(
      {Key? key,
      required this.fontend,
      required this.image,
      required this.github,
      required this.linkdin,
      required this.name})
      : super(key: key);
  final String image, name, fontend, linkdin, github;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Image.network(
                image,
                height: 80,
                width: 80,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                Text(
                  fontend,
                  style: GoogleFonts.poppins(),
                )
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        launch(linkdin);
                      },
                      icon: SvgPicture.asset(
                          'assets/icons/linkedin-circled.svg')),
                  IconButton(
                      onPressed: () {
                        launch(github);
                      },
                      icon: SvgPicture.asset('assets/icons/github.svg'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
