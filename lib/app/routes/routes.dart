import 'package:flutter/material.dart';
import 'package:screening_tools_android/resources/pages/authentication/forgot_password_page.dart';
import 'package:screening_tools_android/resources/pages/authentication/login_page.dart';
import 'package:screening_tools_android/resources/pages/authentication/register_page.dart';
import 'package:screening_tools_android/resources/pages/error/error_page.dart';
import 'package:screening_tools_android/resources/pages/home/home_page.dart';
import 'package:screening_tools_android/resources/pages/maintanance/maintanance_page.dart';
import 'package:screening_tools_android/resources/pages/maintanance/request_update_page.dart';
import 'package:screening_tools_android/resources/pages/patient/create_patient_page.dart';
import 'package:screening_tools_android/resources/pages/patient/detail_patient_page.dart';
import 'package:screening_tools_android/resources/pages/patient/patiens_page.dart';
import 'package:screening_tools_android/resources/pages/question/pain_result_page.dart';
import 'package:screening_tools_android/resources/pages/question/question_page.dart';
import 'package:screening_tools_android/resources/pages/question/score_page.dart';
import 'package:screening_tools_android/resources/pages/splash/splash_page.dart';

class Routes {
  static const String splash = '/';

  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String register = '/register';

  static const String home = '/home';
  static const String main = '/main';
  static const String patient = '/patient';
  static const String createPatient = '/patient/create';
  static const String detailPatient = '/patient/detail';

  static const String question = '/questionare-page';
  static const String score = '/questionare/score';
  static const String painResult = '/pain-result';

  static const String error = '/error';
  static const String maintanance = '/maintanance';
  static const String requestUpdate = '/request-update';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> buildRoute({required Widget page}) {
      return PageRouteBuilder(
        opaque: true,
        pageBuilder: (_, __, ___) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.easeInOut;
          final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
          return FadeTransition(
            opacity: curvedAnimation,
            child: ScaleTransition(scale: Tween<double>(begin: 0.99, end: 1.0).animate(curvedAnimation), child: child),
          );
        },
      );
    }

    Route<dynamic> buildErrorRoute() {
      return buildRoute(page: ErrorPage(message: "Invalid arguments"));
    }

    switch (settings.name) {
      case splash:
        return buildRoute(page: const SplashPage());
      case login:
        return buildRoute(page: const LoginPage());
      case forgotPassword: // <<< TAMBAH CASE INI
        return buildRoute(page: const ForgotPasswordPage());
      case register:
        return buildRoute(page: const RegisterPage());
      case home:
        return buildRoute(page: const HomePage());
      case patient:
        if (settings.arguments is! PatientArguments) return buildErrorRoute();
        final args = settings.arguments as PatientArguments;
        return buildRoute(page: PatientPage(isHistory: args.isHistory));
      case createPatient:
        return buildRoute(page: CreatePatientPageProvider());
      case detailPatient:
        if (settings.arguments is! DetailPatientArguments) return buildErrorRoute();
        final args = settings.arguments as DetailPatientArguments;
        return buildRoute(page: DetailPatientPage(patient: args.patient));
      case question:
        if (settings.arguments is! QuestionArguments) return buildErrorRoute();
        final args = settings.arguments as QuestionArguments;
        return buildRoute(page: QuestionPageProvider(args: args));
      case score:
        if (settings.arguments is! ScoreArguments) return buildErrorRoute();
        final args = settings.arguments as ScoreArguments;
        return buildRoute(page: ScorePage(question: args.question, patient: args.patient, sbjScore: args.sbjScore, peScore: args.peScore));
      case painResult:
        if (settings.arguments is! PainResultArguments) return buildErrorRoute();
        final args = settings.arguments as PainResultArguments;
        return buildRoute(page: PainResultPage(patient: args.patient));
      case error:
        if (settings.arguments is! ErrorArguments) return buildErrorRoute();
        final args = settings.arguments as ErrorArguments;
        return buildRoute(page: ErrorPage(message: args.message, code: args.code));
      case maintanance:
        return buildRoute(page: const MaintanancePage());
      case requestUpdate:
        return buildRoute(page: const RequestUpdatePage());
      default:
        return buildRoute(page: ErrorPage(message: "Route not found", code: 404));
    }
  }
}
