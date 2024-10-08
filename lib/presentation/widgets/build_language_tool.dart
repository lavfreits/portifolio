import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../container/bloc_container.dart';
import '../../design_system.dart';
import '../../model/localization.dart';

class BuildLanguageTool extends StatefulWidget {
  final void Function(String) onTap;
  final Localization i18n;

  const BuildLanguageTool({
    super.key,
    required this.onTap,
    required this.i18n,
  });

  @override
  State<BuildLanguageTool> createState() => _BuildLanguageToolState();
}

class _BuildLanguageToolState extends State<BuildLanguageTool> {
  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return BlocBuilder<CurrentLocaleCubit, String>(
      builder: (context, locale) {
        return ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          isSelected: [locale == 'pt-br', locale == 'en'],
          onPressed: (index) {
            final newLocale = index == 0 ? 'pt-br' : 'en';

            widget.onTap(newLocale);
          },
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'PT-BR',
                style: TextStyle(
                  color: locale == 'pt-br' ? design.primary500 : design.white,
                  fontWeight: locale == 'pt-br' ? FontWeight.w600 : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'EN',
                style: TextStyle(
                  color: locale == 'en' ? design.primary500 : design.white,
                  fontWeight: locale == 'en' ? FontWeight.w600 : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
