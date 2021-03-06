// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:website/components/base_layout.dart';
import 'package:website/pages/blog.dart';
import 'package:website/resources/resource.dart';
import 'package:website/resources/team_member.dart';

class Team extends StatelessWidget {
  const Team({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BaseLayout(
        heading: "Das Team",
        subHeading: "Unser Personal - voller Ehrgeiz und Motivation ",
        headingIcon: TablerIcons.alien,
        quote:
            "Schowieda koa as! - Select queries sollten immer mit einem AS versehen werden!",
        child: Members(),
      ),
    );
  }
}

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Text(
          "Die Gründer",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<Resource>>(
            future: fetchResource(
              resource: const TeamMember(),
              path: "team-members.json",
              mainKey: "list-member",
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Resource> listmembers = snapshot.data!
                  .where((x) => (x as TeamMember).founder)
                  .toList();
              return Wrap(
                spacing: 10.0,
                runSpacing: 20.0,
                children: [
                  for (var resource in listmembers)
                    Builder(builder: (context) {
                      final member = resource as TeamMember;
                      return Member(
                        memberDescription: member.description,
                        memberName: member.name,
                        memberPosition: member.position,
                        memberPic: member.pic,
                      );
                    }),
                ],
              );
            }),
        const SizedBox(height: 40),
        const Text(
          "Leasing",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        FutureBuilder<List<Resource>>(
            future: fetchResource(
              resource: const TeamMember(),
              path: "team-members.json",
              mainKey: "list-member",
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Resource> listmembers = snapshot.data!
                  .where((x) => !(x as TeamMember).founder)
                  .toList();
              return Wrap(
                spacing: 10.0,
                children: [
                  for (var resource in listmembers)
                    Builder(builder: (context) {
                      final member = resource as TeamMember;
                      return Member(
                        memberDescription: member.description,
                        memberName: member.name,
                        memberPosition: member.position,
                        memberPic: member.pic,
                      );
                    }),
                ],
              );
            }),
      ],
    );
  }
}

class Member extends StatelessWidget {
  final String memberName;
  final String? memberPosition;
  final String memberPic;
  final String memberDescription;

  const Member(
      {Key? key,
      required this.memberName,
      this.memberPosition,
      required this.memberPic,
      required this.memberDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              width: 400,
              child: FittedBox(
                  child: Image.network(
                    memberPic,
                  ),
                  fit: BoxFit.fill),
            ),
            Row(
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        memberName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            memberPosition ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Text(memberDescription),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
