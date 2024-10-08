import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portifolio/presentation/widgets/project_card_list.dart';

import '../../design_system.dart';
import '../../model/project.dart';
import '../../utils.dart';
import 'dialog_content_column.dart';
import 'dialog_content_row.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final String locale;

  const ProjectCard({
    required this.project,
    super.key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return MoreDetailsDialog(
              project: project,
              locale: locale,
              design: design,
              screenSize: screenSize,
            );
          },
        );
      },
      child: Card(
        color: design.terciary500,
        child: Padding(
          padding: EdgeInsets.all(
            screenSize.width > 850
                ? 0.018 * screenSize.width
                : 0.025 * screenSize.width,
          ),
          child: !project.isWeb && screenSize.width > 400
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      project.imageUrl,
                      width: screenSize.width > 850
                          ? 0.15 * screenSize.width
                          : 0.3 * screenSize.width,
                    ),
                    SizedBox(
                        width: screenSize.width > 850
                            ? 0.025 * screenSize.height
                            : 0.02 * screenSize.height),
                    ProjectCardList(
                      project: project,
                      locale: locale,
                      openProjectDetails: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return MoreDetailsDialog(
                              project: project,
                              locale: locale,
                              design: design,
                              screenSize: screenSize,
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      project.imageUrl,
                      height: screenSize.width > 850
                          ? 0.13 * screenSize.width
                          : null,
                      width: screenSize.width < 850 && project.isWeb
                          ? 0.45 * screenSize.width
                          : screenSize.width > 900 && project.isWeb
                              ? 0.55 * screenSize.width
                              : 0.4 * screenSize.width,
                    ),
                    SizedBox(height: 0.02 * screenSize.height),
                    ProjectCardList(
                      project: project,
                      locale: locale,
                      openProjectDetails: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return MoreDetailsDialog(
                              project: project,
                              locale: locale,
                              design: design,
                              screenSize: screenSize,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MoreDetailsDialog extends StatelessWidget {
  final Project project;
  final String locale;
  final Design design;
  final Size screenSize;

  const MoreDetailsDialog({
    super.key,
    required this.project,
    required this.locale,
    required this.design,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(22),
      scrollable: true,
      backgroundColor: design.terciary500,
      title: AutoSizeText(
        project.title,
        maxFontSize: 35,
        style: design.h3(),
      ),
      content: project.isWeb
          ? DialogContentColumn(project: project)
          : screenSize.width < 850
              ? DialogContentColumn(project: project)
              : DialogContentRow(project: project),
      actions: [
        TextButton.icon(
          icon: const FaIcon(
            FontAwesomeIcons.code,
            size: 16,
          ),
          onPressed: () {
            launchURL(project.repoUrl);
          },
          label: const Text(
            'Ver Código',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Fechar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
