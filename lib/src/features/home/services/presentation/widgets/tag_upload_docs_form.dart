import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_widgets/axle_file_picker.dart';
import 'package:axlerate/src/features/home/form_utils/input_form_constants.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagUploadDocsForm extends ConsumerWidget {
  const TagUploadDocsForm({
    super.key,
    required this.idProofController,
    required this.addressProofController,
    required this.orgEnrollId,
    required this.idUrlController,
    required this.addressUrlController,
  });

  final TextEditingController idProofController;
  final TextEditingController addressProofController;
  final TextEditingController addressUrlController;
  final TextEditingController idUrlController;
  final String orgEnrollId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    // bool isIdUploaded = false;
    // bool isAddressUploaded = false;

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Wrap(
        runSpacing: 20.0,
        spacing: 60.0,
        children: [
          AxleFilePicker(
            customWidth: isMobile ? screenWidth : 420,
            labelText: InputFormConstants.docFieldIdProof,
            isRequiredField: true,
            controller: idProofController,
            isEnabled: idProofController.text != 'Identity Proof',
            validate: (val) {
              if (idProofController.text.isEmpty) {
                return 'Document Required';
              } else {
                return null;
              }
            },
            onPress: () async {
              idProofController.text = 'Uploading...';

              final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(
                ref,
                docType: 'organization/doc',
                orgEnrollId: orgEnrollId,
                allowPdf: true,
              );
              if (document != null) {
                idProofController.text = document['name'] ?? '';
                idUrlController.text = document['url'] ?? '';
              } else {
                idProofController.clear();
              }
            },
          ),
          AxleFilePicker(
            customWidth: isMobile ? screenWidth : 420,
            labelText: InputFormConstants.docFieldAddressproof,
            isRequiredField: true,
            controller: addressProofController,
            validate: (val) {
              if (addressProofController.text.isEmpty) {
                return 'Document required';
              } else {
                return null;
              }
            },
            isEnabled: addressProofController.text != 'Address Proof',
            onPress: () async {
              addressProofController.text = 'Uploading...';

              final Map<String, String>? document = await FileUploadUtil.pickImagefromGallery(ref,
                  docType: 'organization/doc', orgEnrollId: orgEnrollId, allowPdf: true);
              if (document != null) {
                addressProofController.text = document['name']!;
                addressUrlController.text = document['url']!;
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
    );
  }
}
