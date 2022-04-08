import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todos/features/auth/bloc/login_cubit/login_cubit.dart';
import 'package:flutter_todos/features/auth/repository/auth_repository.dart';
import 'package:flutter_todos/features/auth/widgets/linear_gradient_background.dart';
import 'package:flutter_todos/features/auth/widgets/login_form/login_form.dart';

/// The Login Screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const LinearGradientBackground(),
          SafeArea(
            /// Provide the LoginCubit to the LoginForm.
            child: BlocProvider(
              create: (context) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: const CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  _LoginHeader(),
                  _MainBody(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Login With Google Icon Button.
class _LoginWithGoogle extends StatelessWidget {
  const _LoginWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(-2, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: SvgPicture.asset('assets/images/auth/google.svg'),
      ),
    );
  }
}

/// Sign In With Apple Icon Button.
class _SignInWithApple extends StatelessWidget {
  const _SignInWithApple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(-2, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Theme.of(context).brightness == Brightness.light
            ? SvgPicture.asset('assets/images/auth/apple.svg')
            : SvgPicture.asset('assets/images/auth/apple-white.svg'),
      ),
    );
  }
}

/// The Header of the Login Screen.
class _LoginHeader extends StatelessWidget {
  const _LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 275,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 275,
              width: MediaQuery.of(context).size.width - 20,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/images/auth/joblist.png',
                  fit: BoxFit.contain),
            )
          ],
        ),
      ),
    );
  }
}

/// The Main Body of the Login Screen.
/// The Main Body contains the [LoginForm], the [_LoginWithGoogle]
/// and [_SignInWithApple] (if the platform is iOS).
class _MainBody extends StatelessWidget {
  const _MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(
              height: 16,
            ),
            const LoginForm(),
            Text(
              'Or continue with',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            Divider(
              height: 32,
              thickness: 3,
              indent: MediaQuery.of(context).size.width / 3,
              endIndent: MediaQuery.of(context).size.width / 3,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const _LoginWithGoogle(),
                Platform.isIOS ? const _SignInWithApple() : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
