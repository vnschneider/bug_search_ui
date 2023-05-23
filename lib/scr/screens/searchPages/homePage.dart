import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/scr/screens/searchPages/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  bool buttonHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 40, left: 62, right: 62),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onHover: (bool value) => {
                  setState(() => buttonHover = value),
                },
                onPressed: () =>
                    Navigator.pushNamed(context, 'fordev/overview'),
                style: ButtonStyle(
                  enableFeedback: true,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  backgroundColor: MaterialStateProperty.all(buttonHover
                      ? const Color(0xff657AFF)
                      : const Color(0xff4766EA)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        buttonHover ? Iconsax.setting_21 : Iconsax.setting_2,
                        size: 26,
                        color: const Color(0xffFAFAFB),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "For developers",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Color(0xffFAFAFB)),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          //fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 40),
              FlutterSwitch(
                toggleSize: 44,
                height: 50,
                width: 88,
                borderRadius: 100,
                padding: 6,
                inactiveColor: const Color(0xff4766EA),
                activeColor: const Color(0xFF000000),
                inactiveIcon: const Icon(
                  Iconsax.sun_1,
                  size: 16,
                  color: Color(0xff4766EA),
                ),
                activeIcon: const Icon(
                  Iconsax.moon,
                  size: 16,
                  color: Colors.black,
                ),
                duration: const Duration(milliseconds: 300),
                value: isSwitched,
                onToggle: (bool value) {
                  setState(() => isSwitched = value);
                },
              ),
            ],
          ),

          //BODY//
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //BRANDING//

              Text(
                'Bug Search',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Color(0xff4766EA)),
                  fontSize: 58,

                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                ),
              ),

              //SEARCH BAR//
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: 62,
                  width: 860,
                  decoration: BoxDecoration(
                    color: const Color(0xff4766EA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      //controller: _passwordController,

                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              hoverColor: const Color(0xff657AFF),
                              highlightColor: const Color(0xff848FFF),
                              iconSize: 28,
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.camera,
                                color: Color(0xffFAFAFB),
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              iconSize: 28,
                              hoverColor: const Color(0xff657AFF),
                              highlightColor: const Color(0xff848FFF),
                              onPressed: () {
                                Navigator.pushNamed(context, 'search');
                              },
                              icon: const Icon(
                                Iconsax.search_status_1,
                                color: Color(0xffFAFAFB),
                              ),
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        hintText: 'O que você está procurando?',
                        hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Color(0xffFAFAFB)),
                          fontSize: 18,

                          fontWeight: FontWeight.w400,
                          //fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 264,
                child: Card(
                  color: const Color(0xff4766EA),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 26,
                                hoverColor: const Color(0xff657AFF),
                                highlightColor: const Color(0xff848FFF),
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.information,
                                  color: Color(0xffFAFAFB),
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'Sobre o projeto',
                                style: TextStyle(
                                  color: Color(0xffFAFAFB),
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  //fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                            style: TextStyle(
                              color: Color(0xffFAFAFB),
                              fontSize: 14,

                              // overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal,
                              //fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )

        /*Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'search');
          },
          child: const Text("Home Page"),
        ),
      ),*/
        );
  }
}
