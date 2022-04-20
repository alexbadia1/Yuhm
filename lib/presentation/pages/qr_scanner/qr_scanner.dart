import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatelessWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MobileScannerController cameraController = MobileScannerController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
              color: Colors.black,
          ),
          onPressed: () {
            BlocProvider.of<AppPageViewCubit>(context).jumpToHomePage();
          },
        ),
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          'Looking for QR Code...',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front, color: Colors.black);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear, color: Colors.black);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        allowDuplicates: false,
        controller: cameraController,
        onDetect: (barcode, args) {
          final String code = barcode.rawValue!;
          debugPrint('Barcode found! $code');
        },
      ),
    );
  }
}
