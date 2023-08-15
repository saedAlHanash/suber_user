// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qr_mobile_vision_example/core/extensions/extensions.dart';
// import 'package:qr_mobile_vision_example/core/widgets/images/round_image_widget.dart';
// import 'package:qr_mobile_vision_example/router/go_route_pages.dart';
//
// import '../../../../core/util/my_style.dart';
// import '../../../../core/widgets/my_card_widget.dart';
// import '../../bloc/all_super_users_cubit/all_super_users_cubit.dart';

// 
//
// class ItemSuperUsers extends StatelessWidget {
//   const ItemSuperUsers({super.key, required this.item});
//
//   final SuperUserModel item;
//
//   @override
//   Widget build(BuildContext context) {
//     return MyCardWidget(
//       margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
//       child: Row(
//         children: [
//           RoundImageWidget(
//             url: item.imageUrl,
//             height: 70.0.r,
//             width: 70.0.r,
//           ),
//           10.0.horizontalSpace,
//           Expanded(
//             child: Column(
//               children: [
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.name,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               context.pushNamed(GoRouteName.createSuperUsers, extra: item);
//             },
//             icon: const Icon(
//               Icons.edit,
//               color: Colors.amber,
//             ),
//           ),
//           BlocConsumer<DeleteSuperUsersCubit, DeleteSuperUsersInitial>(
//             listener: (context, state) {
//               context.read<AllSuperUsersCubit>().getSuperUsers(context);
//             },
//             listenWhen: (p, c) => c.statuses.done,
//             buildWhen: (p, c) => c.id == item.id,
//             builder: (context, state) {
//               if (state.statuses.loading) {
//                 return MyStyle.loadingWidget();
//               }
//               return IconButton(
//                 onPressed: () {
//                   context.read<DeleteSuperUsersCubit>().deleteSuperUsers(context, id: item.id);
//                 },
//                 icon: const Icon(
//                   Icons.delete_forever,
//                   color: Colors.red,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
