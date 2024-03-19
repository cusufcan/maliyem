import 'package:gelir_gider_takibi/constant/enum/transfer_error_enum.dart';
import 'package:gelir_gider_takibi/constant/index.dart';

String getTransferErrorMsg(TransferError error) {
  String errorMessage = BaseString.transferSuccess;
  switch (error) {
    case TransferError.accountNotFound:
      errorMessage = BaseString.accountNotFound;
      break;
    case TransferError.accountBalanceIsNotEnough:
      errorMessage = BaseString.accountBalanceIsNotEnough;
      break;
    case TransferError.accountIsSame:
      errorMessage = BaseString.accountIsSame;
      break;
    default:
  }

  return errorMessage;
}
