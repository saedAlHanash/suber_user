import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
import 'package:qr_mobile_vision_example/core/strings/app_color_manager.dart';
import 'package:qr_mobile_vision_example/core/widgets/app_bar_widget.dart';
import 'package:qr_mobile_vision_example/core/widgets/images/image_multi_type.dart';
import 'package:qr_mobile_vision_example/core/widgets/my_button.dart';
import 'package:qr_mobile_vision_example/core/widgets/spinner_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../auth/bloc/home1_cubit/home1_cubit.dart';
import '../../../buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../../buses/bloc/check_active_trip_cubit/check_active_trip_cubit.dart';
import '../../../qr/bloc/send_report_cubit/send_report_cubit.dart';
import '../../../qr/ui/pages/qr_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SpinnerItem? selected;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckTripCubit, CheckTripInitial>(
      listenWhen: (p, c) => c.statuses.isDone,
      listener: (context, state) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => SendReportCubit(),
                child: QRViewExample(result: state.result),
              );
            },
          ),
        );
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              BlocBuilder<Home1Cubit, Home1Initial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return ImageMultiType(
                    url: state.result.imageUrl,
                    height: 120.0.spMin,
                    width: 120.0.spMin,
                  );
                },
              ),
              BlocBuilder<AllBusesCubit, AllBusesInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }

                  return SpinnerWidget(
                    items: state.getSpinnerItem,
                    hint: const DrawableText(
                        text: 'اختر الباص', color: AppColorManager.gray),
                    onChanged: (item) => selected = item,
                  );
                },
              ),
              Spacer(),
              BlocBuilder<CheckTripCubit, CheckTripInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }

                  return MyButton(
                    onTap: () {
                      if (selected == null) return;
                      context.read<CheckTripCubit>().checkTrip(context, item: selected!);
                    },
                    text: 'تحقق من الباص',
                  );
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
