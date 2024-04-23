import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/appbar/custom_app_bar.dart';
import '../../../../utils/constants/string_const.dart';
import '../cubit/ticket_cubit.dart';

class ScanTicketPage extends StatelessWidget {
  const ScanTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      builder: (ctx, state) {
        final isTorchOn = state.isTorchOn;
        // final mobileScannerController = state.mobileScannerController;

        return Scaffold(
          appBar: CustomAppBar(
            hasBackButton: true,
            title: const Text(StringConst.scanTicket),
            actions: [
              Switch.adaptive(
                value: isTorchOn,
                onChanged: (value) async {
                  await context.read<TicketCubit>().toggleTorchSwitch(value);
                },
              ),
            ],
          ),
          // body: MobileScanner(
          //   controller: mobileScannerController,
          //   onDetect: (capture) async {
          //     final List<Barcode> barcodes = capture.barcodes;
          //     String ticketId = '';
          //     // final Uint8List? image = capture.image;
          //     for (final barcode in barcodes) {
          //       final qrCodeValue = '${barcode.rawValue}';

          //       debugPrint('QR Code found: $qrCodeValue');
          //       ticketId = qrCodeValue;
          //     }

          //     await context
          //         .read<TicketCubit>()
          //         .scanTicket(context: context, ticketId: ticketId);
          //   },
          // ),
        );
      },
    );
  }
}
