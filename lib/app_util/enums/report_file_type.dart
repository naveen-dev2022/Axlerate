enum ReportFileType { pdf, csv }

extension ReportFileTypeExtension on ReportFileType {
  static const names = {
    ReportFileType.pdf: 'PDF',
    ReportFileType.csv: 'CSV',
  };

  static const apiNames = {
    ReportFileType.pdf: 'PDF',
    ReportFileType.csv: 'CSV',
  };

  static const mimeTypes = {
    ReportFileType.pdf: 'application/pdf',
    ReportFileType.csv: 'text/csv',
  };

  String get text => names[this]!;
  String get apiText => apiNames[this]!;
  String get mimeType => mimeTypes[this]!;

  ReportFileType reportFileType(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return ReportFileType.pdf;
      case 'csv':
        return ReportFileType.csv;
      default:
        throw ("Unknown FileType");
    }
  }
}
