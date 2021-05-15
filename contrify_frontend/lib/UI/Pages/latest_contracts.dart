import 'package:contrify/Models/Contract.dart';
import 'package:contrify/UI/Pages/contract_explorer.dart';
import 'package:flutter/material.dart';
import 'package:contrify/Constants/colors.dart' as AppColors;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestContractsPage extends StatefulWidget {
  const LatestContractsPage({Key? key}) : super(key: key);

  @override
  _LatestContractsPageState createState() => _LatestContractsPageState();
}

class _LatestContractsPageState extends State<LatestContractsPage> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_isSearching)
              setState(() => _isSearching = false);
            else {
              Navigator.pop(context);
            }
          },
        ),
        title: _isSearching
            ? TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Search smart contract by address...',
                    hintStyle: GoogleFonts.poppins()))
            : null,
        actions: [
          if (!_isSearching)
            IconButton(
                onPressed: () => setState(() => _isSearching = true),
                icon: SvgPicture.asset('assets/icons/search.svg'))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            for (int i = 0; i < 5; i++)
              ContractItem(
                  c: Contract(
                      address: 'KT1922Z1i85rj2YbvMBGgoduQTZ9Q7cKDpBp',
                      amount: 2000000,
                      creatorName: 'Anshit Bhardwaj',
                      firstActivity: DateTime.now(),
                      lastActivity: DateTime.now()))
          ],
        ),
      ),
    );
  }
}

class ContractItem extends StatelessWidget {
  final Contract c;
  const ContractItem({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContractExplore(
                    c: c,
                  ))),
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              color: AppColors.CARD_TOP,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/contract.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${c.address}',
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(fontSize: 14),
                    style: GoogleFonts.notoSans(fontSize: 14),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text('${c.creatorName}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins()
                          // style: TextStyle(fontSize: 15),
                          )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${c.amount}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(),
                        // style: TextStyle(fontSize: 15),
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
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  Row(
                    children: [
                      Text('${c.getLastActivity}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontSize: 12)),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/icons/clock.svg',
                        height: 18,
                        width: 18,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
