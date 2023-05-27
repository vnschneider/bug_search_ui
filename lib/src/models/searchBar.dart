// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBar extends StatefulWidget {
  final double height;
  final double width;
  final bool? customHintText;
  final String? hintText;
  final void Function(String)? onSubmitted;
  final void Function()? onPress;
  final TextEditingController searchController;

  const CustomSearchBar({
    super.key,
    required this.height,
    required this.width,
    this.customHintText,
    this.hintText,
    this.onSubmitted,
    required this.searchController,
    this.onPress,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      isTyping = widget.searchController.text.isNotEmpty;
    });
  }

  void _clearText() {
    setState(() {
      widget.searchController.clear();
      isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return //SEARCH BAR//
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        alignment: Alignment.center,
        height: widget.height, //62
        width: widget.width, //860
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: widget.searchController,
            onSubmitted: widget.onSubmitted,

            //controller: _passwordController,

            decoration: InputDecoration(
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  isTyping
                      ? Row(
                          children: [
                            IconButton(
                              tooltip: 'Limpar barra de pesquisa',
                              hoverColor:
                                  Theme.of(context).colorScheme.secondary,
                              highlightColor:
                                  Theme.of(context).colorScheme.tertiary,
                              iconSize: 28,
                              onPressed: () {
                                _clearText();
                              },
                              icon: Icon(
                                Iconsax.close_square,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '|',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      : const SizedBox(),
                  IconButton(
                    tooltip: 'Pesquisar por imagem',
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
                    onPressed: widget.onPress,
                    icon: Icon(
                      Iconsax.search_status_1,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
              border: InputBorder.none,
              hintText: widget.customHintText == true
                  ? widget.hintText
                  : 'O que você está procurando?',
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
