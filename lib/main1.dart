// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:qr_mobile_vision/qr_camera.dart';
//
// void main() {
//   debugPaintSizeEnabled = false;
//   runApp(HomePage());
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   HomeState createState() => HomeState();
// }
//
// class HomeState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: MyApp());
//   }
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String? qr;
//
//   bool dirState = false;
//
//   @override
//   initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plugin example app'),
//       ),
//       body: SizedBox.expand(
//         child: QrCamera(
//           onError: (context, error) => Text(
//             error.toString(),
//             style: TextStyle(color: Colors.red),
//           ),
//           cameraDirection: CameraDirection.FRONT,
//           qrCodeCallback: (code) {
//             setState(() {
//               qr = code;
//             });
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               border: Border.all(
//                 color: Colors.orange,
//                 width: 10.0,
//                 style: BorderStyle.solid,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
