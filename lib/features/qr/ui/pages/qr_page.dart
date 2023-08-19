import 'package:audioplayers/audioplayers.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/strings/enum_manager.dart';
import 'package:qr_mobile_vision_example/core/widgets/images/image_multi_type.dart';
import 'package:qr_mobile_vision_example/core/widgets/my_button.dart';
import 'package:qr_mobile_vision_example/core/widgets/spinner_widget.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/service/members_service.dart';
import '../../../../core/util/my_style.dart';
import '../../../buses/data/response/buses_response.dart';
import '../../bloc/send_report_cubit/send_report_cubit.dart';
import '../../data/request/report_request.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key, required this.item, required this.spinnerItem})
      : super(key: key);

  final CheckTripResult item;
  final SpinnerItem spinnerItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'اسم الباص',
                color: Colors.black,
              ),
              DrawableText(
                text: spinnerItem.name ?? '',
                fontFamily: FontManager.cairoBold,
                size: 20.0.sp,
              ),
              20.0.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => SendReportCubit(),
                          child: QRViewExample(result: item),
                        );
                      },
                    ),
                  );
                },
                child: const Text('ابدأ المسح'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key, required this.result}) : super(key: key);

  final CheckTripResult result;

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

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _onQRViewCreated(),
      ),
    );
  }

  Widget _onQRViewCreated() {
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      child: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.all(15.0).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20.0.r),
              ),
              child: QrCamera(
                onError: (context, error) => Text(
                  error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
                qrCodeCallback: (code) {
                  if (waiting) return;

                  waiting = true;

                  playAudio();
                  Future.delayed(Duration(seconds: 3), () => waiting = false);

                  int? memberId = int.tryParse(code ?? '0') ?? 0;
                  if (memberId == 0) return;

                  context.read<SendReportCubit>().sendReport(
                        context,
                        request: ReportRequest(
                          busId: widget.result.busId,
                          tripId: widget.result.tripId,
                          busMemberId: memberId,
                        ),
                      );
                },
              ),
            ),
          ),
          BlocConsumer<SendReportCubit, SendReportInitial>(
            listenWhen: (previous, current) => current.statuses.isDone,
            listener: (context, state) {
              if (!state.result.isQrScaned || !state.result.isSubscribed)
                playAudio(isWarning: true);
            },
            builder: (context, state) {
              if (state.statuses == CubitStatuses.init) return 0.0.verticalSpace;

              return Container(
                height: .4.sh,
                width: 1.0.sw,
                color: !state.statuses.isDone
                    ? null
                    : (state.result.isQrScaned && state.result.isSubscribed)
                        ? null
                        : Colors.red.withOpacity(0.3),
                child: Center(
                  child: state.statuses.isLoading
                      ? MyStyle.loadingWidget()
                      : Column(
                          children: [
                            ImageMultiType(
                              url: state.result.busMember.imageUrl,
                              height: 120.0.r,
                              width: 120.0.r,
                            ),
                            DrawableText(
                              text: 'الطالب : ${state.result.busMember.fullName}',
                              fontFamily: FontManager.cairoBold,
                              color: Colors.black,
                            ),
                            30.0.verticalSpace,
                            DrawableText(
                              text: 'حالة الاشتراك ',
                              drawablePadding: 10.0.w,
                              color: Colors.black,
                              drawableStart: DrawableText(
                                text: state.result.isSubscribed ? 'مشترك' : 'غير مشترك',
                                color:
                                    state.result.isSubscribed ? Colors.green : Colors.red,
                              ),
                            ),
                            30.0.verticalSpace,
                            DrawableText(
                              text: 'حالة مسح الرمز',
                              drawablePadding: 10.0.w,
                              color: Colors.black,
                              drawableStart: DrawableText(
                                text: state.result.isQrScaned
                                    ? 'تم مسح الرمز'
                                    : 'لم يتم مسح الرمز',
                                color:
                                    state.result.isQrScaned ? Colors.green : Colors.red,
                              ),
                            ),
                            30.0.verticalSpace,
                            MyButton(
                              onTap: () => context.read<SendReportCubit>().initial(),
                              text: 'تم',
                            )
                          ],
                        ),
                ),
              );
            },
          )
        ],
      ),
    );
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
}

/*
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

 */
