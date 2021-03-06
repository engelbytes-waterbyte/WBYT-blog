import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:website/components/base_layout.dart';
import 'package:website/pages/blog.dart';
import 'package:website/resources/project.dart';
import 'package:website/resources/resource.dart';

class Projects extends StatelessWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BaseLayout(
        heading: "Projekte",
        subHeading: "Innvoation bei Waterbyte",
        headingIcon: TablerIcons.ambulance,
        quote:
            "Bei Select Queries sollte DISTINCT nicht mit die stinkt verwechselt werden",
        child: ProjectsWidget(),
      ),
    );
  }
}

class ProjectsWidget extends StatefulWidget {
  const ProjectsWidget({Key? key}) : super(key: key);

  @override
  _ProjectsWidgetState createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        FutureBuilder<List<Resource>>(
            future: fetchResource(
                resource: const Project(),
                path: "projects.json",
                mainKey: "projects"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Resource> projects = snapshot.data!.toList();
              return Column(
                children: [
                  for (var resource in projects)
                    Builder(builder: (context) {
                      final project = resource as Project;
                      return ProjectWidget(
                        name: project.name,
                        pic: project.pic,
                        description: project.description,
                        slogan: project.slogan,
                        link: project.link,
                      );
                    }),
                ],
              );
            }),
        const SizedBox(height: 40),
      ],
    );
  }
}

class ProjectWidget extends StatelessWidget {
  final String name;
  final String pic;
  final String description;
  final String link;
  final String slogan;

  const ProjectWidget({
    Key? key,
    required this.name,
    required this.pic,
    required this.description,
    required this.link,
    required this.slogan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            pic,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    slogan,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Text(description),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
