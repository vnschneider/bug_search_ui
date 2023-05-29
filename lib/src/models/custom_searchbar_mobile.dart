// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBarMobile extends StatefulWidget {
  final double height;
  final double width;
  final bool? customHintText;
  final String? hintText;
  final void Function(String)? onSubmitted;
  final void Function()? onPress;
  final TextEditingController searchController;

  const CustomSearchBarMobile({
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
  State<CustomSearchBarMobile> createState() => _CustomSearchBarMobileState();
}

class _CustomSearchBarMobileState extends State<CustomSearchBarMobile> {
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {
        isTyping = widget.searchController.text.isNotEmpty;
      });
    }
  }

  void _clearText() {
    if (mounted) {
      setState(() {
        widget.searchController.clear();
        isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return //SEARCH BAR//
        Material(
      child: Container(
        height: widget.height, //62
        width: widget.width, //860
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
          //  border: Border.all(
          //    color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: widget.searchController,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              isCollapsed: true,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  isTyping
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Limpar barra de pesquisa',
                              hoverColor:
                                  Theme.of(context).colorScheme.secondary,
                              highlightColor:
                                  Theme.of(context).colorScheme.tertiary,
                              iconSize: 18,
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
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                            const SizedBox(width: 6),
                          ],
                        )
                      : const SizedBox(width: 1),
                  const SizedBox(width: 4),
                  IconButton(
                    alignment: Alignment.center,
                    tooltip: 'Pesquisar',
                    iconSize: 18,
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
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
