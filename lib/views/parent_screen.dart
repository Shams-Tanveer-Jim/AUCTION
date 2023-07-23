import 'package:bidbox/services/google_signin.dart';
import 'package:bidbox/views/dashboard_screen.dart';
import 'package:bidbox/views/own_items.dart';
import 'package:bidbox/views/widgets/form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/assets.dart';
import '../consts/colors.dart';
import 'auction_screen.dart';
import 'login_screen.dart';
import 'mybids_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    AuctionScreen(),
    OwnItems(),
    MyBidsScreen(),
    DashBoardScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.hasData) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    ColorConstants.backgroundColor2,
                    ColorConstants.backgroundColor1,
                  ],
                ),
              ),
              child: Scaffold(
                backgroundColor: ColorConstants.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: ColorConstants.transparent,
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  centerTitle: true,
                  leading: Container(),
                  title: Text("AUCTION",
                      style: GoogleFonts.comicNeue(
                          fontSize: 22, fontWeight: FontWeight.w800)),
                  actions: [
                    IconButton(
                        onPressed: () {
                          GoogleServices.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ))
                  ],
                ),
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.amber,
                      selectedLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12 // Set the color of the selected label
                          ),
                      unselectedItemColor: Colors.white,
                      selectedItemColor: Colors.black,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: _selectedIndex,
                      onTap: _onItemTapped,
                      items: [
                        BottomNavigationBarItem(
                          icon: Image(
                            color: _selectedIndex == 0
                                ? Colors.black
                                : Colors.white,
                            image: const AssetImage(AssetsConstant.autionItem),
                            width: 30,
                          ),
                          label: 'AUCTION ITEMS',
                        ),
                        BottomNavigationBarItem(
                          icon: Image(
                            color: _selectedIndex == 1
                                ? Colors.black
                                : Colors.white,
                            image: const AssetImage(AssetsConstant.yourItem),
                            width: 25,
                          ),
                          label: 'MY PRODUCTS',
                        ),
                        BottomNavigationBarItem(
                          icon: Image(
                            image: const AssetImage(AssetsConstant.washList),
                            color: _selectedIndex == 2
                                ? Colors.black
                                : Colors.white,
                            width: 25,
                          ),
                          label: 'My BIDS',
                        ),
                        BottomNavigationBarItem(
                          icon: Image(
                            color: _selectedIndex == 3
                                ? Colors.black
                                : Colors.white,
                            image: const AssetImage(AssetsConstant.dashboard),
                            width: 25,
                          ),
                          label: 'DASHBOARDS',
                        ),
                      ],
                    ),
                  ],
                ),
                body: _children[_selectedIndex],
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      context: context,
                      builder: (context) => ShowAddProductForm(),
                    );
                  },
                  child: Image.asset(
                    AssetsConstant.addProduct,
                    width: 40,
                  ),
                ),
              ),
            );
          } else {
            return const LoginScreen();
          }
        });
  }
}
