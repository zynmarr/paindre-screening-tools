import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:screening_tools_android/resources/pages/authentication/login_page.dart';
import 'package:screening_tools_android/resources/pages/authentication/register_page.dart';
import 'package:screening_tools_android/resources/pages/home/home_page.dart';
import 'package:screening_tools_android/resources/pages/maintanance/maintanance_page.dart';
import 'package:screening_tools_android/resources/pages/maintanance/request_update_page.dart';
import 'package:screening_tools_android/resources/pages/patient/create_patient_page.dart';
import 'package:screening_tools_android/resources/pages/patient/detail_patient_page.dart';
import 'package:screening_tools_android/resources/pages/patient/patiens_page.dart';
import 'package:screening_tools_android/resources/pages/question/pain_result_page.dart';
import 'package:screening_tools_android/resources/pages/question/question_page.dart';
import 'package:screening_tools_android/resources/pages/question/question_type_page.dart';
import 'package:screening_tools_android/resources/pages/question/score_page.dart';
import 'package:screening_tools_android/resources/pages/splash/splash_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    routeTransition({required Widget page}) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    }

    wrappingConnectionState({required Widget widget}) {
      return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            if (snapshot.data!.first == ConnectivityResult.none) {
              BotToast.showLoading(
                wrapAnimation: (controller, cancelFunc, widget) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      height: context.height,
                      width: context.width,
                      color: Colors.black45,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SpinKitWave(
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                          SizedBox(height: 25,),
                          Text(
                            'Please check your connection',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              BotToast.cleanAll();
            }
          }

          return widget;
        },
      );
    }

    switch (settings.name) {
      case 'splash-page':
        return routeTransition(
            page: const SplashPage());
      case 'login-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const LoginPage()));
      case 'register-page':
        return routeTransition(page: const RegisterPage());

      case 'home-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const HomePage()));
      case 'patient-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const PatientPage()));
      case 'create-patient-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const CreatePatientPage()));
      case 'detail-patient-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const DetailPatientPage()));

      case 'question-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const QuestionPage()));
      case 'question-type-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const QuestionTypePage()));
      case 'score-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const ScorePage()));
      case 'pain-result-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const PainResultPage()));

      case 'maintanance-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const MaintanancePage()));
      case 'request-update-page':
        return routeTransition(
            page: wrappingConnectionState(widget: const RequestUpdatePage()));
      default:
        return MaterialPageRoute(
            builder: (_) => Container(), settings: settings);
    }
  }
}
