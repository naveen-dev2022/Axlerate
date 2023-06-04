class GetDocType {
  static getInvoiceDocName(String docName) {
    switch (docName) {
      case 'Articles of Association (AOA)':
        return "ARTICLES_OF_ASSOCIATION";
      case 'Memorandum of Association (MOA)':
        return "MEMORANDUM_OF_ASSOCIATION";
      case 'Board Resolution':
        return "BOARD_RESOLUTION";
      case 'List of Directors / Partners from MCA':
        return "LIST_OF_DIRECTORS_PARTNERS";
      case 'Certification of Incorporation':
        return "INCORPORATION_CERTIFICATE";
      case 'Partnership Deed':
        return "PARTNERSHIP_DEED";
      case 'Establishment Certificate':
        return "ESTABLISHMENT_CERTIFICATE";
      case 'Registration Certificate':
        return "REGISTRATION_CERTIFICATE";
      case 'PAN of the Company/Firm':
        return "COMPANY_PAN";
      case 'GST Registration Certificate':
        return "GST_REGISTRATION_CERTIFICATE";
      case 'Undertaking of Product/Services to be Sold':
        return "UNDERTAKING";
      case 'Current Address Proof of the Company/Firm':
        return "COMPANY_ADDRESS_PROOF";
      case 'KYC of Directors / Partners':
        return "KYC_DIRECTORS_PARTNERS";
      case 'Service Agreement':
        return "SERVICE_AGREEMENT";
      case 'Cancellation Cheque':
        return "CANCELLATION_CHEQUE";
      case 'Legal Opinion document':
        return "LEGAL_OPINION_DOCUMENT";
      case 'Merchant Application Form (MAF)':
        return "MERCHANT_APPLICATION";
      case 'Bank Statement':
        return "BANK_STATEMENT";
      case 'Certificate of Commencement of Business':
        return "COMMENCENT_OF_BUSINESS_CERTIFICATE";
      case 'Others':
        return "OTHERS";
      default:
        return "OTHERS";
    }
  }

  static getInvoiceDocNameUserView(String docName) {
    switch (docName) {
      case 'ARTICLES_OF_ASSOCIATION':
        return "Articles of Association (AOA)";
      case 'MEMORANDUM_OF_ASSOCIATION':
        return "Memorandum of Association (MOA)";
      case 'BOARD_RESOLUTION':
        return "Board Resolution";
      case 'LIST_OF_DIRECTORS_PARTNERS':
        return "List of Directors / Partners from MCA";
      case 'INCORPORATION_CERTIFICATE':
        return "Certification of Incorporation";
      case 'PARTNERSHIP_DEED':
        return "Partnership Deed";
      case 'ESTABLISHMENT_CERTIFICATE':
        return "Establishment Certificate";
      case 'REGISTRATION_CERTIFICATE':
        return "Registration Certificate";
      case 'COMPANY_PAN':
        return "PAN of the Company/Firm";
      case 'GST_REGISTRATION_CERTIFICATE':
        return "GST Registration Certificate";
      case 'UNDERTAKING':
        return "Undertaking of Product/Services to be Sold";
      case 'COMPANY_ADDRESS_PROOF':
        return "Current Address Proof of the Company/Firm";
      case 'KYC_DIRECTORS_PARTNERS':
        return "KYC of Directors / Partners";
      case 'SERVICE_AGREEMENT':
        return "Service Agreement";
      case 'CANCELLATION_CHEQUE':
        return "Cancellation Cheque";
      case 'LEGAL_OPINION_DOCUMENT':
        return "Legal Opinion document";
      case 'MERCHANT_APPLICATION':
        return "Merchant Application Form (MAF)";
      case 'BANK_STATEMENT':
        return "Bank Statement";
      case 'COMMENCENT_OF_BUSINESS_CERTIFICATE':
        return "Certificate of Commencement of Business";
      case 'OTHERS':
        return "Others";
      default:
        return "OTHERS";
    }
  }
}
