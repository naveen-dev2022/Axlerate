// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:axlerate/Themes/axle_colors.dart';
import 'package:axlerate/app_util/enums/org_type.dart';
import 'package:axlerate/responsive.dart';
import 'package:axlerate/src/common/common_constants/common_list.dart';
import 'package:axlerate/src/common/common_widgets/axle_form_text_field.dart';
import 'package:axlerate/src/common/common_widgets/axle_primary_button.dart';
import 'package:axlerate/src/common/common_widgets/axle_search_dropdown_field.dart';
import 'package:axlerate/src/features/home/services/domain/get_payment_link_doc_type.dart';
import 'package:axlerate/src/utils/axle_loader.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_controller.dart';
import 'package:axlerate/src/utils/doc_upload/file_upload_util.dart';
import 'package:axlerate/src/utils/form_validators.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../common/common_widgets/axle_file_picker.dart';

class DocNameFieldWidget extends ConsumerWidget {
  DocNameFieldWidget({
    super.key,
    required this.docNameController,
    required this.urlController,
    required this.nameLable,
    required this.nameHint,
    required this.docNameLable,
    required this.docNameHint,
    this.isRequired = false,
    required this.orgEnrollId,
    required this.docType,
    this.showAddButton = true,
    this.isApproved = false,
    this.onAddTap,
    this.onPress,
    this.orgType,
    required this.isEditable,
  });

  TextEditingController docNameController;
  final TextEditingController urlController;
  final String nameLable;
  final String nameHint;
  final String docNameLable;
  final String docNameHint;
  final bool isRequired;
  final String orgEnrollId;
  final String docType;
  final bool showAddButton;
  final VoidCallback? onAddTap;
  final bool isApproved;
  void Function()? onPress;
  final OrgType? orgType;
  final bool isEditable;

  final TextEditingController nameController = TextEditingController();

  bool isMobile = false;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    isMobile = Responsive.isMobile(context);
    screenWidth = MediaQuery.of(context).size.width;

    return Wrap(
      runSpacing: defaultPadding,
      spacing: defaultPadding,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // : docNameController.text.isNotEmpty
        //     ? AxleFormTextField(
        //         fieldHeading: nameLable,
        //         fieldHint: nameHint,
        //         fieldController: TextEditingController(
        //           text: GetDocType.getInvoiceDocNameUserView(docNameController.text),
        //         ),
        //         fieldWidth: isMobile ? screenWidth : 420,
        //         isFieldEnabled: false,
        //       )

        isEditable || !isApproved
            ? AxleSearchDropDownField(
                fieldHeading: nameLable,
                fieldHint: docNameController.text.isNotEmpty ? '' : nameHint,
                fieldController: docNameController.text.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: GetDocType.getInvoiceDocNameUserView(docNameController.text)),
                fieldWidth: isMobile ? screenWidth : 440,
                validate: isRequired ? Validators(nameLable).required() : null,
                dropDownOptions: invoiceDocsList,
                isRequired: isRequired,
                onChanged: (val) {
                  log("message");
                  docNameController.text = GetDocType.getInvoiceDocName(val);
                },
              )
            : AxleFormTextField(
                fieldHeading: nameLable,
                fieldHint: nameHint,
                fieldController: docNameController,
                fieldWidth: isMobile ? screenWidth : 420,
                isFieldEnabled: false,
              ),

        const SizedBox(
          height: 25,
        ),

        isEditable || !isApproved
            ? AxleFilePicker(
                customWidth: isMobile ? screenWidth : 320,
                labelText: docNameLable,
                isRequiredField: isRequired,
                controller: urlController.text.isNotEmpty ? TextEditingController(text: "UPLOADED") : nameController,
                hintText: docNameHint,
                validate: isRequired
                    ? (val) {
                        if (TextEditingController().text.isEmpty) {
                          return 'Document is Required';
                        }
                        return null;
                      }
                    : null,
                onPress: isEditable || !isApproved
                    ? () async {
                        nameController.text = 'Uploading...';
                        Map<String, String>? imageData = await FileUploadUtil.pickImagefromGallery(
                          ref,
                          docType: docType,
                          orgEnrollId: orgEnrollId,
                          showSuccessSnackbar: true,
                        );
                        nameController.text = imageData?['name'] ?? '';
                        urlController.text = imageData?['url'] ?? '';
                      }
                    : null,
              )
            : AxleFormTextField(
                fieldHeading: docNameLable,
                fieldHint: docNameHint,
                fieldController: TextEditingController(text: "UPLOADED"),
                fieldWidth: isMobile ? screenWidth : 420,
                isFieldEnabled: false,
              ),
        if (isApproved && orgType == OrgType.axlerate)
          IconButton(
            icon: const Icon(Icons.download),
            style: ElevatedButton.styleFrom(backgroundColor: AxleColors.axlePrimaryColor),
            onPressed: () async {
              AxleLoader.show(context);
              String res =
                  await ref.read(fileUploadControllerProvider).fileDownloadSignedUrl(urlStr: urlController.text);
              _launchUrl(res);
              AxleLoader.hide();
            },
          ),

        if (isEditable || !isApproved) AxlePrimaryButton(buttonText: 'Remove', onPress: onPress),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    // html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    // anchorElement.download = url;
    // anchorElement.click();

    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {}
  }
}
