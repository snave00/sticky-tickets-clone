import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../domain/entities/ticket_entity.dart';
import '../../domain/params/scan_ticket_params.dart';
import '../../domain/usecases/scan_ticket_usecase.dart';

part 'ticket_cubit.freezed.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final ScanTicketUseCase scanTicketUseCase;

  TicketCubit({
    required this.scanTicketUseCase,
  }) : super(TicketState(
          scanTicketStatus: ScanTicketStatus.initial,
          ticketEntity: TicketEntity.empty(),
          eventId: '',
          mobileScannerController: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            facing: CameraFacing.back,
          ),
          isTorchOn: false,
        ));

  void init({required String eventId}) async {
    emit(state.copyWith(eventId: eventId));
  }

  Future<void> scanTicket({
    required BuildContext context,
    required String ticketId,
  }) async {
    _loadingScanTicket();

    final result = await scanTicketUseCase.call(
      ScanTicketParams(
        ticketId: ticketId,
        eventId: state.eventId,
      ),
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            scanTicketStatus: ScanTicketStatus.failure,
            errorMessage: failure.errorMessage,
          ),
        );

        return;
      },
      (success) {
        emit(
          state.copyWith(
            scanTicketStatus: ScanTicketStatus.success,
            ticketEntity: success,
            errorMessage: '',
          ),
        );

        return;
      },
    );
  }

  Future<void> toggleTorchSwitch(bool isTorchOn) async {
    await state.mobileScannerController.toggleTorch();

    emit(state.copyWith(
      isTorchOn: isTorchOn,
    ));
  }

  void _loadingScanTicket() {
    emit(state.copyWith(
      scanTicketStatus: ScanTicketStatus.loading,
      successMessage: '',
      errorMessage: '',
    ));
  }
}
