import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          collapsedHeight: AppBar().preferredSize.height,
          expandedHeight: AppBar().preferredSize.height,
          title: Text('Auth'),
        ),
        SliverFillRemaining()
      ],
    ));
  }
}
