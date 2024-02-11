import 'package:audioplayers/audioplayers.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/features/qr/bloc/scan_cubit/scan_cubit.dart';
import 'package:qr_mobile_vision_example/generated/assets.dart';

import '../../../../core/api_manager/command.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/service/members_service.dart';
import '../../../../core/service/report_request_service.dart';
import '../../../../core/util/my_style.dart';
import '../../../auth/bloc/home1_cubit/home1_cubit.dart';
import '../../../super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../bloc/send_report_cubit/send_report_cubit.dart';
import '../../data/request/report_request.dart';
import '../../data/response/scan_code_model.dart';
import 'package:wakelock/wakelock.dart';

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

  bool dirState = true;

  final qrKey = GlobalKey(debugLabel: 'QR');

  var stream = Stream.periodic(const Duration(minutes: 60));

  @override
  void initState() {
    stream.takeWhile((element) {
      return true;
    }).listen(
          (event) {
        if (!mounted) return;
        context.read<AllSuperUsersCubit>().getSuperUsers(
          context,
          command: Command.noPagination(),
        );
      },
    );
    Wakelock.enable();
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
      child: BlocListener<AllSuperUsersCubit, AllSuperUsersInitial>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Scaffold(
              body: Row(
                children: [
                  Expanded(child: _onQRViewCreated()),
                  BlocBuilder<ScanCubit, ScanInitial>(
                    builder: (context, state) {
                      return Expanded(
                        child: Container(
                          color: state.result.state ? null : Colors.red.withOpacity(0.3),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RoundImageWidget(
                                    height: 200.0.r,
                                    width: 200.0.r,
                                    url: state.result.image.isEmpty
                                        ? Assets.iconsAlphaLogoBackground
                                        : state.result.image,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (state.result.name.isEmpty)
                                            return DrawableText(
                                              text: 'QR يرجى مسح رمز ال ',
                                              size: 40.0.spMin,
                                              color: Colors.black,
                                            );
                                          else
                                            return Column(
                                              children: [
                                                DrawableText(
                                                  text: 'مرحبا ${state.result.name}',
                                                  size: 40.0.spMin,
                                                  fontFamily: FontManager.cairoBold,
                                                  color: Colors.black,
                                                ),
                                                30.0.verticalSpace,
                                                DrawableText(
                                                  text: 'شكرا لاستخدامك خدمة قريب ',
                                                  size: 50.0.spMin,
                                                  color: Colors.black,
                                                ),
                                                30.0.verticalSpace,
                                                DrawableText(
                                                  text: 'حالة الاشتراك ',
                                                  size: 50.0.spMin,
                                                  drawablePadding: 10.0.w,
                                                  color: Colors.black,
                                                  drawableStart: DrawableText(
                                                    text: state.result.state
                                                        ? 'مشترك'
                                                        : 'غير مشترك',
                                                    size: 60.0.spMin,
                                                    color: state.result.state
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              ],
                                            );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _onQRViewCreated() {
    return SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RoundImageWidget(
                      url: Assets.iconsLogo,
                      height: 200.0.r,
                      width: 200.0.r,
                    ),
                    20.0.horizontalSpace,
                    BlocBuilder<Home1Cubit, Home1Initial>(
                      buildWhen: (p, c) => c.statuses.isDone,
                      builder: (context, state) {
                        return RoundImageWidget(
                          url: state.result.imageUrl,
                          height: 200.0.r,
                          width: 200.0.r,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.all(15.0).r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20.0.r),
                ),
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

                      waiting = true;

                      final model = convertFromString(code);

                      Future.delayed(Duration(seconds: 3), () => waiting = false);

                      if (model == null) return;

                      context.read<ScanCubit>().initCode(model: model);

                      sl<RequestsService>().addToRequests(
                        ReportRequest(
                          busMemberId: model.id,
                          date: DateTime.now(),
                        ),
                      );

                      context.read<SendReportCubit>().sendReport(context);

                      if (model.state) {
                        playAudio();
                      } else {
                        playAudio(isWarning: true);
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }

  final audioPlayer = AudioPlayer();

  Future<void> playAudio({bool isWarning = false}) async {
    audioPlayer.play(AssetSource('sounds/${isWarning ? 'warning_beeping' : 'peen'}.mp3'));

    if (isWarning) {
      Future.delayed(
        Duration(seconds: 2),
            () => audioPlayer.play(AssetSource('sounds/warning_beeping.mp3')),
      );
    }
  }

  @override
  void dispose() {
    // controller?.dispose();
    Wakelock.disable();
    super.dispose();
  }
}
