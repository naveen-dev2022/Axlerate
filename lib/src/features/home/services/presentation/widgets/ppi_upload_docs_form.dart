import 'package:axlerate/app_util/extensions/extensions.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/features/home/services/domain/add_ppi_service_input_mode.dart';
import 'package:axlerate/src/features/home/services/presentation/controller/add_ppi_service_controller.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PpiUploadDocsForm extends ConsumerWidget {
  const PpiUploadDocsForm({
    super.key,
    required this.idProofController,
    required this.addressProofController,
    required this.orgEnrollId,
    this.isEditable = false,
  });

  final TextEditingController idProofController;
  final TextEditingController addressProofController;
  final String orgEnrollId;
  final bool isEditable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // log('Id Text -> 2 ${idProofController.text}');
    // log('ADDR Text -> 2 ${addressProofController.text}');
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    // bool isIdUploaded = false;
    // bool isAddressUploaded = false;

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: AbsorbPointer(
        absorbing: !isEditable,
        child: Wrap(
          runSpacing: 20.0,
          spacing: 60.0,
          children: [
            AxleFilePicker(
              showToolTip: true,
              toolTipText: 'The document should be uploaded only in pdf format and should not exceed 1MB in size',
              customWidth: isMobile ? screenWidth : 420,
              labelText: InputFormConstants.docFieldIdProof,
              isRequiredField: true,
              controller: idProofController,
              isEnabled: idProofController.text != 'Identity Proof',
              validate: (val) {
                if (idProofController.text.isEmpty) {
                  return 'Please upload ID Proof';
                }
                return null;
              },
              onPress: () async {
                // log('Status -> ID PROOF ${idProofController.text == 'Identity Proof'}');

                // if (idProofController.text == 'Identity Proof') {
                //   return;
                // }
                idProofController.text = 'Uploading...';

                final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                  ref,
                  docType: 'organization/doc',
                  orgEnrollId: orgEnrollId,
                  allowPdf: true,
                  onlyPdf: true,
                  axleFileType: FileType.custom,
                );
                if (document != null) {
                  ref.read(ppiDocumentProvider.notifier).addItem(
                        EnbalePpiServiceKycDocument(
                          name: "IDENTITY_PROOF",
                          url: document['url']!.getTillDoc,
                        ),
                      );
                  idProofController.text = document['name']!;
                } else {
                  idProofController.clear();
                }
              },
            ),
            AxleFilePicker(
              showToolTip: true,
              toolTipText: 'The document should be uploaded only in pdf format and should not exceed 1MB in size',
              customWidth: isMobile ? screenWidth : 420,
              labelText: InputFormConstants.docFieldAddressproof,
              isRequiredField: true,
              controller: addressProofController,
              validate: (val) {
                if (addressProofController.text.isEmpty) {
                  return 'Please upload Address Proof';
                }
                return null;
              },
              isEnabled: addressProofController.text != 'Address Proof',
              onPress: () async {
                if (addressProofController.text == 'Address Proof') {
                  return;
                }
                // log('Status -> ID PROOF ${idProofController.text == 'Identity Proof'}');

                addressProofController.text = 'Uploading...';

                final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                  ref,
                  docType: 'organization/doc',
                  orgEnrollId: orgEnrollId,
                  allowPdf: true,
                  onlyPdf: true,
                  axleFileType: FileType.custom,
                );
                if (document != null) {
                  ref.read(ppiDocumentProvider.notifier).addItem(
                        EnbalePpiServiceKycDocument(
                          name: "ADDRESS_PROOF",
                          url: document['url']!.getTillDoc,
                        ),
                      );
                  addressProofController.text = document['name']!;
                } else {
                  addressProofController.clear();
                }
              },
            ),
            // AxleFilePicker(
            //   labelText: InputFormConstants.docFieldOtherProof1,
            //   isRequiredField: false,
            //   controller: addressProofController,
            //   onPress: () async {
            //     final Map<String, String>? document =
            //         await FileUploadUtil.pickImagefromGallery(ref, docType: 'organization/doc', orgEnrollId: orgEnrollId);
            //     if (document != null) {
            //       ref.read(ppiDocumentProvider.notifier).addItem(
            //             EnbalePpiServiceKycDocument(
            //               name: "OTHER_PROFF1",
            //               url: document['url']!.getTillDoc,
            //             ),
            //           );
            //     }
            //   },
            // ),
            // AxleFilePicker(
            //   labelText: InputFormConstants.docFieldOtherProof2,
            //   isRequiredField: false,
            //   controller: addressProofController,
            //   onPress: () async {
            //     final Map<String, String>? document =
            //         await FileUploadUtil.pickImagefromGallery(ref, docType: 'organization/doc', orgEnrollId: orgEnrollId);
            //     if (document != null) {
            //       ref.read(ppiDocumentProvider.notifier).addItem(
            //             EnbalePpiServiceKycDocument(
            //               name: "OTHER_PROFF2",
            //               url: document['url']!.getTillDoc,
            //             ),
            //           );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
