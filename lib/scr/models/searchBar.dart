// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBar extends StatelessWidget {
  final double height;
  final double width;

  const CustomSearchBar({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return //SEARCH BAR//
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        alignment: Alignment.center,
        height: height, //62
        width: width, //860
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
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
                    tooltip: 'Imagem',
                    hoverColor: Theme.of(context).colorScheme.secondary,
                    highlightColor: Theme.of(context).colorScheme.tertiary,
                    iconSize: 28,
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.camera,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    tooltip: 'Pesquisar',
                    iconSize: 28,
                    hoverColor: Theme.of(context).colorScheme.secondary,
                    highlightColor: Theme.of(context).colorScheme.tertiary,
                    onPressed: () {
                      Navigator.pushNamed(context, 'search');
                    },
                    icon: Icon(
                      Iconsax.search_status_1,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              border: InputBorder.none,
              hintText: 'O que você está procurando?',
              hintStyle: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineMedium,
                //fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
