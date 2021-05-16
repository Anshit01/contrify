import 'package:contrify/Models/Contract.dart';
import 'package:contrify/StateManagement/app_state.dart';
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
  final state = AppState.instance;
  bool _isloading = false;

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (_isSearching)
              setState(() => _isSearching = false);
            else {
              Navigator.pop(context);
            }
          },
        ),
        centerTitle: false,
        title: _isSearching
            ? TextFormField(
                controller: _controller,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                onFieldSubmitted: (text) async {
                  setState(() {
                    _isloading = true;
                  });
                  Contract? c =
                      await AppState.instance.searchAddress(_controller.text);
                  if (c != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContractExplore(c: c)));
                  }
                  _controller.text = '';
                  setState(() {
                    _isloading = false;
                    _isSearching = false;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search smart contract by address...',
                    hintStyle: GoogleFonts.poppins(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/search.svg',
                        color: Colors.white,
                        height: 24,
                        width: 24,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isloading = true;
                        });
                        Contract? c = await AppState.instance
                            .searchAddress(_controller.text);
                        if (c != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContractExplore(c: c)));
                        }
                        _controller.text = '';
                        setState(() {
                          _isloading = false;
                          _isSearching = false;
                        });
                      },
                    )))
            : Text('CONTRIFY'),
        actions: [
          if (!_isSearching)
            IconButton(
                onPressed: () => setState(() => _isSearching = true),
                icon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  height: 24,
                  width: 24,
                ))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            StreamBuilder<List<Contract>>(
                stream: state.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!
                          .map((e) => ContractItem(c: e))
                          .toList(),
                    );
                  }
                  return Center(
                    child: Text('No Contract found'),
                  );
                }),
            if (_isloading)
              Center(
                  child: Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              )),
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
        elevation: 2,
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              color: AppColors.CARD_TOP,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    style: GoogleFonts.notoSans(fontSize: 13),
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
