// ignore_for_file: file_names
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bug_search/scr/models/bsLogo.dart';
import 'package:bug_search/scr/models/customButton.dart';
import 'package:bug_search/scr/models/searchBar.dart';
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
              CustomButton(
                text: 'For developers',
                isIconButton: true,
                icon: BootstrapIcons.gear,
                iconHover: BootstrapIcons.gear_fill,
                function: () => Navigator.pushNamed(context, 'fordev/overview'),
              ),
              const SizedBox(width: 40),
              FlutterSwitch(
                toggleSize: 42,
                height: 50,
                width: 84,
                borderRadius: 50,
                padding: 6,
                inactiveColor: const Color(0xff4766EA),
                activeColor: const Color(0xFF000000),
                inactiveIcon: const Icon(
                  BootstrapIcons.brightness_low,
                  //size: 44,
                  color: Color(0xff4766EA),
                ),
                activeIcon: const Icon(
                  BootstrapIcons.moon,
                  //size: 44,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BSLogo(),
                  Text(
                    ' | Bug Search',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              const CustomSearchBar(height: 62, width: 860),
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
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
                                tooltip: 'Sobre',
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
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 25,
                            style: TextStyle(
                              color: ThemeData.from(
                                      colorScheme: const ColorScheme.light())
                                  .colorScheme
                                  .onPrimary,

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
        );
  }
}
