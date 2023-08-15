import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/util/note_message.dart';
import 'package:qr_mobile_vision_example/generated/assets.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/service/members_service.dart';
import '../../../../core/service/report_request_service.dart';
import '../../../../core/util/my_style.dart';
import '../../../super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../bloc/send_report_cubit/send_report_cubit.dart';
import '../../data/request/report_request.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllSuperUsersCubit, AllSuperUsersInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              child: const Text('start Scan'),
            ),
          );
        },
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var waiting = false;

  ///member service
  final usersService = sl<UsersService>();

  ///result Qr Scan
  // Barcode? result;

  ///qr controller
  // QRViewController? controller;

  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // }
    // controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendReportCubit, SendReportInitial>(
      listener: (context, state) {
        // if (state.statuses.isLoading) {
        //   waiting = true;
        // } else {
        //   waiting = false;
        // }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _onQRViewCreated(),
        ),
      ),
    );
  }

  var s = '';

  final audioPlayer = AudioPlayer();

  Widget _onQRViewCreated() {
    return SizedBox.expand(
        child: Column(
      children: [
        Expanded(
          child: Transform.rotate(
            angle: 3.14,
            child: QrCamera(
              onError: (context, error) => Text(
                error.toString(),
                style: TextStyle(color: Colors.red),
              ),
              cameraDirection: CameraDirection.FRONT,
              qrCodeCallback: (code) {
                if (waiting) return;
                loggerObject.wtf(code);

                waiting = true;
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: Container(
                    height: 300.0.h,
                    width: 1.0.sw,
                    alignment: Alignment.center,
                    child: MyStyle.loadingWidget(),
                  ),
                );
                Future.delayed(
                  Duration(seconds: 5),
                  () {
                    waiting = false;
                    Navigator.pop(context);
                  },
                );

                sl<RequestsService>().addToRequests(
                  ReportRequest(
                      busMemberId: int.tryParse(code ?? '') ?? 0, date: DateTime.now()),
                );

                context.read<SendReportCubit>().sendReport(context);

                playAudio(isWarning: true);
                if (usersService.usersIds.contains(code)) {
                  playAudio();
                } else {}
              },
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> playAudio({bool isWarning = false}) async {
    audioPlayer.play(AssetSource('sounds/${isWarning ? 'warning_beeping' : 'peen'}.mp3'));
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}
