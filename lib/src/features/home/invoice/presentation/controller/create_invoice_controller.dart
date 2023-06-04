import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axlerate/src/network/api_helper.dart';
import 'package:axlerate/src/utils/snackbar_util.dart';
import 'package:axlerate/src/features/home/invoice/data/invoice_repository.dart';
import 'package:axlerate/src/features/home/invoice/domain/dynamic_field_model.dart';
import 'package:axlerate/src/features/home/invoice/domain/create_invoice_input_model.dart';

final invoiceDateProvider = StateProvider<DateTime?>((ref) {
  return null;
});

final showShippingAddress = StateProvider<bool>((ref) {
  return false;
});

final showGST = StateProvider<bool>((ref) {
  return false;
});

final totalCGST = StateProvider<double>((ref) {
  return 0.00;
});

final totalSGST = StateProvider<double>((ref) {
  return 0.00;
});

final totalAmount = StateProvider<int>((ref) {
  return 1;
});

final totalProductFieldsList = StateProvider<List<List<TextEditingController>>>((ref) {
  return [];
});

final showProductRowList = StateProvider<bool>((ref) {
  return true;
});

final showChargesAndDiscounts = StateProvider<bool>((ref) {
  return false;
});

final showDiscountsColumn = StateProvider<bool>((ref) {
  return false;
});

final discountsTypeList = StateProvider<List<IconData>>((ref) {
  return [];
});

final mainDiscountsType = StateProvider<IconData>((ref) {
  return Icons.percent;
});

final showDiscountOnTotal = StateProvider<bool>((ref) {
  return false;
});

final discountOnTotalList = StateProvider<List<AdditionalChargesModel>>((ref) {
  return [];
});

final discountOnTotalTypeList = StateProvider<List<IconData>>((ref) {
  return [];
});

final showAdditionalCharges = StateProvider<bool>((ref) {
  return false;
});

final additionalChargesList = StateProvider<List<AdditionalChargesModel>>((ref) {
  return [];
});

final additionalChargesDiscountTypeList = StateProvider<List<IconData>>((ref) {
  return [];
});

final roundOffTotalType = StateProvider<String>((ref) {
  return '';
});

final roundOffDiffController = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final tempOverAllTotal = StateProvider<double>((ref) {
  return 1.00;
});

final finalOverAllTotal = StateProvider<double>((ref) {
  return 1.00;
});

final showTotalInWords = StateProvider<bool>((ref) {
  return false;
});

final totalInWordsController = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final showTermsAndCondition = StateProvider<bool>((ref) {
  return false;
});

final termsAndConditionList = StateProvider<List<TextEditingController>>((ref) {
  return [];
});

final showNotes = StateProvider<bool>((ref) {
  return false;
});

final showAttachments = StateProvider<bool>((ref) {
  return false;
});

final attachmentsFileList = StateProvider<List<Image>>((ref) {
  return [];
});

final showAdditionalInfo = StateProvider<bool>((ref) {
  return false;
});

final additionalInfoList = StateProvider<List<AdditionalInfoModel>>((ref) {
  return [AdditionalInfoModel(fieldName: TextEditingController(), value: TextEditingController())];
});

final showContactDetails = StateProvider<bool>((ref) {
  return false;
});

final showAddSignature = StateProvider<bool>((ref) {
  return false;
});

final signatureFileList = StateProvider<List<Image>>((ref) {
  return [];
});

final showSignatureLabel = StateProvider<bool>((ref) {
  return false;
});

final recurringInvoice = StateProvider<bool>((ref) {
  return false;
});

final invoiceControllerProvider = Provider<InvoiceController>((ref) {
  return InvoiceController(ref);
});

class InvoiceController {
  const InvoiceController(this.ref);
  final Ref ref;

  //Create Invoice
  Future<bool> fetchCreateInvoice(CreateInvoiceInputModel formInput) async {
    print('#####----99999----Controller');
    try {
      await ref.read(invoiceRepositoryProvider).createInvoice(formInput: formInput);
      Snackbar.success('Invoice Created Successfully');
      print('#####-----success');
      return true;
    } catch (e) {
      Snackbar.error(ApiHelper.getErrorMessage(e));
      print('#####-----error');
      return false;
    }
  }
}
